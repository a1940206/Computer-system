load ArrMin.asm;
output-file ArrMin04.out;
compare-to ArrMin04.cmp;
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2 RAM[50]%D2.6.2 RAM[51]%D2.6.2 RAM[52]%D2.6.2 RAM[53]%D2.6.2;

set PC 0;
set RAM[1] 50;
set RAM[2] 4;
set RAM[50] 8;
set RAM[51] 8;
set RAM[52] 8;
set RAM[53] 8;
repeat 300 { ticktock; }
output;
