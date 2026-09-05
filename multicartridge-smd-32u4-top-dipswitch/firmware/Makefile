MCU := atmega32u4
ARCH := AVR8
LUFA_PATH := .deps/lufa/LUFA
TARGET := build/cartridge
.DEFAULT_GOAL := all

ifeq ($(wildcard $(LUFA_PATH)/Build/LUFA/lufa-sources.mk),)
$(error LUFA missing: run sh fetch-lufa.sh first)
endif
include $(LUFA_PATH)/Build/LUFA/lufa-sources.mk

SOURCES := main.c protocol.c sst39sf020.c Descriptors.c $(LUFA_SRC_USB_DEVICE) \
           $(LUFA_PATH)/Drivers/USB/Class/Device/CDCClassDevice.c
OBJECTS := $(addprefix build/,$(SOURCES:.c=.o))
CPPFLAGS := -I. -I.deps/lufa -DF_CPU=16000000UL -DF_USB=16000000UL \
            -DARCH=ARCH_AVR8 -DBOARD=BOARD_NONE -DUSE_LUFA_CONFIG_HEADER
CFLAGS := -mmcu=$(MCU) -std=gnu99 -Os -g -Wall -Wextra \
          -ffunction-sections -fdata-sections -MMD -MP

.PHONY: all clean size
all: $(TARGET).hex size
$(TARGET).elf: $(OBJECTS)
	avr-gcc -mmcu=$(MCU) -Wl,--defsym=__stack=0xafd,--gc-sections,-Map=$(TARGET).map $^ -o $@
$(TARGET).hex: $(TARGET).elf
	avr-objcopy -O ihex -R .eeprom $< $@
build/%.o: %.c
	@mkdir -p $(dir $@)
	avr-gcc $(CPPFLAGS) $(CFLAGS) -c $< -o $@
size: $(TARGET).elf
	avr-size -C --mcu=$(MCU) $<
clean:
	rm -rf build
-include $(OBJECTS:.o=.d)

.PHONY: test
test: build/test-protocol
	./build/test-protocol
build/test-protocol: tests/test_protocol.c protocol.c protocol.h
	@mkdir -p build
	gcc -std=c99 -Wall -Wextra -Werror -I. tests/test_protocol.c protocol.c -o $@

.PHONY: bootloader combined
bootloader:
	$(MAKE) -C bootloader
combined: all bootloader
	python3 tools/hex_image.py build/cartridge.hex build/bootloader.hex build/combined.hex
