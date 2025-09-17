load AddSub.asm,
output-file AddSub02.out,
compare-to AddSub02.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2 RAM[3]%D2.6.2;

set PC 0,
set RAM[1] 12,  // a
set RAM[2] 3,   // b
set RAM[3] 10;  // c
repeat 50 { ticktock; }
output;