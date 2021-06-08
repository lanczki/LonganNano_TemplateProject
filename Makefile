# compiler and target program
CXX := tools/xpack-riscv-none-embed-gcc-10.1.0-1.1/bin/riscv-none-embed-gcc.exe
OBJCOPY := tools/xpack-riscv-none-embed-gcc-10.1.0-1.1/bin/riscv-none-embed-objcopy.exe
GDB := tools/xpack-riscv-none-embed-gcc-10.1.0-1.1/bin/riscv-none-embed-gdb.exe
OPENOCD := tools/Nuclei/openocd/bin/openocd.exe

CD := $(abspath $(lastword $(MAKEFILE_LIST)))

PROJECT := Template
TARGET := GD32VF103V_EVAL

# directories for .o and .d files
OUTPUTDIR := output/
OBJDIR := $(OUTPUTDIR)obj/
DEPDIR := $(OUTPUTDIR)deps/

LINKER_SCRIPT := board/RISCV/env_Eclipse/GD32VF103xB.lds

INCLUDEDIRS += -Iboard/GD32VF103_standard_peripheral
INCLUDEDIRS += -Iboard/GD32VF103_standard_peripheral/Include
INCLUDEDIRS += -Iboard/GD32VF103_usbfs_driver/Include
INCLUDEDIRS += -Iboard/RISCV/drivers
INCLUDEDIRS += -Iinclude

# all source, object, and dependency files
PHERIPERIAL_DRIVER_SRC_FOLDER += board/GD32VF103_standard_peripheral/
PHERIPERIAL_DRIVER_SRC_FOLDER += board/GD32VF103_standard_peripheral/Source/

USBFS_DRIVER_SRC_FOLDER += board/GD32VF103_usbfs_driver/Source/

RISCV_SRC_FOLDER +=  board/RISCV/stubs/
RISCV_SRC_FOLDER += board/RISCV/env_Eclipse/
RISCV_SRC_FOLDER += board/RISCV/drivers/

SRCS_FOLDER += src/

SRCS_FOLDERS += $(SRCS_FOLDER)
SRCS_FOLDERS += $(PHERIPERIAL_DRIVER_SRC_FOLDER)
#SRCS_FOLDERS += $(USBFS_DRIVER_SRC_FOLDER)
SRCS_FOLDERS += $(RISCV_SRC_FOLDER)

SRCS := $(foreach FOLDER,$(SRCS_FOLDERS),$(wildcard $(FOLDER)*.c))

RISCV_SRC_ASSAMBLY += $(wildcard board/RISCV/env_Eclipse/*.S)

OBJS += $(SRCS:%.c=$(OBJDIR)%.o)
OBJS += $(RISCV_SRC_ASSAMBLY:%.S=$(OBJDIR)%.o)

DEPS += $(SRCS:%.c=$(DEPDIR)%.d)
DEPS += $(RISCV_SRC_ASSAMBLY:%.S=$(DEPDIR)%.d)
# root target for linking compiled .o files into one binary
$(PROJECT) : $(OBJS)
	$(CXX) $^ -T$(LINKER_SCRIPT) -nostartfiles -Xlinker -Map=$(OUTPUTDIR)$(PROJECT).map -o $(OUTPUTDIR)$@.elf
	@echo
	$(OBJCOPY) -O ihex $(OUTPUTDIR)$(PROJECT).elf $(OUTPUTDIR)$(PROJECT).hex


# target to compile all .cpp files, generating .d files in the process
$(OBJDIR)%.o : %.c $(DEPDIR)%.d | $(DEPDIR) $(OBJDIR)
	$(CXX) -MMD -MT $@ -MP -MF $(DEPDIR)$*.d -o $@ -c $< $(INCLUDEDIRS) -D$(TARGET)
	@echo

$(OBJDIR)%.o : %.S $(DEPDIR)%.d | $(DEPDIR) $(OBJDIR)
	$(CXX) -MMD -MT $@ -MP -MF $(DEPDIR)$*.d -o $@ -c $< $(INCLUDEDIRS) -D$(TARGET)
	@echo

# empty targets for handling missing .d files
$(DEPS):

# target to create object and dependency directories if they don't exist
$(DEPDIR):
	@mkdir -p $(foreach FOLDER,$(SRCS_FOLDERS),$@$(FOLDER))

$(OBJDIR):	
	@mkdir -p $(foreach FOLDER,$(SRCS_FOLDERS),$(OBJDIR)$(FOLDER))
# delete .d files, compiled .o files, and linked binary leaving just the code
clean:
	$(RM) -r $(OBJDIR) $(TARGET)

debug: $(PROJECT)
	@echo "Start Debug"
	@cmd /c start "" "$(OPENOCD) -f $(CD)\tools\ft232h_jtag.cfg" 
	@cmd /c start "" "$(GDB) -ex "target remote localhost:3333"" 

cd:
	@echo $(CD)

# include all the dependency files
include $(wildcard $(DEPS))