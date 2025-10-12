// Calculates the absolute value of R1 and stores the result in R0.
// (R0, R1 refer to RAM[0], and RAM[1], respectively.)

// Put your code here.
    @R1
    D = M        

    @POSITIVE
    D;JGE          

    // 这里表示 D < 0
    D = -D        

(POSITIVE)
    @R0
    M = D        

(END)
    0;JMP    
    load Abs.asm,
output-file Abs00.out,
compare-to Abs00.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2;

set PC 0,
set RAM[0] 0,  // Set R0
set RAM[1] -2;  // Set R1
repeat 100 {
  ticktock;    // Run for 100 clock cycles
}
set RAM[1] -2,  // Restore arguments in case program used them
output;        // Output to file
      
