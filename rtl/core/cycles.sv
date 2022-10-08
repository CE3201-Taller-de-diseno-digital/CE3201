`include "core/uarch.sv"

module core_cycles
(
	input  logic           clk,
	                       dec_execute,
	                       dec_branch,
	                       dec_writeback,
	                       dec_update_flags,
	input  ptr             dec_branch_offset,
	input  snd_decode      dec_snd,
	input  data_decode     dec_data,
	input  ptr             fetch_insn_pc,
	input  psr_flags       flags,
	input  word            rd_value_b,
	                       q_alu,
	                       q_shifter,
	input  logic           c_shifter,

	output logic           stall,
	                       branch,
	                       writeback,
	                       update_flags,
	                       c_in,
	output reg_num         rd,
	                       ra,
	                       rb,
	output ptr             branch_target,
	                       pc_visible,
	output psr_mode        reg_mode,
	output alu_op          alu,
	output word            alu_b,
	                       wr_value,
	output shifter_control shifter,
	output logic[7:0]      shifter_shift
);

	enum
	{
		ISSUE,
		RD_INDIRECT_SHIFT,
		WITH_SHIFT
	} cycle, next_cycle;

	logic bubble, final_writeback, final_update_flags,
	      data_snd_is_imm, data_snd_shift_by_reg, trivial_shift;

	logic[5:0] data_shift_imm;
	logic[7:0] data_imm;
	word saved_base;
	reg_num r_shift, final_rd;
	ptr pc;

	assign stall = (next_cycle != ISSUE) | bubble;
	assign pc_visible = pc + 2;
	assign reg_mode = `MODE_SVC; //TODO

	always_comb begin
		unique case(cycle)
			RD_INDIRECT_SHIFT: shifter_shift = rd_value_b[7:0];
			default:           shifter_shift = {2'b00, data_shift_imm};
		endcase

		trivial_shift = 1;
		if(final_writeback & (shifter.shl | shifter.shr | shifter.ror))
			trivial_shift = shifter_shift == 0;

		next_cycle = ISSUE;

		unique case(cycle)
			ISSUE:
				if(data_snd_shift_by_reg)
					next_cycle = RD_INDIRECT_SHIFT;
				else if(~trivial_shift)
					next_cycle = WITH_SHIFT;

			RD_INDIRECT_SHIFT:
				if(~trivial_shift)
					next_cycle = WITH_SHIFT;

			default: ;
		endcase

		if(bubble)
			next_cycle = ISSUE;

		unique case(cycle)
			ISSUE:
				if(data_snd_is_imm)
					alu_b = {{24{1'b0}}, data_imm};
				else
					alu_b = rd_value_b;

			RD_INDIRECT_SHIFT, WITH_SHIFT:
				alu_b = saved_base;
		endcase
	end

	always_ff @(posedge clk) begin
		cycle <= next_cycle;
		bubble <= 0;
		writeback <= 0;
		wr_value <= q_alu;

		unique case(next_cycle)
			ISSUE: begin
				branch <= 0;
				branch_target <= {30{1'bx}};
				final_writeback <= 0;
				final_update_flags <= 0;

				if(dec_execute & ~bubble) begin
					bubble <=
						  (dec_update_flags & update_flags)
						| (final_writeback & ((rd == dec_data.rn) | (rd == dec_snd.r)));

					branch <= dec_branch;
					branch_target <= pc_visible + dec_branch_offset;

					alu <= dec_data.op;
					ra <= dec_data.rn;

					data_snd_is_imm <= dec_snd.is_imm;
					data_snd_shift_by_reg <= dec_snd.shift_by_reg;
					data_imm <= dec_snd.imm;
					data_shift_imm <= dec_snd.shift_imm;

					shifter.shl <= dec_snd.shl;
					shifter.shr <= dec_snd.shr;
					shifter.ror <= dec_snd.ror;
					shifter.put_carry <= dec_snd.put_carry;
					shifter.sign_extend <= dec_snd.sign_extend;

					rb <= dec_snd.r;
					r_shift <= dec_snd.r_shift;
					c_in <= flags.c;

					final_rd <= dec_data.rd;
					final_writeback <= dec_writeback;
					final_update_flags <= dec_update_flags;
				end

				update_flags <= final_update_flags;
				writeback <= final_writeback;
				rd <= final_rd;
				pc <= fetch_insn_pc;
			end

			RD_INDIRECT_SHIFT: begin
				rb <= r_shift;
				data_snd_shift_by_reg <= 0;
				saved_base <= rd_value_b;
			end

			WITH_SHIFT: begin
				c_in <= c_shifter;
				saved_base <= q_shifter;
			end
		endcase
	end

	initial begin
		cycle = ISSUE;
		bubble = 0;

		pc = 0;
		c_in = 0;
		branch = 1;
		writeback = 0;
		branch_target = 30'd0;
		data_snd_shift_by_reg = 0;

		final_rd = 0;
		final_writeback = 0;
	end

endmodule
