transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/SL2.sv}
vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/programCounter.sv}
vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/ControlUnit.sv}
vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/top.sv}
vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/SignExtend.sv}
vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/register_file.sv}
vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/MUX_RegDst.sv}
vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/MUX_MemtoReg.sv}
vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/MUX_ALUSrc.sv}
vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/display.sv}
vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/data_memory.sv}
vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/ALU.sv}
vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/MUX_BranchToPC.sv}
vlog -sv -work work +incdir+C:/QuartusProj/MipsProj {C:/QuartusProj/MipsProj/instructionMem.sv}

