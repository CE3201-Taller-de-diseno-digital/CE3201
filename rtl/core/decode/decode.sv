`include "core/isa.sv"
`include "core/uarch.sv"

module core_decode
(
	input  word      insn,
	input  psr_flags flags,

	output logic     execute,
	                 undefined,
	                 writeback,
	                 update_flags,
	                 branch,
	output ptr       branch_offset,
	output reg_num   rd,
	output alu_op    data_op
);

	logic cond_undefined;

	//TODO
	logic link;
	ptr offset;
	core_decode_conds conds
	(
		.cond(insn `FIELD_COND),
		.undefined(cond_undefined),
		.*
	);

	logic branch_link; //TODO

	core_decode_branch group_branch
	(
		.*
	);

	//TODO
	reg_num rn;
	logic restore_spsr;

	logic data_writeback, data_update_flags;
	reg_num data_rd;
	alu_op data_group_op;

	core_decode_data group_data
	(
		.op(data_group_op),
		.rd(data_rd),
		.writeback(data_writeback),
		.update_flags(data_update_flags),
		.*
	);

	always_comb begin
		undefined = cond_undefined;

		branch = 0;
		writeback = 0;
		update_flags = 0;
		rd = 4'bxxxx;
		data_op = 4'bxxxx;

		priority casez(insn `FIELD_OP)
			`GROUP_B: begin
				branch = 1;
				if(branch_link) begin
					rd = `R14;
					writeback = 1;
					//TODO: Valor de LR
				end
			end

			`GROUP_ALU: begin
				rd = data_rd;
				writeback = data_writeback;
				data_op = data_group_op;
				update_flags = data_update_flags;
			end

			`INSN_MUL: ;
			`GROUP_BIGMUL: ;
			`GROUP_LDST_MISC: ;
			`GROUP_LDST_MULT: ;
			`GROUP_SWP: ;
			`GROUP_CP: ;
			`INSN_MRS: ;
			`GROUP_MSR: ;
			`INSN_SWI: ;

			default: begin
				undefined = 1;
				branch = 1'bx;
				writeback = 1'bx;
			end
		endcase
	end

endmodule