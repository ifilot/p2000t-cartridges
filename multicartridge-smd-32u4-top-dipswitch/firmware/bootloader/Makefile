MCU := atmega32u4
ARCH := AVR8
LUFA_PATH := ../.deps/lufa/LUFA
.DEFAULT_GOAL := all
include $(LUFA_PATH)/Build/LUFA/lufa-sources.mk
SOURCES := BootloaderCDC.c BootloaderAPI.c Descriptors.c $(LUFA_SRC_USB_DEVICE)
OBJECTS := $(addprefix ../build/boot/,$(notdir $(SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(SOURCES)))
FLAGS := -mmcu=$(MCU) -Os -flto -std=gnu99 -ffunction-sections -fdata-sections -MMD -MP \
         -I. -IConfig -I../.deps/lufa -DF_CPU=16000000UL -DF_USB=16000000UL \
         -DARCH=ARCH_AVR8 -DBOARD=BOARD_NONE -DUSE_LUFA_CONFIG_HEADER -DBOOT_START_ADDR=0x7000
.PHONY: all
all: ../build/bootloader.hex
../build/boot/%.o: %.c
	@mkdir -p $(dir $@)
	avr-gcc $(FLAGS) -c $< -o $@
../build/bootloader.elf: $(OBJECTS)
	avr-gcc -mmcu=$(MCU) -Os -flto -Wl,--gc-sections,--section-start=.text=0x7000,--defsym=__stack=0xafd,-Map=../build/bootloader.map $^ -o $@
	avr-size -C --mcu=$(MCU) $@
../build/bootloader.hex: ../build/bootloader.elf
	avr-objcopy -O ihex -R .eeprom $< $@
-include $(OBJECTS:.o=.d)
