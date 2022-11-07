`timescale 1 ns / 1 ps

module decode_test
(
    input  word            insn,
	input  logic           n, z, c, v

	output datapath_decode ctrl,
	output psr_decode      psr_ctrl,
	output branch_decode   branch_ctrl,
	output snd_decode      snd_ctrl,
	output data_decode     data_ctrl,
	output ldst_decode     ldst_ctrl,
	output mul_decode      mul_ctrl,
	output coproc_decode   coproc_ctrl

);
    psr_flags nzcv;
	assign {n, z, c, v} = nzcv;

    core_decode DUT (.*);

endmodule