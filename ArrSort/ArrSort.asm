// Sorts the array of length R2 whose first element is at RAM[R1] in ascending order in place. Sets R0 to True (-1) when complete.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
// -------------------------------------------------------------
// ArrSort.asm – Bubble Sort (ascending order, in-place)
// Inputs : R1 = base address of array
//          R2 = length of array
// Output : array sorted in-place, R0 = -1 when finished
// -------------------------------------------------------------

// ---- Edge case: length <= 1 ----
@R2
D=M
@DONE
D;JLE
D=D-1
@DONE
D;JLE

// pass = R2-1
@R2
D=M
D=D-1
@pass
M=D

(OUTER)
    // if pass < 1 -> DONE
    @pass
    D=M
    @DONE
    D;JLE

    // i = 0
    @0
    D=A
    @i
    M=D

(INNER)
    // if i >= pass -> end inner loop
    @i
    D=M
    @pass
    D=D-M
    @AFTER_INNER
    D;JGE

    // ---- load A[i] into tmp ----
    @R1
    D=M
    @i
    D=D+M
    @addr
    M=D           // addr = R1 + i

    @addr
    A=M
    D=M
    @tmp
    M=D           // tmp = A[i]

    // ---- load A[i+1] into tmp2 ----
    @addr
    D=M
    D=D+1
    @addr2
    M=D           // addr2 = addr + 1

    @addr2
    A=M
    D=M
    @tmp2
    M=D           // tmp2 = A[i+1]

    // if tmp <= tmp2 -> no swap
    @tmp
    D=M
    @tmp2
    D=D-M         // tmp - tmp2
    @NO_SWAP
    D;JLE

    // ---- swap ----
    @tmp2
    D=M
    @addr
    A=M
    M=D           // A[i] = tmp2

    @tmp
    D=M
    @addr2
    A=M
    M=D           // A[i+1] = tmp
(NO_SWAP)
    @i
    M=M+1
    @INNER
    0;JMP

(AFTER_INNER)
    @pass
    M=M-1
    @OUTER
    0;JMP

(DONE)
    @R0
    M=-1          // indicate completion
    @END
    0;JMP
(END)
    @END
    0;JMP

// -------- Variables --------
(pass)    // 外层剩余趟数
(i)       // 内层索引
(tmp)     // A[i]
(tmp2)    // A[i+1]
(addr)    // R1 + i
(addr2)   // R1 + i + 1

