// Sorts the array of length R2 whose first element is at RAM[R1] in ascending order in place. Sets R0 to True (-1) when complete.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
// -------------------------------------------------------------
// ArrSort.asm – Selection Sort (ascending order)
// Inputs : R1 = base address of array
//          R2 = length of array
// Output : array sorted in-place, R0 = -1 when finished
// -------------------------------------------------------------

// ---- 处理数组长度为 0 或 1 的情况 ----
@R2
D=M
@DONE
D;JLE          // 长度 <= 0
D=D-1
@DONE
D;JLE          // 长度 == 1

// i = 0
@0
D=A
@i
M=D

(OUTER)
    // if i >= R2-1 -> DONE
    @i
    D=M
    @R2
    D=D-M+1     // D = i-(R2-1)
    @DONE
    D;JGE

    // minIndex = i
    @i
    D=M
    @minIndex
    M=D

    // j = i+1
    @i
    D=M
    D=D+1
    @j
    M=D

(INNER)
    // if j >= R2 -> 内层循环结束
    @j
    D=M
    @R2
    D=D-M
    @AFTER_INNER
    D;JGE

    // if A[j] < A[minIndex] -> minIndex = j
    @R1
    D=M
    @j
    A=D+M
    D=M
    @tmp
    M=D

    @R1
    D=M
    @minIndex
    A=D+M
    D=M
    @tmp
    D=M-D
    @NO_UPDATE
    D;JGE         // A[j] >= A[minIndex] -> 不更新

    @j
    D=M
    @minIndex
    M=D
(NO_UPDATE)
    @j
    M=M+1
    @INNER
    0;JMP

(AFTER_INNER)
    // swap A[i] 和 A[minIndex] 如果不同
    @i
    D=M
    @minIndex
    D=M-D
    @NO_SWAP
    D;JEQ

    // tmp = A[i]
    @R1
    D=M
    @i
    A=D+M
    D=M
    @tmp
    M=D

    // A[i] = A[minIndex]
    @R1
    D=M
    @minIndex
    A=D+M
    D=M
    @R1
    A=M
    @i
    A=A+M
    M=D

    // A[minIndex] = tmp
    @tmp
    D=M
    @R1
    A=M
    @minIndex
    A=A+M
    M=D
(NO_SWAP)
    @i
    M=M+1
    @OUTER
    0;JMP

(DONE)
    @R0
    M=-1
    @END
    0;JMP
(END)
    @END
    0;JMP

// -------- 变量区 --------
(i)
(minIndex)
(j)
(tmp)

