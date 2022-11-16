`include "core/uarch.sv"

module core_control_ldst
(
	input  logic       clk,
	                   rst_n,

	input  insn_decode dec,
	input  logic       issue,
	                   mem_ready,
	input  word        rd_value_b,
	                   q_alu,

	input  ctrl_cycle  cycle,
	                   next_cycle,
	input  word        alu_a,
	                   alu_b,

	output ptr         mem_addr,
	output word        mem_data_wr,
	                   mem_offset,
	output logic       mem_start,
	                   mem_write,
	                   pop_valid,
	                   ldst,
	                   ldst_next,
	                   ldst_writeback,
	output reg_num     popped
);

	logic pre, increment;
	reg_num popped_upper, popped_lower;
	reg_list mem_regs, next_regs_upper, next_regs_lower;

	assign popped = increment ? popped_lower : popped_upper;
	assign ldst_next = !cycle.transfer || mem_ready;
	assign mem_data_wr = rd_value_b;

	core_control_ldst_pop pop
	(
		.regs(mem_regs),
		.valid(pop_valid),
		.next_upper(next_regs_upper),
		.next_lower(next_regs_lower),
		.pop_upper(popped_upper),
		.pop_lower(popped_lower)
	);

	always_ff @(posedge clk or negedge rst_n)
		if(!rst_n) begin
			pre <= 0;
			ldst <= 0;
			increment <= 0;
			ldst_writeback <= 0;

			mem_addr <= {$bits(mem_addr){1'b0}};
			mem_regs <= {$bits(mem_regs){1'b0}};
			mem_write <= 0;
			mem_start <= 0;
			mem_offset <= 0;
		end else begin
			mem_start <= 0;

			if(next_cycle.issue) begin
				// TODO: dec.ldst.unprivileged
				// TODO: byte/halfword sizes
				if(issue)
					ldst <= dec.ctrl.ldst;

				pre <= dec.ldst.pre_indexed;
				increment <= dec.ldst.increment;
				ldst_writeback <= dec.ldst.writeback;

				mem_regs <= dec.ldst.regs;
				mem_write <= !dec.ldst.load;
			end else if(next_cycle.transfer) begin
				if(!cycle.transfer) begin
					ldst <= 0;
					mem_offset <= alu_b;
				end

				if(ldst_next) begin
					mem_regs <= increment ? next_regs_lower : next_regs_upper;
					mem_addr <= pre ? q_alu[31:2] : alu_a[31:2];
				end

				mem_start <= !cycle.transfer || (mem_ready && pop_valid);
			end
		end
endmodule
