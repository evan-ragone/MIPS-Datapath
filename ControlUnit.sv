module ControlUnit (
    input  logic [5:0] opcode,     
    input  logic [5:0] funct,      
    output logic       regDst,    
    output logic       branch,     
    output logic       memRead,   
    output logic       memToReg, 
    output logic [2:0] ALUOp,     
    output logic       memWrite,  
    output logic       ALUSrc,    
    output logic       regWrite   
);


    // Control signal logic
    always_comb begin
        // Default values for all signals
        regDst    = 0;
        branch     = 0;
        memRead   = 0;
        memToReg = 0;
        ALUOp     = 3'b010;
        memWrite  = 0;
        ALUSrc    = 0;
        regWrite  = 0;
			// values depending on opcode
			
			
        if(opcode == 6'b0) begin
                regDst    = 1; 
                ALUOp = (funct == 6'b100000) ? 3'b010 : 
								(funct == 6'b100010) ? 3'b110 : 
								(funct == 6'b100100) ? 3'b000 : 
							  (funct == 6'b100101) ? 3'b001 : 
							  (funct == 6'b101010) ? 3'b111 : 
								3'b010;                          
                regWrite  = 1;
        end else if((opcode == 6'b000011) || (opcode == 6'b000010)) begin
					branch = 1'b1;
					regWrite = (opcode == 6'b000010	) ? 1'b0 : 1'b1;
					ALUOp = 3'b011;
		 end else begin
					ALUSrc = ((opcode == 6'b000100) || (opcode == 6'b000101)) ? 1'b0 : 1'b1;
					memToReg = (opcode == 6'b100011) ? 1'b1 : 1'b0;
					regWrite = (((opcode >= 6'b000100) && (opcode <= 6'b000111)) || (opcode == 6'b101011)) ? 1'b0 : 1'b1;
					memRead = (opcode == 6'b100011) ? 1'b1 : 1'b0;
					memWrite = (opcode == 6'b101011) ? 1'b1 : 1'b0;
					branch = ((opcode == 6'b000100) || (opcode == 6'b000101)) ? 1'b1 : 1'b0;
					ALUOp =  (opcode == 6'b001100) ? 3'b000 : 
								(opcode == 6'b001101) ? 3'b001 : 
								((opcode == 6'b000100) || (opcode == 6'b000101)) ? 3'b011 : 
								(opcode == 6'b001010) ? 3'b111 : 
								3'b010;
		end
	end
endmodule
			 