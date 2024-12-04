module MUX_RegDst(
input logic RegDST,
input logic[4:0] RT,
input logic[4:0] RD,
output logic[4:0] RegDST_out
);


	always_comb begin
		if(RegDST) begin
			RegDST_out = RD;
		end
		else begin
			RegDST_out = RT;
		end
	end
		
endmodule
















