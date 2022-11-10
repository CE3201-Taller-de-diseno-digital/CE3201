`include "core/uarch.sv"

module core_fetch
#(parameter PREFETCH_ORDER=2)
(
	input  logic clk,
	             rst_n,
	             stall,
	             branch,
	             fetched,
	             wr_pc,
	             prefetch_flush,
	input  ptr   branch_target,
	input  word  wr_current,
	             fetch_data,

	output logic fetch,
	             flush,
	output word  insn,
	output ptr   insn_pc,
	             addr,
	             fetch_head
);

	ptr next_pc, hold_addr, target;
	logic fetched_valid, discard;

	assign flush = branch || prefetch_flush;
	assign target = wr_pc ? wr_current[31:2] : branch_target; //TODO: alignment exception
	assign fetched_valid = fetched && !discard;

	core_prefetch #(.ORDER(PREFETCH_ORDER)) prefetch
	(
		.head(fetch_head),
		.fetched(fetched_valid),
		.*
	);

	always_comb begin
		if(branch)
			fetch_head = target;
		else if(prefetch_flush)
			fetch_head = next_pc;
		else
			fetch_head = {30{1'bx}};

		if(flush)
			addr = fetch_head;
		else if(fetch && fetched_valid)
			addr = hold_addr + 1;
		else
			addr = hold_addr;
	end

	always_ff @(posedge clk or negedge rst_n)
		if(!rst_n) begin
			discard <= 0;
			hold_addr <= 0;
		end else begin
			discard <= discard ? !fetched : flush && fetch;
			hold_addr <= addr;
		end

endmodule
