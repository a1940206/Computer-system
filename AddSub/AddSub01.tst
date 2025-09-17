load AddSub.asm,
output-file AddSub01.out,
compare-to AddSub01.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2 RAM[3]%D2.6.2;

set PC 0,
set RAM[1] 7,   // a
set RAM[2] 5,   // b
set RAM[3] 2;   // c
repeat 50 { ticktock; }
output;
