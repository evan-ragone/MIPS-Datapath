module ALU(
    input logic [31:0] SrcA,        // First operand
    input logic [31:0] SrcB,        // Second operand
    input logic [2:0] ALUControl,   // ALU control signal
    output logic [31:0] ALUResult   // Result of the operation
);

    always_comb begin
        case (ALUControl)
			  3'b000: ALUResult = SrcA & SrcB;       // AND operation
            3'b001: ALUResult = SrcA | SrcB;       // OR operation
            3'b010: ALUResult = SrcA + SrcB;       // ADD operation
            3'b100: ALUResult = SrcA ^ SrcB;       // XOR operation
            3'b110: ALUResult = SrcA - SrcB;       // SUB operation 
            3'b111: ALUResult = (SrcA < SrcB) ? 1 : 0; // Set on Less Than (SLT)
            default: ALUResult = 32'b0;            // Default case: zero out ALUResult
        endcase
    end

endmodule