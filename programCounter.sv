module programCounter (
    input  logic        clk,           
    input  logic        reset,
    input  logic [31:0] pcIn,         
    output logic [31:0] pcOut         
);

    // PC register
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            pcOut <= 32'h00000000;  // Reset PC to the initial address
        end else begin
            pcOut <= pcIn;         
        end
    end

endmodule
