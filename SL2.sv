module SL2 (
    input  logic [31:0] signedVal,     
    output logic [31:0] ShiftedVal     
);

    // Perform the shift operation
    assign ShiftedVal = signedVal << 2;

endmodule
