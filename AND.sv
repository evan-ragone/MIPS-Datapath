	module andGate (
    input logic A,    
    input logic B,    
    output logic Y    
);

    always_comb begin
        Y = A & B;     // Perform AND operation
    end

endmodule
