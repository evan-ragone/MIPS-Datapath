module MUX_BranchToPC(
input logic PCSrc,
input logic[31:0] PCVal,
input logic[31:0] branchVal,
output logic[31:0] newPCVal
);


	always_comb begin
		if(PCSrc) begin
			newPCVal = branchVal;
		end
		else begin
			newPCVal = PCVal;
		end
	end
		
endmodule

