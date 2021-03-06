# This is very simple Makefile which encapsulates the build
# process of "Minimal Linux Live". Type the following command
# for additional information:
#
# make help

.DEFAULT_GOAL := help

all: clean
	@echo "Launching the main build script..."
	@/usr/bin/time -f 'Elapsed time: %E' ./build_minimal_linux_live.sh 2>&1 | tee minimal_linux_live.log

clean:
	@echo "Removing generated work artifacts..."
	@rm -rf work
	@rm -rf mll_image
	@echo "Removing generated build artifacts..."
	@rm -f minimal_linux_live.iso
	@rm -f mll_image.tgz
	@echo "Removing predefined configuration files..."
	@rm -rf minimal_overlay/*.config
	@echo "Removing source level overlay software..."
	@mv -f minimal_overlay/rootfs/README /tmp/mll_overlay_readme
	@cd minimal_overlay/rootfs && rm -rf * && cd ../..
	@mv -f /tmp/mll_overlay_readme minimal_overlay/rootfs/README
	@echo "Removing build log file..."
	@rm -f minimal_linux_live.log
	@$(eval USE_LOCAL_SOURCE := $(shell grep -i ^USE_LOCAL_SOURCE .config | cut -f2 -d'='))
	@if [ ! "$(USE_LOCAL_SOURCE)" = "true" ]; then echo "Removing source files..."; rm -rf source; fi

qemu:
	@if [ ! -f ./minimal_linux_live.iso ]; then echo "ISO image 'minimal_linux_live.iso' not found."; exit 1; fi
	@echo "Launching QEMU..."
	@./qemu.sh

src:
	@echo "Generating source archive..."
	@rm -f minimal_linux_live_*_src.tar.xz
	@cd minimal_overlay && ./overlay_build.sh mll_source 1>/dev/null && cd ..
	@$(eval DATE_PARSED := $(shell LANG=en_US ; date +"%d-%b-%Y"))
	@cd work/overlay_rootfs/usr/src && tar -cpf - `ls -A` | xz - > ../../../../minimal_linux_live_$(DATE_PARSED)_src.tar.xz && cd ../../../..
	@echo "Source archive: minimal_linux_live_$(DATE_PARSED)_src.tar.xz"

help:
	@echo ""
	@echo "    make all          clean the workspace and then generate \"minimal_linux_live.iso\""
	@echo ""
	@echo "    make clean        remove all generated files"
	@echo ""
	@echo "    make src          generate 'tar.xz' source archive"
	@echo ""
	@echo "    make qemu         run \"Minimal Linux Live\" in qemu"
	@echo ""
	@echo "    make help         this is the default target"
	@echo ""
