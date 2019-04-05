#
# flashimage
#

flashimage:
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), fortis_hdbox octagon1008 ufs910 ufs922 ipbox55 ipbox99 ipbox9900 cuberevo cuberevo_mini cuberevo_mini2 cuberevo_250hd cuberevo_2000hd cuberevo_3000hd))
	cd $(BASE_DIR)/flash/nor_flash && $(SUDOCMD) ./make_flash.sh $(MAINTAINER)
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), spark spark7162))
	cd $(BASE_DIR)/flash/$(BOXTYPE) && $(SUDOCMD) ./$(BOXTYPE).sh $(MAINTAINER)
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), atevio7500))
	cd $(BASE_DIR)/flash/$(BOXTYPE) && $(SUDOCMD) ./$(BOXTYPE).sh $(MAINTAINER)
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), ufs912))
	cd $(BASE_DIR)/flash/$(BOXTYPE) && $(SUDOCMD) ./$(BOXTYPE).sh $(MAINTAINER)
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), ufs913))
	cd $(BASE_DIR)/flash/$(BOXTYPE) && $(SUDOCMD) ./$(BOXTYPE).sh $(MAINTAINER)
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), ufc960))
	cd $(BASE_DIR)/flash/$(BOXTYPE) && $(SUDOCMD) ./$(BOXTYPE).sh $(MAINTAINER)
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), tf7700))
	cd $(BASE_DIR)/flash/$(BOXTYPE) && $(SUDOCMD) ./$(BOXTYPE).sh $(MAINTAINER)
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), hd51))
	$(MAKE) flash-image-hd51-multi-disk flash-image-hd51-multi-rootfs
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), bre2ze4k))
	$(MAKE) flash-image-bre2ze4k-multi-disk flash-image-bre2ze4k-multi-rootfs
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), hd60 hd61))
	$(MAKE) flash-image-hd60-multi-disk
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), vusolo4k))
	$(MAKE) flash-image-vusolo4k-multi-disk flash-image-vusolo4k-multi-rootfs
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), vuduo))
	$(MAKE) flash-image-vuduo
endif
	$(TUXBOX_CUSTOMIZE)

ofgimage:
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), hd51))
	$(MAKE) ITYPE=ofg flash-image-hd51-multi-rootfs
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), bre2ze4k))
	$(MAKE) ITYPE=ofg flash-image-bre2ze4k-multi-rootfs
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), vusolo4k))
	$(MAKE) ITYPE=ofg flash-image-vusolo4k-multi-rootfs
endif
	$(TUXBOX_CUSTOMIZE)

oi \
online-image:
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), hd51))
	$(MAKE) ITYPE=online flash-image-hd51-online
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), bre2ze4k))
	$(MAKE) ITYPE=online flash-image-bre2ze4k-online
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), vusolo4k))
	$(MAKE) ITYPE=online flash-image-vusolo4k-online
endif
	$(TUXBOX_CUSTOMIZE)

flash-clean:
	cd $(BASE_DIR)/flash/nor_flash && $(SUDOCMD) rm -rf ./tmp ./out
	cd $(BASE_DIR)/flash/spark7162 && $(SUDOCMD) rm -rf ./tmp ./out
	cd $(BASE_DIR)/flash/atevio7500 && $(SUDOCMD) rm -rf ./tmp ./out
	cd $(BASE_DIR)/flash/ufs912 && $(SUDOCMD) rm -rf ./tmp ./out
	cd $(BASE_DIR)/flash/ufs913 && $(SUDOCMD) rm -rf ./tmp ./out
	cd $(BASE_DIR)/flash/ufc960 && $(SUDOCMD) rm -rf ./tmp ./out
	cd $(BASE_DIR)/flash/tf7700 && $(SUDOCMD) rm -rf ./tmp ./out
	echo ""

ITYPE ?= usb

### armbox hd51

# general
HD51_IMAGE_NAME = disk
HD51_BOOT_IMAGE = boot.img
HD51_IMAGE_LINK = $(HD51_IMAGE_NAME).ext4
HD51_IMAGE_ROOTFS_SIZE = 294912
HD51_BUILD_TMP = $(BUILD_TMP)/image-build

### armbox bre2ze4k

# general
BRE2ZE4K_IMAGE_NAME = disk
BRE2ZE4K_BOOT_IMAGE = boot.img
BRE2ZE4K_IMAGE_LINK = $(BRE2ZE4K_IMAGE_NAME).ext4
BRE2ZE4K_IMAGE_ROOTFS_SIZE = 294912
BRE2ZE4K_BUILD_TMP = $(BUILD_TMP)/image-build
BRE2ZE4K_BOXMODE ?= 1
ifeq ($(BRE2ZE4K_BOXMODE), $(filter $(BRE2ZE4K_BOXMODE), 1))
BRE2ZE4K_BOXMODE_MEM = brcm_cma=440M@328M brcm_cma=192M@768M
else
BRE2ZE4K_BOXMODE_MEM = brcm_cma=520M@248M brcm_cma=200M@768M
endif

# emmc image
EMMC_IMAGE_SIZE = 3817472
EMMC_IMAGE ?= $(BUILD_TMP)/image-build/disk.img
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), hd51))
EMMC_IMAGE = $(HD51_BUILD_TMP)/$(HD51_IMAGE_NAME).img
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), bre2ze4k))
EMMC_IMAGE = $(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_IMAGE_NAME).img
endif

# partition sizes
BLOCK_SIZE = 512
BLOCK_SECTOR = 2
IMAGE_ROOTFS_ALIGNMENT = 1024
BOOT_PARTITION_SIZE = 3072
KERNEL_PARTITION_OFFSET = $(shell expr $(IMAGE_ROOTFS_ALIGNMENT) \+ $(BOOT_PARTITION_SIZE))
KERNEL_PARTITION_SIZE = 8192
ROOTFS_PARTITION_OFFSET = $(shell expr $(KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))

# partition sizes multi
# without swap data partition 819200
ROOTFS_PARTITION_SIZE_MULTI = 768000
# 51200 * 4
SWAP_DATA_PARTITION_SIZE = 204800

SECOND_KERNEL_PARTITION_OFFSET = $(shell expr $(ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
SECOND_ROOTFS_PARTITION_OFFSET = $(shell expr $(SECOND_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))

THIRD_KERNEL_PARTITION_OFFSET = $(shell expr $(SECOND_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
THIRD_ROOTFS_PARTITION_OFFSET = $(shell expr $(THIRD_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))

FOURTH_KERNEL_PARTITION_OFFSET = $(shell expr $(THIRD_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
FOURTH_ROOTFS_PARTITION_OFFSET = $(shell expr $(FOURTH_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))

SWAP_DATA_PARTITION_OFFSET = $(shell expr $(FOURTH_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))

SWAP_PARTITION_OFFSET = $(shell expr $(SWAP_DATA_PARTITION_OFFSET) \+ $(SWAP_DATA_PARTITION_SIZE))

flash-image-hd51-multi-disk: $(D)/host_resize2fs
	rm -rf $(HD51_BUILD_TMP)
	mkdir -p $(HD51_BUILD_TMP)/$(BOXTYPE)
	# Create a sparse image block
	dd if=/dev/zero of=$(HD51_BUILD_TMP)/$(HD51_IMAGE_LINK) seek=$(shell expr $(HD51_IMAGE_ROOTFS_SIZE) \* $(BLOCK_SECTOR)) count=0 bs=$(BLOCK_SIZE)
	$(HOST_DIR)/bin/mkfs.ext4 -F $(HD51_BUILD_TMP)/$(HD51_IMAGE_LINK) -d $(RELEASE_DIR)
	# Error codes 0-3 indicate successfull operation of fsck (no errors or errors corrected)
	$(HOST_DIR)/bin/fsck.ext4 -pvfD $(HD51_BUILD_TMP)/$(HD51_IMAGE_LINK) || [ $? -le 3 ]
	dd if=/dev/zero of=$(EMMC_IMAGE) bs=$(BLOCK_SIZE) count=0 seek=$(shell expr $(EMMC_IMAGE_SIZE) \* $(BLOCK_SECTOR))
	parted -s $(EMMC_IMAGE) mklabel gpt
	parted -s $(EMMC_IMAGE) unit KiB mkpart boot fat16 $(IMAGE_ROOTFS_ALIGNMENT) $(shell expr $(IMAGE_ROOTFS_ALIGNMENT) \+ $(BOOT_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart kernel1 $(KERNEL_PARTITION_OFFSET) $(shell expr $(KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart rootfs1 ext4 $(ROOTFS_PARTITION_OFFSET) $(shell expr $(ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
	parted -s $(EMMC_IMAGE) unit KiB mkpart kernel2 $(SECOND_KERNEL_PARTITION_OFFSET) $(shell expr $(SECOND_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart rootfs2 ext4 $(SECOND_ROOTFS_PARTITION_OFFSET) $(shell expr $(SECOND_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
	parted -s $(EMMC_IMAGE) unit KiB mkpart kernel3 $(THIRD_KERNEL_PARTITION_OFFSET) $(shell expr $(THIRD_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart rootfs3 ext4 $(THIRD_ROOTFS_PARTITION_OFFSET) $(shell expr $(THIRD_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
	parted -s $(EMMC_IMAGE) unit KiB mkpart kernel4 $(FOURTH_KERNEL_PARTITION_OFFSET) $(shell expr $(FOURTH_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart rootfs4 ext4 $(FOURTH_ROOTFS_PARTITION_OFFSET) $(shell expr $(FOURTH_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
	parted -s $(EMMC_IMAGE) unit KiB mkpart swapdata ext4 $(SWAP_DATA_PARTITION_OFFSET) $(shell expr $(SWAP_DATA_PARTITION_OFFSET) \+ $(SWAP_DATA_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart swap linux-swap $(SWAP_PARTITION_OFFSET) $(shell expr $(EMMC_IMAGE_SIZE) \- 1024)
	dd if=/dev/zero of=$(HD51_BUILD_TMP)/$(HD51_BOOT_IMAGE) bs=$(BLOCK_SIZE) count=$(shell expr $(BOOT_PARTITION_SIZE) \* $(BLOCK_SECTOR))
	mkfs.msdos -S 512 $(HD51_BUILD_TMP)/$(HD51_BOOT_IMAGE)
	echo "boot emmcflash0.kernel1 'brcm_cma=440M@328M brcm_cma=192M@768M root=/dev/mmcblk0p3 rw rootwait $(BOXTYPE)_4.boxmode=1'" > $(HD51_BUILD_TMP)/STARTUP
	echo "boot emmcflash0.kernel1 'brcm_cma=440M@328M brcm_cma=192M@768M root=/dev/mmcblk0p3 rw rootwait $(BOXTYPE)_4.boxmode=1'" > $(HD51_BUILD_TMP)/STARTUP_1
	echo "boot emmcflash0.kernel2 'brcm_cma=440M@328M brcm_cma=192M@768M root=/dev/mmcblk0p5 rw rootwait $(BOXTYPE)_4.boxmode=1'" > $(HD51_BUILD_TMP)/STARTUP_2
	echo "boot emmcflash0.kernel3 'brcm_cma=440M@328M brcm_cma=192M@768M root=/dev/mmcblk0p7 rw rootwait $(BOXTYPE)_4.boxmode=1'" > $(HD51_BUILD_TMP)/STARTUP_3
	echo "boot emmcflash0.kernel4 'brcm_cma=440M@328M brcm_cma=192M@768M root=/dev/mmcblk0p9 rw rootwait $(BOXTYPE)_4.boxmode=1'" > $(HD51_BUILD_TMP)/STARTUP_4
	echo "boot emmcflash0.kernel1 'brcm_cma=520M@248M brcm_cma=200M@768M root=/dev/mmcblk0p3 rw rootwait $(BOXTYPE)_4.boxmode=12'" > $(HD51_BUILD_TMP)/STARTUP_1_12
	echo "boot emmcflash0.kernel2 'brcm_cma=520M@248M brcm_cma=200M@768M root=/dev/mmcblk0p5 rw rootwait $(BOXTYPE)_4.boxmode=12'" > $(HD51_BUILD_TMP)/STARTUP_2_12
	echo "boot emmcflash0.kernel3 'brcm_cma=520M@248M brcm_cma=200M@768M root=/dev/mmcblk0p7 rw rootwait $(BOXTYPE)_4.boxmode=12'" > $(HD51_BUILD_TMP)/STARTUP_3_12
	echo "boot emmcflash0.kernel4 'brcm_cma=520M@248M brcm_cma=200M@768M root=/dev/mmcblk0p9 rw rootwait $(BOXTYPE)_4.boxmode=12'" > $(HD51_BUILD_TMP)/STARTUP_4_12
	mcopy -i $(HD51_BUILD_TMP)/$(HD51_BOOT_IMAGE) -v $(HD51_BUILD_TMP)/STARTUP ::
	mcopy -i $(HD51_BUILD_TMP)/$(HD51_BOOT_IMAGE) -v $(HD51_BUILD_TMP)/STARTUP_1 ::
	mcopy -i $(HD51_BUILD_TMP)/$(HD51_BOOT_IMAGE) -v $(HD51_BUILD_TMP)/STARTUP_2 ::
	mcopy -i $(HD51_BUILD_TMP)/$(HD51_BOOT_IMAGE) -v $(HD51_BUILD_TMP)/STARTUP_3 ::
	mcopy -i $(HD51_BUILD_TMP)/$(HD51_BOOT_IMAGE) -v $(HD51_BUILD_TMP)/STARTUP_4 ::
	mcopy -i $(HD51_BUILD_TMP)/$(HD51_BOOT_IMAGE) -v $(HD51_BUILD_TMP)/STARTUP_1_12 ::
	mcopy -i $(HD51_BUILD_TMP)/$(HD51_BOOT_IMAGE) -v $(HD51_BUILD_TMP)/STARTUP_2_12 ::
	mcopy -i $(HD51_BUILD_TMP)/$(HD51_BOOT_IMAGE) -v $(HD51_BUILD_TMP)/STARTUP_3_12 ::
	mcopy -i $(HD51_BUILD_TMP)/$(HD51_BOOT_IMAGE) -v $(HD51_BUILD_TMP)/STARTUP_4_12 ::
	dd conv=notrunc if=$(HD51_BUILD_TMP)/$(HD51_BOOT_IMAGE) of=$(EMMC_IMAGE) bs=$(BLOCK_SIZE) seek=$(shell expr $(IMAGE_ROOTFS_ALIGNMENT) \* $(BLOCK_SECTOR))
	dd conv=notrunc if=$(RELEASE_DIR)/boot/zImage.dtb of=$(EMMC_IMAGE) bs=$(BLOCK_SIZE) seek=$(shell expr $(KERNEL_PARTITION_OFFSET) \* $(BLOCK_SECTOR))
	$(HOST_DIR)/bin/resize2fs $(HD51_BUILD_TMP)/$(HD51_IMAGE_LINK) $(ROOTFS_PARTITION_SIZE_MULTI)k
	# Truncate on purpose
	dd if=$(HD51_BUILD_TMP)/$(HD51_IMAGE_LINK) of=$(EMMC_IMAGE) bs=$(BLOCK_SIZE) seek=$(shell expr $(ROOTFS_PARTITION_OFFSET) \* $(BLOCK_SECTOR)) count=$(shell expr $(HD51_IMAGE_ROOTFS_SIZE) \* $(BLOCK_SECTOR))
	mv $(HD51_BUILD_TMP)/disk.img $(HD51_BUILD_TMP)/$(BOXTYPE)/

flash-image-hd51-multi-rootfs:
	# Create final USB-image
	mkdir -p $(HD51_BUILD_TMP)/$(BOXTYPE)
	cp $(RELEASE_DIR)/boot/zImage.dtb $(HD51_BUILD_TMP)/$(BOXTYPE)/kernel.bin
	cd $(RELEASE_DIR); \
	tar -cvf $(HD51_BUILD_TMP)/$(BOXTYPE)/rootfs.tar --exclude=zImage* . > /dev/null 2>&1; \
	bzip2 $(HD51_BUILD_TMP)/$(BOXTYPE)/rootfs.tar
	echo $(BOXTYPE)_DDT_usb_$(shell date '+%d%m%Y-%H%M%S') > $(HD51_BUILD_TMP)/$(BOXTYPE)/imageversion
	mkdir -p $(IMAGE_RELEASE_DIR)
	cd $(HD51_BUILD_TMP) && \
	zip -r $(IMAGE_RELEASE_DIR)/$(BOXTYPE)_multi_$(ITYPE)_$(shell date '+%d.%m.%Y-%H.%M').zip $(BOXTYPE)/rootfs.tar.bz2 $(BOXTYPE)/kernel.bin $(BOXTYPE)/disk.img $(BOXTYPE)/imageversion
	# cleanup
	rm -rf $(HD51_BUILD_TMP)

flash-image-hd51-online:
	# Create final USB-image
	mkdir -p $(HD51_BUILD_TMP)/$(BOXTYPE)
	cp $(RELEASE_DIR)/boot/zImage.dtb $(HD51_BUILD_TMP)/$(BOXTYPE)/kernel.bin
	cd $(RELEASE_DIR); \
	tar -cvf $(HD51_BUILD_TMP)/$(BOXTYPE)/rootfs.tar --exclude=zImage* . > /dev/null 2>&1; \
	bzip2 $(HD51_BUILD_TMP)/$(BOXTYPE)/rootfs.tar
	echo $(BOXTYPE)_DDT_usb_$(shell date '+%d%m%Y-%H%M%S') > $(HD51_BUILD_TMP)/$(BOXTYPE)/imageversion
	mkdir -p $(IMAGE_RELEASE_DIR)
	cd $(HD51_BUILD_TMP)/$(BOXTYPE) && \
	tar -cvzf $(IMAGE_RELEASE_DIR)/$(BOXTYPE)_multi_$(ITYPE)_$(shell date '+%d.%m.%Y-%H.%M').tgz rootfs.tar.bz2 kernel.bin imageversion
	# cleanup
	rm -rf $(HD51_BUILD_TMP)

flash-image-bre2ze4k-multi-disk: $(D)/host_resize2fs
	rm -rf $(BRE2ZE4K_BUILD_TMP)
	mkdir -p $(BRE2ZE4K_BUILD_TMP)/$(BOXTYPE)
	# Create a sparse image block
	dd if=/dev/zero of=$(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_IMAGE_LINK) seek=$(shell expr $(BRE2ZE4K_IMAGE_ROOTFS_SIZE) \* $(BLOCK_SECTOR)) count=0 bs=$(BLOCK_SIZE)
	$(HOST_DIR)/bin/mkfs.ext4 -F $(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_IMAGE_LINK) -d $(RELEASE_DIR)
	# Error codes 0-3 indicate successfull operation of fsck (no errors or errors corrected)
	$(HOST_DIR)/bin/fsck.ext4 -pvfD $(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_IMAGE_LINK) || [ $? -le 3 ]
	dd if=/dev/zero of=$(EMMC_IMAGE) bs=$(BLOCK_SIZE) count=0 seek=$(shell expr $(EMMC_IMAGE_SIZE) \* $(BLOCK_SECTOR))
	parted -s $(EMMC_IMAGE) mklabel gpt
	parted -s $(EMMC_IMAGE) unit KiB mkpart boot fat16 $(IMAGE_ROOTFS_ALIGNMENT) $(shell expr $(IMAGE_ROOTFS_ALIGNMENT) \+ $(BOOT_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart kernel1 $(KERNEL_PARTITION_OFFSET) $(shell expr $(KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart rootfs1 ext4 $(ROOTFS_PARTITION_OFFSET) $(shell expr $(ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
	parted -s $(EMMC_IMAGE) unit KiB mkpart kernel2 $(SECOND_KERNEL_PARTITION_OFFSET) $(shell expr $(SECOND_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart rootfs2 ext4 $(SECOND_ROOTFS_PARTITION_OFFSET) $(shell expr $(SECOND_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
	parted -s $(EMMC_IMAGE) unit KiB mkpart kernel3 $(THIRD_KERNEL_PARTITION_OFFSET) $(shell expr $(THIRD_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart rootfs3 ext4 $(THIRD_ROOTFS_PARTITION_OFFSET) $(shell expr $(THIRD_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
	parted -s $(EMMC_IMAGE) unit KiB mkpart kernel4 $(FOURTH_KERNEL_PARTITION_OFFSET) $(shell expr $(FOURTH_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart rootfs4 ext4 $(FOURTH_ROOTFS_PARTITION_OFFSET) $(shell expr $(FOURTH_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
	parted -s $(EMMC_IMAGE) unit KiB mkpart swapdata ext4 $(SWAP_DATA_PARTITION_OFFSET) $(shell expr $(SWAP_DATA_PARTITION_OFFSET) \+ $(SWAP_DATA_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart swap linux-swap $(SWAP_PARTITION_OFFSET) $(shell expr $(EMMC_IMAGE_SIZE) \- 1024)
	dd if=/dev/zero of=$(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_BOOT_IMAGE) bs=$(BLOCK_SIZE) count=$(shell expr $(BOOT_PARTITION_SIZE) \* $(BLOCK_SECTOR))
	mkfs.msdos -S 512 $(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_BOOT_IMAGE)
	echo "boot emmcflash0.kernel1 '$(BRE2ZE4K_BOXMODE_MEM) root=/dev/mmcblk0p3 rw rootwait $(BOXTYPE)_4.boxmode=$(BRE2ZE4K_BOXMODE)'" > $(BRE2ZE4K_BUILD_TMP)/STARTUP
	echo "boot emmcflash0.kernel1 '$(BRE2ZE4K_BOXMODE_MEM) root=/dev/mmcblk0p3 rw rootwait $(BOXTYPE)_4.boxmode=$(BRE2ZE4K_BOXMODE)'" > $(BRE2ZE4K_BUILD_TMP)/STARTUP_1
	echo "boot emmcflash0.kernel2 '$(BRE2ZE4K_BOXMODE_MEM) root=/dev/mmcblk0p5 rw rootwait $(BOXTYPE)_4.boxmode=$(BRE2ZE4K_BOXMODE)'" > $(BRE2ZE4K_BUILD_TMP)/STARTUP_2
	echo "boot emmcflash0.kernel3 '$(BRE2ZE4K_BOXMODE_MEM) root=/dev/mmcblk0p7 rw rootwait $(BOXTYPE)_4.boxmode=$(BRE2ZE4K_BOXMODE)'" > $(BRE2ZE4K_BUILD_TMP)/STARTUP_3
	echo "boot emmcflash0.kernel4 '$(BRE2ZE4K_BOXMODE_MEM) root=/dev/mmcblk0p9 rw rootwait $(BOXTYPE)_4.boxmode=$(BRE2ZE4K_BOXMODE)'" > $(HBRE2ZE4K_BUILD_TMP)/STARTUP_4
	mcopy -i $(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_BOOT_IMAGE) -v $(BRE2ZE4K_BUILD_TMP)/STARTUP ::
	mcopy -i $(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_BOOT_IMAGE) -v $(BRE2ZE4K_BUILD_TMP)/STARTUP_1 ::
	mcopy -i $(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_BOOT_IMAGE) -v $(BRE2ZE4K_BUILD_TMP)/STARTUP_2 ::
	mcopy -i $(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_BOOT_IMAGE) -v $(BRE2ZE4K_BUILD_TMP)/STARTUP_3 ::
	mcopy -i $(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_BOOT_IMAGE) -v $(BRE2ZE4K_BUILD_TMP)/STARTUP_4 ::
	dd conv=notrunc if=$(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_BOOT_IMAGE) of=$(EMMC_IMAGE) bs=$(BLOCK_SIZE) seek=$(shell expr $(IMAGE_ROOTFS_ALIGNMENT) \* $(BLOCK_SECTOR))
	dd conv=notrunc if=$(RELEASE_DIR)/boot/zImage.dtb of=$(EMMC_IMAGE) bs=$(BLOCK_SIZE) seek=$(shell expr $(KERNEL_PARTITION_OFFSET) \* $(BLOCK_SECTOR))
	$(HOST_DIR)/bin/resize2fs $(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_IMAGE_LINK) $(ROOTFS_PARTITION_SIZE_MULTI)k
	# Truncate on purpose
	dd if=$(BRE2ZE4K_BUILD_TMP)/$(BRE2ZE4K_IMAGE_LINK) of=$(EMMC_IMAGE) bs=$(BLOCK_SIZE) seek=$(shell expr $(ROOTFS_PARTITION_OFFSET) \* $(BLOCK_SECTOR)) count=$(shell expr $(BRE2ZE4K_IMAGE_ROOTFS_SIZE) \* $(BLOCK_SECTOR))
	mv $(BRE2ZE4K_BUILD_TMP)/disk.img $(BRE2ZE4K_BUILD_TMP)/$(BOXTYPE)/

flash-image-bre2ze4k-multi-rootfs:
	# Create final USB-image
	mkdir -p $(BRE2ZE4K_BUILD_TMP)/$(BOXTYPE)
	cp $(RELEASE_DIR)/boot/zImage.dtb $(BRE2ZE4K_BUILD_TMP)/$(BOXTYPE)/kernel.bin
	cd $(RELEASE_DIR); \
	tar -cvf $(BRE2ZE4K_BUILD_TMP)/$(BOXTYPE)/rootfs.tar --exclude=zImage* . > /dev/null 2>&1; \
	bzip2 $(BRE2ZE4K_BUILD_TMP)/$(BOXTYPE)/rootfs.tar
	echo $(BOXTYPE)_DDT_usb_$(shell date '+%d%m%Y-%H%M%S') > $(BRE2ZE4K_BUILD_TMP)/$(BOXTYPE)/imageversion
	mkdir -p $(IMAGE_RELEASE_DIR)
	cd $(BRE2ZE4K_BUILD_TMP) && \
	zip -r $(IMAGE_RELEASE_DIR)/$(BOXTYPE)_multi_$(ITYPE)_$(shell date '+%d.%m.%Y-%H.%M').zip $(BOXTYPE)/rootfs.tar.bz2 $(BOXTYPE)/kernel.bin $(BOXTYPE)/disk.img $(BOXTYPE)/imageversion
	# cleanup
	rm -rf $(BRE2ZE4K_BUILD_TMP)

flash-image-bre2ze4k-online:
	# Create final USB-image
	mkdir -p $(BRE2ZE4K_BUILD_TMP)/$(BOXTYPE)
	cp $(RELEASE_DIR)/boot/zImage.dtb $(BRE2ZE4K_BUILD_TMP)/$(BOXTYPE)/kernel.bin
	cd $(RELEASE_DIR); \
	tar -cvf $(BRE2ZE4K_BUILD_TMP)/$(BOXTYPE)/rootfs.tar --exclude=zImage* . > /dev/null 2>&1; \
	bzip2 $(BRE2ZE4K_BUILD_TMP)/$(BOXTYPE)/rootfs.tar
	echo $(BOXTYPE)_DDT_usb_$(shell date '+%d%m%Y-%H%M%S') > $(BRE2ZE4K_BUILD_TMP)/$(BOXTYPE)/imageversion
	mkdir -p $(IMAGE_RELEASE_DIR)
	cd $(BRE2ZE4K_BUILD_TMP)/$(BOXTYPE) && \
	tar -cvzf $(IMAGE_RELEASE_DIR)/$(BOXTYPE)_multi_$(ITYPE)_$(shell date '+%d.%m.%Y-%H.%M').tgz rootfs.tar.bz2 kernel.bin imageversion
	# cleanup
	rm -rf $(BRE2ZE4K_BUILD_TMP)

### armbox hd60
HD60_BUILD_TMP = $(BUILD_TMP)/image-build
HD60_IMAGE_NAME = disk
HD60_BOOT_IMAGE = bootoptions.img
HD60_IMAGE_LINK = $(HD60_IMAGE_NAME).ext4

HD60_BOOTOPTIONS_PARTITION_SIZE = 32768
HD60_IMAGE_ROOTFS_SIZE = 1024M

HD60_BOOTARGS_DATE =20190201
HD60_BOOTARGS_SRC = $(KERNEL_TYPE)-bootargs-$(HD60_BOOTARGS_DATE).zip
HD60_PARTITONS_DATE = 20190201
HD60_PARTITONS_SRC = $(KERNEL_TYPE)-partitions-$(HD60_PARTITONS_DATE).zip

$(ARCHIVE)/$(HD60_BOOTARGS_SRC):
	$(WGET) http://downloads.mutant-digital.net/$(KERNEL_TYPE)/$(HD60_BOOTARGS_SRC)

$(ARCHIVE)/$(HD60_PARTITONS_SRC):
	$(WGET) http://downloads.mutant-digital.net/$(KERNEL_TYPE)/$(HD60_PARTITONS_SRC)

flash-image-hd60-multi-disk: $(ARCHIVE)/$(HD60_BOOTARGS_SRC) $(ARCHIVE)/$(HD60_PARTITONS_SRC)
	# Create image
	mkdir -p $(HD60_BUILD_TMP)/$(BOXTYPE)
	unzip -o $(ARCHIVE)/$(HD60_BOOTARGS_SRC) -d $(HD60_BUILD_TMP)
	unzip -o $(ARCHIVE)/$(HD60_PARTITONS_SRC) -d $(HD60_BUILD_TMP)
	install -m 0755 $(HD60_BUILD_TMP)/bootargs-8gb.bin $(RELEASE_DIR)/usr/share/bootargs.bin
	install -m 0755 $(HD60_BUILD_TMP)/fastboot.bin $(RELEASE_DIR)/usr/share/fastboot.bin
	if [ -e $(RELEASE_DIR)/boot/logo.img ]; then \
		cp -rf $(RELEASE_DIR)/boot/logo.img $(HD60_BUILD_TMP)/$(BOXTYPE); \
	fi
	echo $(BOXTYPE)_DDT_usb_$(shell date '+%d%m%Y-%H%M%S') > $(HD60_BUILD_TMP)/$(BOXTYPE)/imageversion
	$(HOST_DIR)/bin/make_ext4fs -l $(HD60_IMAGE_ROOTFS_SIZE) $(HD60_BUILD_TMP)/$(HD60_IMAGE_LINK) $(RELEASE_DIR)
	$(HOST_DIR)/bin/ext2simg -zv $(HD60_BUILD_TMP)/$(HD60_IMAGE_LINK) $(HD60_BUILD_TMP)/$(BOXTYPE)/rootfs.fastboot.gz
	dd if=/dev/zero of=$(HD60_BUILD_TMP)/$(BOXTYPE)/$(HD60_BOOT_IMAGE) bs=1024 count=$(HD60_BOOTOPTIONS_PARTITION_SIZE)
	mkfs.msdos -S 512 $(HD60_BUILD_TMP)/$(BOXTYPE)/$(HD60_BOOT_IMAGE)
	echo "bootcmd=mmc read 0 0x1000000 0x54B000 0x8000; bootm 0x1000000 bootargs=console=ttyAMA0,115200 root=/dev/mmcblk0p21 rootfstype=ext4" > $(HD60_BUILD_TMP)/STARTUP
	echo "bootcmd=mmc read 0 0x3F000000 0x7E000 0x4000; bootm 0x3F000000; mmc read 0 0x1FFBFC0 0x60000 0xC800; bootargs=androidboot.selinux=enforcing androidboot.serialno=0123456789 console=ttyAMA0,115200" > $(HD60_BUILD_TMP)/STARTUP_ANDROID
	echo "bootcmd=mmc read 0 0x1000000 0x54B000 0x8000; bootm 0x1000000 bootargs=console=ttyAMA0,115200 root=/dev/mmcblk0p21 rootfstype=ext4" > $(HD60_BUILD_TMP)/STARTUP_LINUX
	mcopy -i $(HD60_BUILD_TMP)/$(BOXTYPE)/$(HD60_BOOT_IMAGE) -v $(HD60_BUILD_TMP)/STARTUP ::
	mcopy -i $(HD60_BUILD_TMP)/$(BOXTYPE)/$(HD60_BOOT_IMAGE) -v $(HD60_BUILD_TMP)/STARTUP_ANDROID ::
	mcopy -i $(HD60_BUILD_TMP)/$(BOXTYPE)/$(HD60_BOOT_IMAGE) -v $(HD60_BUILD_TMP)/STARTUP_LINUX ::
	mv $(HD60_BUILD_TMP)/bootargs-8gb.bin $(HD60_BUILD_TMP)/bootargs.bin
	mv $(HD60_BUILD_TMP)/$(BOXTYPE)/bootargs-8gb.bin $(HD60_BUILD_TMP)/$(BOXTYPE)/bootargs.bin
	cp $(RELEASE_DIR)/boot/uImage $(HD60_BUILD_TMP)/$(BOXTYPE)/uImage
	rm -rf $(HD60_BUILD_TMP)/STARTUP*
	rm -rf $(HD60_BUILD_TMP)/*.txt
	rm -rf $(HD60_BUILD_TMP)/$(BOXTYPE)/*.txt
	rm -rf $(HD60_BUILD_TMP)/$(HD60_IMAGE_LINK)
	mkdir -p $(IMAGE_RELEASE_DIR)
	cd $(HD60_BUILD_TMP) && \
	zip -r $(IMAGE_RELEASE_DIR)/$(BOXTYPE)_multi_usb_$(shell date '+%d.%m.%Y-%H.%M').zip *
	# cleanup
	rm -rf $(HD60_BUILD_TMP)

### armbox vusolo4k

# general
VUSOLO4K_IMAGE_NAME = disk
VUSOLO4K_BOOT_IMAGE = boot.img
VUSOLO4K_IMAGE_LINK = $(VUSOLO4K_IMAGE_NAME).ext4
VUSOLO4K_IMAGE_ROOTFS_SIZE = 294912
VUSOLO4K_BUILD_TMP = $(BUILD_TMP)/image-build
VUSOLO4K_PREFIX = vuplus/solo4k

# emmc image
EMMC_IMAGE_SIZE = 3817472
EMMC_IMAGE = $(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_IMAGE_NAME).img

# partition sizes
BLOCK_SIZE = 512
BLOCK_SECTOR = 2
IMAGE_ROOTFS_ALIGNMENT = 1024
BOOT_PARTITION_SIZE = 3072
KERNEL_PARTITION_OFFSET = $(shell expr $(IMAGE_ROOTFS_ALIGNMENT) \+ $(BOOT_PARTITION_SIZE))
KERNEL_PARTITION_SIZE = 8192
ROOTFS_PARTITION_OFFSET = $(shell expr $(KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))

# partition sizes multi
# without swap data partition 819200
ROOTFS_PARTITION_SIZE_MULTI = 768000
# 51200 * 4
SWAP_DATA_PARTITION_SIZE = 204800

SECOND_KERNEL_PARTITION_OFFSET = $(shell expr $(ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
SECOND_ROOTFS_PARTITION_OFFSET = $(shell expr $(SECOND_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))

THIRD_KERNEL_PARTITION_OFFSET = $(shell expr $(SECOND_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
THIRD_ROOTFS_PARTITION_OFFSET = $(shell expr $(THIRD_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))

FOURTH_KERNEL_PARTITION_OFFSET = $(shell expr $(THIRD_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
FOURTH_ROOTFS_PARTITION_OFFSET = $(shell expr $(FOURTH_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))

SWAP_DATA_PARTITION_OFFSET = $(shell expr $(FOURTH_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))

SWAP_PARTITION_OFFSET = $(shell expr $(SWAP_DATA_PARTITION_OFFSET) \+ $(SWAP_DATA_PARTITION_SIZE))

flash-image-vusolo4k-multi-disk: $(D)/host_resize2fs
	rm -rf $(VUSOLO4K_BUILD_TMP)
	mkdir -p $(VUSOLO4K_BUILD_TMP)/$(BOXTYPE)
	# Create a sparse image block
	dd if=/dev/zero of=$(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_IMAGE_LINK) seek=$(shell expr $(VUSOLO4K_IMAGE_ROOTFS_SIZE) \* $(BLOCK_SECTOR)) count=0 bs=$(BLOCK_SIZE)
	$(HOST_DIR)/bin/mkfs.ext4 -F $(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_IMAGE_LINK) -d $(RELEASE_DIR)
	# Error codes 0-3 indicate successfull operation of fsck (no errors or errors corrected)
	$(HOST_DIR)/bin/fsck.ext4 -pvfD $(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_IMAGE_LINK) || [ $? -le 3 ]
	dd if=/dev/zero of=$(EMMC_IMAGE) bs=$(BLOCK_SIZE) count=0 seek=$(shell expr $(EMMC_IMAGE_SIZE) \* $(BLOCK_SECTOR))
	parted -s $(EMMC_IMAGE) mklabel gpt
	parted -s $(EMMC_IMAGE) unit KiB mkpart boot fat16 $(IMAGE_ROOTFS_ALIGNMENT) $(shell expr $(IMAGE_ROOTFS_ALIGNMENT) \+ $(BOOT_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart kernel1 $(KERNEL_PARTITION_OFFSET) $(shell expr $(KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart rootfs1 ext4 $(ROOTFS_PARTITION_OFFSET) $(shell expr $(ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
	parted -s $(EMMC_IMAGE) unit KiB mkpart kernel2 $(SECOND_KERNEL_PARTITION_OFFSET) $(shell expr $(SECOND_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart rootfs2 ext4 $(SECOND_ROOTFS_PARTITION_OFFSET) $(shell expr $(SECOND_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
	parted -s $(EMMC_IMAGE) unit KiB mkpart kernel3 $(THIRD_KERNEL_PARTITION_OFFSET) $(shell expr $(THIRD_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart rootfs3 ext4 $(THIRD_ROOTFS_PARTITION_OFFSET) $(shell expr $(THIRD_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
	parted -s $(EMMC_IMAGE) unit KiB mkpart kernel4 $(FOURTH_KERNEL_PARTITION_OFFSET) $(shell expr $(FOURTH_KERNEL_PARTITION_OFFSET) \+ $(KERNEL_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart rootfs4 ext4 $(FOURTH_ROOTFS_PARTITION_OFFSET) $(shell expr $(FOURTH_ROOTFS_PARTITION_OFFSET) \+ $(ROOTFS_PARTITION_SIZE_MULTI))
	parted -s $(EMMC_IMAGE) unit KiB mkpart swapdata ext4 $(SWAP_DATA_PARTITION_OFFSET) $(shell expr $(SWAP_DATA_PARTITION_OFFSET) \+ $(SWAP_DATA_PARTITION_SIZE))
	parted -s $(EMMC_IMAGE) unit KiB mkpart swap linux-swap $(SWAP_PARTITION_OFFSET) $(shell expr $(EMMC_IMAGE_SIZE) \- 1024)
	dd if=/dev/zero of=$(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_BOOT_IMAGE) bs=$(BLOCK_SIZE) count=$(shell expr $(BOOT_PARTITION_SIZE) \* $(BLOCK_SECTOR))
	mkfs.msdos -S 512 $(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_BOOT_IMAGE)
	dd conv=notrunc if=$(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_BOOT_IMAGE) of=$(EMMC_IMAGE) bs=$(BLOCK_SIZE) seek=$(shell expr $(IMAGE_ROOTFS_ALIGNMENT) \* $(BLOCK_SECTOR))
#	dd conv=notrunc if=$(RELEASE_DIR)/boot/zImage.dtb of=$(EMMC_IMAGE) bs=$(BLOCK_SIZE) seek=$(shell expr $(KERNEL_PARTITION_OFFSET) \* $(BLOCK_SECTOR))
	$(HOST_DIR)/bin/resize2fs $(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_IMAGE_LINK) $(ROOTFS_PARTITION_SIZE_MULTI)k
	# Truncate on purpose
	dd if=$(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_IMAGE_LINK) of=$(EMMC_IMAGE) bs=$(BLOCK_SIZE) seek=$(shell expr $(ROOTFS_PARTITION_OFFSET) \* $(BLOCK_SECTOR)) count=$(shell expr $(VUSOLO4K_IMAGE_ROOTFS_SIZE) \* $(BLOCK_SECTOR))
	mv $(VUSOLO4K_BUILD_TMP)/disk.img $(VUSOLO4K_BUILD_TMP)/$(BOXTYPE)/

flash-image-vusolo4k-multi-rootfs:
	# Create final USB-image
	mkdir -p $(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_PREFIX)
	cp $(RELEASE_DIR)/boot/vmlinuz-initrd-7366c0 $(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_PREFIX)/initrd_auto.bin
	cp $(RELEASE_DIR)/boot/zImage $(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_PREFIX)/kernel_auto.bin
	cd $(RELEASE_DIR); \
	tar -cvf $(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_PREFIX)/rootfs.tar --exclude=zImage* --exclude=vmlinuz-initrd* . > /dev/null 2>&1; \
	bzip2 $(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_PREFIX)/rootfs.tar
	echo This file forces a reboot after the update. > $(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_PREFIX)/reboot.update
	echo $(BOXTYPE)_DDT_usb_$(shell date '+%d%m%Y-%H%M%S') > $(VUSOLO4K_BUILD_TMP)/$(VUSOLO4K_PREFIX)/imageversion
	mkdir -p $(IMAGE_RELEASE_DIR)
	cd $(VUSOLO4K_BUILD_TMP) && \
	zip -r $(IMAGE_RELEASE_DIR)/$(BOXTYPE)_multi_$(ITYPE)_$(shell date '+%d.%m.%Y-%H.%M').zip $(VUSOLO4K_PREFIX)/rootfs.tar.bz2 $(VUSOLO4K_PREFIX)/initrd_auto.bin $(VUSOLO4K_PREFIX)/kernel_auto.bin $(VUSOLO4K_PREFIX)/reboot.update $(VUSOLO4K_PREFIX)/imageversion
	# cleanup
	rm -rf $(VUSOLO4K_BUILD_TMP)

flash-image-vusolo4k-online:
	# Create final USB-image
	mkdir -p $(VUSOLO4K_BUILD_TMP)/$(BOXTYPE)
	cp $(RELEASE_DIR)/boot/vmlinuz-initrd-7366c0 $(VUSOLO4K_BUILD_TMP)/$(BOXTYPE)/initrd_auto.bin
	cp $(RELEASE_DIR)/boot/zImage $(VUSOLO4K_BUILD_TMP)/$(BOXTYPE)/kernel_auto.bin
	cd $(RELEASE_DIR); \
	tar -cvf $(VUSOLO4K_BUILD_TMP)/$(BOXTYPE)/rootfs.tar --exclude=zImage* --exclude=vmlinuz-initrd* . > /dev/null 2>&1; \
	bzip2 $(VUSOLO4K_BUILD_TMP)/$(BOXTYPE)/rootfs.tar
	echo This file forces a reboot after the update. > $(VUSOLO4K_BUILD_TMP)/$(BOXTYPE)/reboot.update
	echo $(BOXTYPE)_DDT_usb_$(shell date '+%d%m%Y-%H%M%S') > $(VUSOLO4K_BUILD_TMP)/$(BOXTYPE)/imageversion
	mkdir -p $(IMAGE_RELEASE_DIR)
	cd $(VUSOLO4K_BUILD_TMP)/$(BOXTYPE) && \
	tar -cvzf $(IMAGE_RELEASE_DIR)/$(BOXTYPE)_multi_$(ITYPE)_$(shell date '+%d.%m.%Y-%H.%M').tgz rootfs.tar.bz2 initrd_auto.bin kernel_auto.bin reboot.update imageversion
	# cleanup
	rm -rf $(VUSOLO4K_BUILD_TMP)

VUDUO_PREFIX = vuplus/duo
VUDUO_BUILD_TMP = $(BUILD_TMP)/image-build
flash-image-vuduo:
	# Create final USB-image
	mkdir -p $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)
	touch $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/reboot.update
	cp $(RELEASE_DIR)/boot/kernel_cfe_auto.bin $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)
	mkfs.ubifs -r $(RELEASE_DIR) -o $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/root_cfe_auto.ubi -m 2048 -e 126976 -c 4096 -F
	echo '[ubifs]' > $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/ubinize.cfg
	echo 'mode=ubi' >> $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/ubinize.cfg
	echo 'image=$(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/root_cfe_auto.ubi' >> $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/ubinize.cfg
	echo 'vol_id=0' >> $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/ubinize.cfg
	echo 'vol_type=dynamic' >> $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/ubinize.cfg
	echo 'vol_name=rootfs' >> $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/ubinize.cfg
	echo 'vol_flags=autoresize' >> $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/ubinize.cfg
	ubinize -o $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/root_cfe_auto.jffs2 -m 2048 -p 128KiB $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/ubinize.cfg
	rm -f $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/root_cfe_auto.ubi
	rm -f $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/ubinize.cfg
	echo $(BOXTYPE)_DDT_usb_$(shell date '+%d%m%Y-%H%M%S') > $(VUDUO_BUILD_TMP)/$(VUDUO_PREFIX)/imageversion
	mkdir -p $(IMAGE_RELEASE_DIR)
	cd $(VUDUO_BUILD_TMP)/ && \
	zip -r $(IMAGE_RELEASE_DIR)/$(BOXTYPE)_usb_$(shell date '+%d.%m.%Y-%H.%M').zip $(VUDUO_PREFIX)*
	# cleanup
	rm -rf $(VUDUO_BUILD_TMP)
