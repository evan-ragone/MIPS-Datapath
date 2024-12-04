module register_file(
    input logic clk, rst,
    input logic [4:0] A1, A2, A3,    
    input logic [31:0] WD3,          
    input logic WE3,                 
    output logic [31:0] RD1, RD2,    
	 output logic [4:0] RegFileOutput,
    output logic [31:0] prode       
);

    // Define 32 registers, each 32 bits wide
    logic [31:0] register [31:0];

    // Initialize the register file with proper values
    initial begin
        for (int i = 0; i < 32; i++) begin
            register[i] = i;
        end
    end
	 
	 
	 always_comb begin
		RD1 = (A1 != 5'b0) ? register[A1]: 32'b0;
		RD2 = (A2 != 5'b0) ? register[A2]: 32'b0;
    end

    // Write operation 
    always_ff@(posedge clk or negedge rst)
	 begin
        if (!rst) begin
				prode = 32'b0;
				RegFileOutput = 5'b0;
            // Reset all registers to initial values if reset triggered
            for (int i = 0; i < 32; i++) begin
                register[i] <= i;
            end
        end
        else if (WE3) begin
            register[A3] = WD3; // Write data to address A3 if WE3 is enabled
				prode = register[A3];
				RegFileOutput = A3;
				
        end
    end
	 

endmodule
