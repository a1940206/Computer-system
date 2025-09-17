// This file is based on part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: Mult.asm

// Multiplies R1 and R2 and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
    @R0
    M = 0          
    @SIGN
    M = 0          


    @R1
    D = M
    @R1_POS
    D;JGE         

    D = -D
    @R1
    M = D          
    @SIGN
    M = M + 1     
(R1_POS)

    @R2
    D = M
    @R2_POS
    D;JGE
    // R2 < 0
    D = -D
    @R2
    M = D          
    @SIGN
    M = M + 1      
(R2_POS)

    @R2
    D = M
    @COUNT
    M = D         

(LOOP)
    @COUNT
    D = M
    @AFTER_LOOP
    D;JEQ          

    @R1
    D = M
    @R0
    M = M + D      

    @COUNT
    M = M - 1
    @LOOP
    0;JMP

(AFTER_LOOP)

    @SIGN
    D = M
    D = D & 1      
    @END
    D;JEQ        

    @R0
    D = M
    D = -D
    M = D

(END)
    0;JMP          
