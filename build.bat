 @echo off

set tools=%cd%\tools
echo "%tools%"
set openocdfolder=%tools%\xpack-openocd-0.11.0-1
echo "%openocdfolder%"
set openocd=%openocdfolder%\bin\openocd.exe
set gdb=%tools%\xpack-riscv-none-embed-gcc-10.1.0-1.1\bin\riscv-none-embed-gdb.exe
set gcc=%tools%\xpack-riscv-none-embed-gcc-10.1.0-1.1\bin\riscv-none-embed-gcc.exe

call %gcc% -c -D GD32VF103V_EVAL -Iinclude -I.\board\GD32VF103_standard_peripheral -I.\board\GD32VF103_standard_peripheral\Include -I.\board\RISCV\drivers .\board\RISCV\env_Eclipse\entry.S -MM -MF entry.d 
