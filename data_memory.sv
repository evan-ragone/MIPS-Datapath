module data_memory (
    input logic clk,                     
    input logic rst,                     
    input logic [31:0] A,                
    input logic [31:0] WD,
	 input logic  RE,  	 //read enable
    input logic  WE,		//write enable    
    output logic [31:0] RD,
	 output logic [31:0] MemRegOutput,
    output logic [31:0] dataMemOutputVal           
);


    // Memory array: 2^31 words, each 32 bits wide
    logic [31:0] MEM [255:0];

    // Initialize memory (example initialization)
    initial begin
        for (int i = 0; i < 255; i++) begin
            MEM[i] = i;
        end
    end
	 
	 
	always_comb begin
		if (RE == 1'b1) begin
			RD <= MEM[A];
		end else begin
			RD = 32'b0;
		end
	end
		  
		 
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
				dataMemOutputVal = 32'b0;
				MemRegOutput = 0;
            // Reset all memory locations to initial values
            for (int i = 0; i < 255; i++) begin
                MEM[i] <= i;
					 
            end
			end else if (WE == 1'b1) begin
          MEM[A] <= WD;
			 dataMemOutputVal <= WD;
			 MemRegOutput <= A;
        end
		  
		 
    end


endmodule
