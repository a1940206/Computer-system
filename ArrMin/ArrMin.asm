// Finds the smallest element in the array of length R2 whose first element is at RAM[R1] and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
// ArrMin.asm
// Finds the smallest value in the array of length R2
// whose first element is at RAM[R1] and stores the result in R0.

    @R1
    D = M          // D = 首元素地址
    @PTR
    M = D          // PTR = 当前元素指针

    @R2
    D = M
    @COUNT
    M = D          // COUNT = 数组长度

// ---- 取第一个元素作为当前最小值 ----
    @PTR
    A = M
    D = M
    @R0
    M = D          // R0 = 第一个元素
    @COUNT
    M = M - 1      // 还剩 COUNT-1 个元素待比较
    @NEXT
    0;JMP

(LOOP)
    @PTR
    M = M + 1      // PTR 指向下一个元素
    A = M
    D = M          // D = 当前元素
    @R0
    D = D - M      // D = 当前元素 - 当前最小值
    @KEEP
    D;JGE          // 如果当前元素 >= 当前最小值，不更新

    @PTR
    A = M
    D = M
    @R0
    M = D          // 更新最小值

(KEEP)
    @COUNT
    M = M - 1
(NEXT)
    @COUNT
    D = M
    @END
    D;JEQ          // COUNT == 0 → 结束
    @LOOP
    0;JMP

(END)
    0;JMP          // 程序结束
