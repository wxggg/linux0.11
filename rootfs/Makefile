
include ../Makefile.head

_HDA_IMG := $(CURDIR)/$(HDA_IMG)
_FLP_IMG := $(CURDIR)/$(FLP_IMG)
_RAM_IMG := $(CURDIR)/$(RAM_IMG)

hda: $(HDA_IMG).xz
ifneq ($(_HDA_IMG), $(wildcard $(_HDA_IMG)))
	$(Q)tar Jvxf $< >/dev/null 2>&1
endif

flp: $(FLP_IMG).xz
ifneq ($(_FLP_IMG), $(wildcard $(_FLP_IMG)))
	$(Q)tar Jvxf $< >/dev/null 2>&1
endif

ramfs: $(RAM_IMG).xz
ifneq ($(_RAM_IMG), $(wildcard $(_RAM_IMG)))
	$(Q)tar Jvxf $< >/dev/null 2>&1
endif

EXAMPLES ?= $(CURDIR)/../examples/

HDA_DIR = $(CURDIR)/_hda
hda-mount: hda
	$(Q)mkdir -p $(HDA_DIR)
	$(Q)sudo mount -o offset=1024 $(HDA_IMG) $(HDA_DIR)
hda-umount:
ifeq ($(HDA_DIR), $(wildcard $(HDA_DIR)))
	$(Q)sudo umount $(HDA_DIR)
	$(Q)rm -rf $(HDA_DIR)
endif

hda-install: hda-mount
	$(Q)sudo cp -r $(EXAMPLES) $(HDA_DIR)/usr/root/
	$(Q)sync
	$(Q)make $(S) hda-umount

FLP_DIR = $(CURDIR)/_flp
flp-mount: flp
	$(Q)mkdir -p $(FLP_DIR)
	$(Q)sudo mount -t minix $(FLP_IMG) $(FLP_DIR)
flp-umount:
ifeq ($(FLP_DIR), $(wildcard $(FLP_DIR)))
	$(Q)sudo umount $(FLP_DIR)
	$(Q)rm -rf $(FLP_DIR)
endif

flp-install: flp-mount
	$(Q)sudo cp -r $(EXAMPLES) $(FLP_DIR)/usr/root/
	$(Q)sync
	$(Q)make $(S) flp-umount

RAMFS_DIR = $(CURDIR)/_ramfs
ramfs-mount: ramfs
	$(Q)mkdir -p $(RAMFS_DIR)
	$(Q)sudo mount $(RAM_IMG) $(RAMFS_DIR)
ramfs-umount:
ifeq ($(RAMFS_DIR), $(wildcard $(RAMFS_DIR)))
	$(Q)sudo umount $(RAMFS_DIR)
	$(Q)rm -rf $(RAMFS_DIR)
endif

ramfs-install: ramfs-mount
	$(Q)sudo cp -r $(EXAMPLES) $(RAMFS_DIR)/usr/root/
	$(Q)sync
	$(Q)make $(S) ramfs-umount

clean:
	$(Q)rm -rf $(HDA_IMG) $(HDA_DIR)
	$(Q)rm -rf $(FLP_IMG) $(FLP_DIR)
	$(Q)rm -rf $(RAM_IMG) $(RAMFS_DIR)
