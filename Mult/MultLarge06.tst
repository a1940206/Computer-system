load Mult.asm,
output-file MultLarge01.out,
compare-to MultLarge01.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2;

set PC 0,
set RAM[1] 200,
set RAM[2] 150;
repeat 20000 { ticktock; }
output;
