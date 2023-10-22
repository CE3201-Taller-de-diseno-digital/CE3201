`include "gfx/gfx_defs.sv"

module fold_flow
(
	input  logic  clk,
	              rst_n,

	input  logic  in_valid,
	              out_ready,

	output logic  in_ready,
	              out_valid,
	              stall,
	              feedback,
	              feedback_last
);

	index4 rounds[`FP_ADD_STAGES], last_round;

	assign stall = out_valid && !out_ready;
	assign in_ready = !stall && !feedback;
	assign out_valid = last_round == `INDEX4_MAX;

	assign feedback = last_round[1] ^ last_round[0];
	assign feedback_last = last_round[1];

	assign last_round = rounds[`FP_ADD_STAGES - 1];

	always_ff @(posedge clk or negedge rst_n)
		if (!rst_n)
			rounds[0] <= `INDEX4_MIN;
		else if (!stall)
			unique case (last_round)
				2'b01:
					rounds[0] <= 2'b10;

				2'b10: 
					rounds[0] <= 2'b11;

				2'b00, 2'b11:
					rounds[0] <= {1'b0, in_valid};
			endcase

	genvar i;
	generate
		for (i = 1; i < `FP_ADD_STAGES; ++i) begin: pipeline
			always_ff @(posedge clk or negedge rst_n)
				if (!rst_n)
					rounds[i] <= `INDEX4_MIN;
				else if (in_ready)
					rounds[i] <= rounds[i - 1];
		end
	endgenerate

endmodule
