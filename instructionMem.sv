module instructionMem (
    input  logic [31:0]  addr,     
    output logic [31:0]  instruction 
);

    // Instruction memory array 
    logic [31:0] mem [0:4095]; 

	 
    always_comb begin
        
        instruction = mem[addr/4]; //divide by 4 bc 4 bytes per word
    end

    // Initialize memory with sample instructions (for simulation/testing)
    initial begin
        // Example program   32'b00001000000000010000000000000100; //	
        mem[0] = 32'b00000001010010110100100000100000; //add x10 + x11 and put in x9
		  mem[1] = 32'b10001101000001100000000000000010; //lw from memory[rf[x8]]+2 and store in registerfile[x6]
        mem[2] = 32'b00100001001010000000000000001000;// addi x9 + 8 and put in x8
		  mem[3] = 32'b00000001011010100001100000100010; //sub x11 - x10 and put in x3
		  mem[4] = 32'b10101101000001110000000000001000; //sw registerfile[x8]+8 in memory[x7] 
        mem[5] = 32'b00001000000000000000000000000010; //jump 2 word or 8 bytes.
		  mem[8] = 32'b00010001000111010000000000000001;// beq x8 equals x29 jump 1 words
    end

endmodule
	