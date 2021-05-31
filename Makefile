TARGET := GD32VF103V_EVAL

GCC := .\tools\xpack-riscv-none-embed-gcc-10.1.0-1.1\bin\riscv-none-embed-gcc.exe
#GCC_FLAGS := 

OUTPUTDIR := .\output

INCLUDEDIRS += -I.\board\GD32VF103_standard_peripheral
INCLUDEDIRS += -I.\board\GD32VF103_standard_peripheral\Include
INCLUDEDIRS += -I.\board\GD32VF103_usbfs_driver\Include
INCLUDEDIRS += -I.\board\RISCV\drivers
INCLUDEDIRS += -I.\include

PHERIPERIAL_DRIVER_SRC_FILES += $(wildcard ./board/GD32VF103_standard_peripheral/*.c)
PHERIPERIAL_DRIVER_SRC_FILES += $(wildcard ./board/GD32VF103_standard_peripheral/Source/*.c)

USBFS_DRIVER_SRC_FILES += $(wildcard ./board/GD32VF103_usbfs_driver/Source/*.c)

RISCV_SRC_FILES += $(wildcard ./board/RISCV/stubs/*.c)
RISCV_SRC_FILES += $(wildcard ./board/RISCV/env_Eclipse/*.c)
RISCV_SRC_FILES += $(wildcard ./board/RISCV/drivers/*.c)

RISCV_SRC_ASSAMBLY += $(wildcard ./board/RISCV/env_Eclipse/*.S)

SRC_FILES += $(wildcard ./src/*.c)

SRC_FILES += $(PHERIPERIAL_DRIVER_SRC_FILES)
#SRC_FILES += $(USBFS_DRIVER_SRC_FILES)
SRC_FILES += $(RISCV_SRC_FILES)
SRC_FILES += $(RISCV_SRC_ASSAMBLY)

OBJECTS += $(patsubst %.S,%.o,$(patsubst %.c,%.o,$(notdir $(SRC_FILES))))
SRC := $(notdir $(SRC_FILES))
.PHONY: init

all: init $(SRC) $(OBJECTS)

DEPENDENCIES = $(wildcard output/dep/*.d)

DEPFLAGS := -MM -MF 

%.c:
	$(info asd)
	$(info $@)
	$(info $(OBJECTS))
	$(GCC) -c $(filter %$@,$(SRC_FILES)) $(INCLUDEDIRS) -D$(TARGET) $(DEPFLAGS) $(OUTPUTDIR)\dep\$(@:.c=.d) 

%.S:
	$(info das)
	$(info $@)
	$(GCC) -c $(filter %$@,$(SRC_FILES)) $(INCLUDEDIRS) -D$(TARGET) $(DEPFLAGS) $(OUTPUTDIR)\dep\$(@:.S=.d) 

-include $(DEPENDENCIES)

%.o: %.c
		$(info $(%^))
#		$(info $@)
#		$(GCC) -c -o $(OUTPUTDIR)\obj\$@ $^ -D$(TARGET) $(DEPFLAGS)

%.o: %.S
		$(info $(%^))


init:
		@mkdir -p $(OUTPUTDIR)\dep
		@mkdir -p $(OUTPUTDIR)\obj

#.PHONY: variables
variables:
		$(info $(OBJECTS))

#-include $(DEPENDENCIES)
#call %gcc% -c -D GD32VF103V_EVAL -Iinclude -I.\board\GD32VF103_standard_peripheral -I.\board\GD32VF103_standard_peripheral\Include -I.\board\RISCV\drivers .\src\main.c -MMD -MF main.d 
