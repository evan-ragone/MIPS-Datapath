module MUX_ALUSrc(
input logic ALUSrc,
input logic[31:0] RS,
input logic[31:0] Imm,
output logic[31:0] ALUSrc_out
);


	always_comb begin
		if(ALUSrc) begin
			ALUSrc_out = Imm;
		end
		else begin
			ALUSrc_out = RS;
		end
	end
		
endmodule



