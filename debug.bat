 @echo off

set tools=%cd%\tools
echo "%tools%"
set openocdfolder=%tools%\xpack-openocd-0.11.0-1
echo "%openocdfolder%"
set openocd=%openocdfolder%\bin\openocd.exe
set gdb=%tools%\xpack-riscv-none-embed-gcc-10.1.0-1.1\bin\riscv-none-embed-gdb.exe

echo "Start OpenOCD"
call %openocd% -f %tools%\ft232h_jtag.cfg -f %openocdfolder%\scripts\target\gd32vf103.cfg