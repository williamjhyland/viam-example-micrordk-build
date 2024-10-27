.PHONY: build

build:
	cargo build --release

upload:
	cargo espflash flash --erase-parts nvs --monitor --partition-table partitions.csv --baud 460800 -f 80mhz --release $(ESPFLASH_FLASH_ARGS)


build-esp32-bin:
	cargo espflash save-image --merge --chip esp32 target/xtensa-esp32-espidf/release/billistestingstuff.bin --partition-table partitions.csv -s 8mb  --release

flash-esp32-bin:
ifneq (,$(wildcard target/xtensa-esp32-espidf/release/billistestingstuff))
	espflash flash --erase-parts nvs --partition-table partitions.csv  target/xtensa-esp32-espidf/release/billistestingstuff --baud 460800 -s 8mb && sleep 2 && espflash monitor
else
	$(error target/xtensa-esp32-espidf/release/billistestingstuff not found, run build-esp32-bin first)
endif
