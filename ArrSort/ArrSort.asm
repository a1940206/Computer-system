// Sorts the array of length R2 whose first element is at RAM[R1] in ascending order in place. Sets R0 to True (-1) when complete.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
// -------------------------------------------------------------
// ArrSort.asm – Selection Sort (ascending order)
// Inputs : R1 = base address of array
//          R2 = length of array
// Output : array sorted in-place, R0 = -1 when finished
// -------------------------------------------------------------

    // ---- Handle arrays of length 0 or 1 ----
@R2
D=M
@DONE
D;JLE
D=D-1
@DONE
D;JLE
@R3
M=0

(OUTER_CHECK)
@R2
D=M
D=D-1
@R3
D=D-M
@DONE
D;JLE

@R1
D=M
@R3
D=D+M
@R4
M=D
@R4
A=M
D=M
@R7
M=D
@R4
D=M
@R5
M=D
@R4
D=M
D=D+1
@R8
M=D
@R2
D=M
@R3
D=D-M
D=D-1
@R6
M=D

(INNER_LOOP)
@R6
D=M
@AFTER_INNER
D;JEQ
@R8
A=M
D=M
@R9
M=D

@R9
D=M
@CURR_NONNEG
D;JGE
@R7
D=M
@BOTH_NEG
D;JLT
@UPDATE
0;JMP
(BOTH_NEG)
@R9
D=M
@R7
D=D-M
@SKIP_UPDATE
D;JGE
@UPDATE
0;JMP
(CURR_NONNEG)
@R7
D=M
@BOTH_NONNEG
D;JGE
@SKIP_UPDATE
0;JMP
(BOTH_NONNEG)
@R9
D=M
@R7
D=D-M
@SKIP_UPDATE
D;JGE
@UPDATE
0;JMP

(UPDATE)
@R9
D=M
@R7
M=D
@R8
D=M
@R5
M=D
(SKIP_UPDATE)
@R8
M=M+1
@R6
M=M-1
@INNER_LOOP
0;JMP

(AFTER_INNER)
@R5
D=M
@R4
D=D-M
@NO_SWAP
D;JEQ
@R4
A=M
D=M
@R11
M=D
@R5
A=M
D=M
@R4
A=M
M=D
@R11
D=M
@R5
A=M
M=D
(NO_SWAP)
@R3
M=M+1
@OUTER_CHECK
0;JMP

(DONE)
@R0
M=-1
(END)
@END
0;JMP

