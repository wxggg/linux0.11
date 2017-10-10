include ../Makefile.head

LDFLAGS	+= -Ttext 0 -e _start

all: bootsect setup

bootsect: bootsect.s
	$(Q)$(AS) -o bootsect.o bootsect.s
	$(Q)$(LD) $(LDFLAGS) -o bootsect bootsect.o
	$(Q)cp -f bootsect bootsect.sym
	$(Q)$(OBJCOPY) -R .pdr -R .comment -R.note -S -O binary bootsect

setup: setup.s
	$(Q)$(AS) -o setup.o setup.s
	$(Q)$(LD) $(LDFLAGS) -o setup setup.o
	$(Q)cp -f setup setup.sym
	$(Q)$(OBJCOPY) -R .pdr -R .comment -R.note -S -O binary setup

head.o: head.s
	$(Q)$(AS) -o head.o head.s

clean:
	$(Q)rm -f bootsect bootsect.o setup setup.o head.o
