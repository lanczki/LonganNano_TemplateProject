# LonganNano TemplateProject

#### Introduction
The purpose of this repository is to create an developer environment for the Sipeed Longan Nano or to any other device which contains a GigaDevice GD32VF103CBT6. The project folder only contains the basic functionality to be able to start development. These features can be understand and modified easily. As such it can be further developed to the needs of a more complex development. 

#### Features
- Buildability via Make
- OpenOCD and GDB integrated into VSCode

#### Dependencies
- [Cygwin](https://cygwin.com/install.html)
- [VSCode](https://code.visualstudio.com/)
- [Native Debug](https://marketplace.visualstudio.com/items?itemName=webfreak.debug)

#### Used tools
- [Nuklei SDK](https://doc.nucleisys.com/nuclei_sdk/#)
- [xPack GNU RISC-V Embedded GCC v10.1.0-1.1](https://github.com/xpack-dev-tools/riscv-none-embed-gcc-xpack/releases/)
- [GD32VF103 Firmware Library](https://www.gigadevice.com/microcontroller/gd32vf103cbt6/)

#### Folder structure
- .vscode   //Contains the VScode configuratiuon
- board     //Contains the GD32VF103 Firmware Library
- include   //Contains the project headers
- output    //Contains the GCC output files
- src       //Contains the source files for the project
- tools     //Contains the tools needed to build,debug,flash

#### Good to have VSCode extension
- [RISC-V Support](https://marketplace.visualstudio.com/items?itemName=zhwu95.riscv)
- [LinkerScript](https://marketplace.visualstudio.com/items?itemName=ZixuanWang.linkerscript)
- [Intel HEX format](https://marketplace.visualstudio.com/items?itemName=keroc.hex-fmt)

