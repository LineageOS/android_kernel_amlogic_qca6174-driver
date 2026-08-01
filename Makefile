KERNEL_SRC ?= /lib/modules/$(shell uname -r)/build
M ?= $(shell pwd)

ifeq ($(O),)
out_dir := .
else
out_dir := $(O)
endif

AIO_BUILD_DIR := AIO/build
QCACLD_DIR := AIO/drivers/qcacld-new

# The AIO build framework names the module after MODNAME; the vendor wifi
# driver config builds qca6174 as wlan_6174.ko, not wlan.ko.
MODNAME := wlan_6174

# AIO/build/Makefile's own build entry point is "drivers" (the "default" goal
# defined by scripts/re-f30/Makefile.re-f30), not "modules" - remap just that
# one.  "modules_install" and "clean" exist there already.
TARGET = $(if $(filter modules,$(@)),drivers,$(@))

modules modules_install clean:
	$(MAKE) -C $(KERNEL_SRC)/$(M)/$(AIO_BUILD_DIR) M=$(M)/$(AIO_BUILD_DIR) KERNEL_SRC=$(KERNEL_SRC) \
		MODNAME=$(MODNAME) $(TARGET)
	if [ -e $(out_dir)/$(M)/$(QCACLD_DIR)/Module.symvers ]; then \
		ln -sf $(out_dir)/$(M)/$(QCACLD_DIR)/Module.symvers $(out_dir)/$(M)/Module.symvers; \
	fi
	if [ -e $(out_dir)/$(M)/$(QCACLD_DIR)/$(MODNAME).ko ]; then \
		ln -sf $(out_dir)/$(M)/$(QCACLD_DIR)/$(MODNAME).ko $(out_dir)/$(M)/$(MODNAME).ko; \
	fi
