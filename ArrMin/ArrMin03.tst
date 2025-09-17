load ArrMin.asm;
output-file ArrMin03.out;
compare-to ArrMin03.cmp;
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2 RAM[40]%D2.6.2;

set PC 0;
set RAM[1] 40;
set RAM[2] 1;
set RAM[40] 5;
repeat 200 { ticktock; }
output;
