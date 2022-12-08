`include "core/uarch.sv"

module core_prefetch
#(parameter ORDER=2)
(
	input  logic clk,
	             rst_n,
	             stall,
	             flush,
	             fetched,
	input  word  fetch_data,
	input  ptr   head,

	output word  insn,
	output ptr   insn_pc,
	output logic fetch,
	             nop
);

	localparam SIZE = (1 << ORDER) - 1;

	ptr next_pc;
	logic[31:0] prefetch[SIZE];
	logic[ORDER - 1:0] valid;

	assign nop = flush ? 1 : ~|valid;
	assign insn = flush ? `NOP : prefetch[0];
	assign next_pc = ~stall & |valid ? insn_pc + 1 : insn_pc;
	assign fetch = !stall || ~&valid;

	always_ff @(posedge clk or negedge rst_n)
		if(!rst_n) begin
			valid <= 0;
			insn_pc <= 0;
			prefetch[SIZE - 1] <= `NOP;
		end else begin
			insn_pc <= flush ? head : next_pc;

			if(flush)
				prefetch[SIZE - 1] <= `NOP;
			else if(fetched && valid == SIZE - 1 + {{(ORDER - 1){1'b0}}, !stall})
				prefetch[SIZE - 1] <= fetch_data;
			else if(!stall)
				prefetch[SIZE - 1] <= `NOP;

			if(flush)
				valid <= 0;
			else if(fetched & ((stall & ~&valid) | ~|valid))
				valid <= valid + 1;
			else if(~stall & ~fetched & |valid)
				valid <= valid - 1;
		end

	genvar i;
	generate
		for(i = 0; i < SIZE - 1; ++i) begin: prefetch_slots
			always_ff @(posedge clk or negedge rst_n)
				if(!rst_n)
					prefetch[i] <= `NOP;
				else if(flush)
					prefetch[i] <= `NOP;
				else if(fetched & (~(|i | |valid) | (valid == i + {{(ORDER - 1){1'b0}}, ~stall})))
					prefetch[i] <= fetch_data;
				else if(~stall)
					prefetch[i] <= prefetch[i + 1];
		end
	endgenerate

endmodule
