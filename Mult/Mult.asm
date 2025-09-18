// This file is based on part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: Mult.asm

// Multiplies R1 and R2 and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

// This file is based on part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: Mult.asm

// Multiplies R1 and R2 and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
// Mult.asm
// Multiply R1 and R2 (signed integers) and store result in R0.

    @R0
    M = 0          // 初始化结果
    @SIGN
    M = 0          // 记录负号个数

// ----- 处理 R1 符号 -----
    @R1
    D = M
    @R1_POS
    D;JGE          // 如果 R1 >= 0 跳过
    D = -D
    @R1
    M = D          // R1 = |R1|
    @SIGN
    M = M + 1      // 记录负号
(R1_POS)

// ----- 处理 R2 符号 -----
    @R2
    D = M
    @R2_POS
    D;JGE
    D = -D
    @R2
    M = D          // R2 = |R2|
    @SIGN
    M = M + 1
(R2_POS)

// ----- 循环累加 -----
    @R2
    D = M
    @COUNT
    M = D          // COUNT = R2

(LOOP)
    @COUNT
    D = M
    @AFTER_LOOP
    D;JEQ          // COUNT == 0 → 结束

    @R1
    D = M
    @R0
    M = M + D      // R0 = R0 + R1

    @COUNT
    M = M - 1
    @LOOP
    0;JMP

(AFTER_LOOP)

// ----- 判断 SIGN 是否为 1 (奇数) -----
    @SIGN
    D = M
    @CHECK_ONE
    D;JEQ          // 如果 SIGN == 0，跳到 CHECK_ONE，直接结束（不取反）

    // 这里 SIGN 不为 0，可能是 1 或 2
    @SIGN
    D = M
    D = D - 1
    @DO_NEG
    D;JEQ          // 如果 SIGN == 1，跳到 DO_NEG (取反)

    // 如果到这里，SIGN == 2，不取反
    @END
    0;JMP

(DO_NEG)
    @R0
    D = M
    D = -D
    M = D          // 取反
    @END
    0;JMP

(CHECK_ONE)
    @END
    0;JMP
      // 取反

(END)
    0;JMP          // 程序结束
