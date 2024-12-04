module top(
    input logic clk, 
	 input logic rst,
    output logic [31:0] ALUResult,         
    output logic [31:0] RD1, RD2, InstrucAddress, currInst,         
    output logic [31:0] registerFileOutput,
	 output logic [31:0] MemOutputLoc, 
	 output logic [4:0] RegOutputLoc,
	 output logic [31:0] dataMemOutput,
	 output logic [6:0] display_led_data_mem, display_led_register_file,led_InstrucAddress,
	 output logic [2:0] ALUOp
);

    // Intermediate signals for various connections
    logic [31:0] signImm, mem_data, alu_operand, readData, mem_to_reg_data, branchALUResult, ALUpfour, pcIn;
	 logic [31:0] shiftedSigned;
    logic [4:0] writeReg;
	 logic regDst, memRead, memToReg, memWrite, ALUSrc, regWrite, Zero, pcSrc, branch;
	 

	programCounter pc (
		.clk(clk),
		.reset(rst),
		.pcIn(pcIn),
		.pcOut(InstrucAddress)
	);
	instructionMem instMem (
	
	  .addr(InstrucAddress),     
	  .instruction(currInst) 
	);
	
	
	
	ALU plusfour (
		.SrcA(InstrucAddress),                   
        .SrcB(32'b00000000000000000000000000000100),           
        .ALUControl(3'b010),          
        .ALUResult(ALUpfour) 
	);
	
	
	SL2 shiftL (
		.signedVal(signImm),     
		.ShiftedVal(shiftedSigned)     
		);
		
		ALU bran (
        .SrcA(ALUpfour),                   
        .SrcB(shiftedSigned),           
        .ALUControl(3'b010),    //add operation       
        .ALUResult(branchALUResult)         
    );
	 
	 MUX_BranchToPC muxbtp(
		.PCSrc(pcSrc),
		.PCVal(ALUpfour),
		.branchVal(branchALUResult),
		.newPCVal(pcIn)
);
	
	
	
	 
	ControlUnit mipsCont ( 
		.opcode(currInst[31:26]),     
		.funct(currInst[5:0]),      
		.regDst(regDst),    
		.branch(branch),
		.memRead(memRead),   
		.memToReg(memToReg), 
		.ALUOp(ALUOp),     
		.memWrite(memWrite),  
		.ALUSrc(ALUSrc),    
		.regWrite(regWrite),
	);
	
	MUX_RegDst mux_RegDst (
        .RegDST(regDst), 
        .RT(currInst[20:16]),
        .RD(currInst[15:11]),
        .RegDST_out(writeReg)
    );
	 
	 
	 
    // Instantiate Register File
    register_file r_f(
        .clk(clk),
        .rst(rst),
        .A1(currInst[25:21]),          
        .A2(currInst[20:16]),          
        .A3(writeReg),               
        .WD3(mem_to_reg_data),        
        .WE3(regWrite), 
        .RD1(RD1),
        .RD2(RD2),
		  .RegFileOutput(RegOutputLoc),
        .prode(registerFileOutput)
    );

    // Sign Extend the immediate field to 32 bits
    SignExtend sign_extender (
        .imm(currInst[15:0]),
        .signImm(signImm)
    );

    // ALU source selection for immediate or register value
    MUX_ALUSrc mux_alu_src (
        .ALUSrc(ALUSrc), 
        .RS(RD2),
        .Imm(signImm),
        .ALUSrc_out(alu_operand)
    );

    // ALU to compute memory address
    zeroALU t1(
		  .opcode(currInst[31:26]),
        .SrcA(RD1),                   
        .SrcB(alu_operand),           
        .ALUControl(ALUOp),          
        .ALUResult(ALUResult),
		  .Zero(Zero)
    );
	 andGate branchGate(
		.A(Zero),    
		.B(branch),    
		.Y(pcSrc)    
);

	 

    // Data Memory 
    data_memory data_mem(
        .clk(clk),
        .rst(rst),
        .A(ALUResult),                
        .WD(RD2), 
		  .RE(memRead),
        .WE(memWrite), 
        .RD(readData), 
		  .MemRegOutput(MemOutputLoc),
        .dataMemOutputVal(dataMemOutput)              
    );

    // MUX for MemtoReg to select ALUResult or memory data
    MUX_MemtoReg mux_memtoreg (
        .MemtoReg(memToReg), 
        .ALUResult(ALUResult),
        .RD(readData),
        .MemtoReg_out(mem_to_reg_data)
    );
	 
	 display register_file_disp(
        .data_in(registerFileOutput),
        .segments(display_led_register_file)
    );
	 display data_mem_disp(
        .data_in(dataMemOutput),
        .segments(display_led_data_mem)
    );
	 	 display currInstruction(
        .data_in(InstrucAddress),
        .segments(led_InstrucAddress)
    );

endmodule

