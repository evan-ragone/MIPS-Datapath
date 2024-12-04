module zeroALU(
	 input logic [5:0] opcode,
    input logic [31:0] SrcA,        // First operand
    input logic [31:0] SrcB,        // Second operand
    input logic [2:0] ALUControl,   // ALU control signal
    output logic [31:0] ALUResult,   // Result of the operation
	 output logic Zero
);

    always_comb begin
        case (ALUControl)
			  3'b000: ALUResult = SrcA & SrcB;       // AND operation
            3'b001: ALUResult = SrcA | SrcB;       // OR operation
            3'b010: ALUResult = SrcA + SrcB;       // ADD operation
            3'b100: ALUResult = SrcA ^ SrcB;       // XOR operation
            3'b110: ALUResult = SrcA - SrcB;       // SUB operation 
            3'b111: ALUResult = (SrcA < SrcB) ? 1 : 0; // Set on Less Than (SLT)
				3'b011: ALUResult = 32'b0;
            default: ALUResult = 32'b0;            // Default case: 
        endcase
		  
		  //depending on which branch equation  have a different comparison
		  if (opcode == 6'b000100) begin 
            Zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;  
        end else if (opcode == 6'b000101) begin 
            Zero = (ALUResult == 32'b0) ? 1'b0 : 1'b1;  
			end else if (ALUControl == 3'b011) begin 
            Zero = 1'b1;
        end else begin
				Zero = 1'b0;
		  end
		  
    end
	 

endmodule