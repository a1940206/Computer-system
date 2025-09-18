
load Mult.asm,
output-file Mult04.out,
compare-to Mult04.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2;
set PC 0,
set RAM[0] 0,     // Set R0
set RAM[1] -32768, // Set R1 (most negative)
set RAM[2] 1;     // Set R2
repeat 400 {
  ticktock;
}
set RAM[1] -32768, // Restore arguments
set RAM[2] 1,
output;