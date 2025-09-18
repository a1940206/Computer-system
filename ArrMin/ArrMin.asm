// Finds the smallest element in the array of length R2 whose first element is at RAM[R1] and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
@R2
D=M
@EMPTY
D;JEQ

@R1
D=M
@R3
M=D
@R2
D=M
@R4
M=D

@R3
A=M
D=M
@R0
M=D
@R4
M=M-1

(LOOP)
@R4
D=M
@END
D;JEQ

@R3
M=M+1
@R3
A=M
D=M
@R5
M=D

@R5
D=M
@ELEM_NONNEG
D;JGE

@R0
D=M
@BOTH_NEG
D;JLT
@R5
D=M
@R0
M=D
@AFTER_CMP
0;JMP

(BOTH_NEG)
@R5
D=M
@R0
D=D-M
@AFTER_CMP
D;JGE
@R5
D=M
@R0
M=D
@AFTER_CMP
0;JMP

(ELEM_NONNEG)
@R0
D=M
@BOTH_NONNEG
D;JGE
@AFTER_CMP
0;JMP

(BOTH_NONNEG)
@R5
D=M
@R0
D=D-M
@AFTER_CMP
D;JGE
@R5
D=M
@R0
M=D

(AFTER_CMP)
@R4
M=M-1
@LOOP
0;JMP

(EMPTY)
@R0
M=0

(END)
@END
0;JMP
