#
# auxiliary targets for model-specific builds
#

#
# release_cube_common
#
neutrino_release_cube_common:
	install -m 0755 $(SKEL_ROOT)/release/halt_cuberevo $(RELEASE_DIR)/etc/init.d/halt
	install -m 0777 $(SKEL_ROOT)/release/reboot_cuberevo $(RELEASE_DIR)/etc/init.d/reboot
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox/micom.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/dvb-fe-cx24116.fw $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/

#
# release_cube_common_tuner
#
neutrino_release_cube_common_tuner:
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/multituner/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/media/dvb/frontends/dvb-pll.ko $(RELEASE_DIR)/lib/modules/

#
# cuberevo_9500hd
#
neutrino_release_cuberevo_9500hd: neutrino_release_cube_common neutrino_release_cube_common_tuner

#
# cuberevo_2000hd
#
neutrino_release_cuberevo_2000hd: neutrino_release_cube_common neutrino_release_cube_common_tuner

#
# cuberevo_250hd
#
neutrino_release_cuberevo_250hd: neutrino_release_cube_common neutrino_release_cube_common_tuner

#
# cuberevo_mini_fta
#
neutrino_release_cuberevo_mini_fta: neutrino_release_cube_common neutrino_release_cube_common_tuner

#
# cuberevo_mini2
#
neutrino_release_cuberevo_mini2: neutrino_release_cube_common neutrino_release_cube_common_tuner

#
# cuberevo_mini
#
neutrino_release_cuberevo_mini: neutrino_release_cube_common neutrino_release_cube_common_tuner

#
# cuberevo
#
neutrino_release_cuberevo: neutrino_release_cube_common neutrino_release_cube_common_tuner

#
# cuberevo_3000hd
#
neutrino_release_cuberevo_3000hd: neutrino_release_cube_common neutrino_release_cube_common_tuner

#
# common_ipbox
#
neutrino_release_common_ipbox:
	install -m 0755 $(SKEL_ROOT)/release/halt_ipbox $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/siinfo/siinfo.ko $(RELEASE_DIR)/lib/modules/
	cp -f $(SKEL_ROOT)/release/fstab_ipbox $(RELEASE_DIR)/etc/fstab
	cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/as102_data1_st.hex $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/as102_data2_st.hex $(RELEASE_DIR)/lib/firmware/
	cp -dp $(SKEL_ROOT)/release/lircd_ipbox.conf $(RELEASE_DIR)/etc/lircd.conf
	rm -f $(RELEASE_DIR)/lib/firmware/*
	rm -f $(RELEASE_DIR)/lib/modules/boxtype.ko
	rm -f $(RELEASE_DIR)/etc/network/interfaces

#
# ipbox9900
#
neutrino_release_ipbox9900: neutrino_release_common_ipbox
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox99xx/micom.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/rmu/rmu.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/ipbox99xx_fan/ipbox_fan.ko $(RELEASE_DIR)/lib/modules/
	cp -p $(SKEL_ROOT)/release/tvmode_ipbox $(RELEASE_DIR)/usr/bin/tvmode

#
# ipbox99
#
neutrino_release_ipbox99: neutrino_release_common_ipbox
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox99xx/micom.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/ipbox99xx_fan/ipbox_fan.ko $(RELEASE_DIR)/lib/modules/
	cp -p $(SKEL_ROOT)/release/tvmode_ipbox $(RELEASE_DIR)/usr/bin/tvmode

#
# ipbox55
#
neutrino_release_ipbox55: neutrino_release_common_ipbox
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox55/front.ko $(RELEASE_DIR)/lib/modules/
	cp -p $(SKEL_ROOT)/release/tvmode_ipbox55 $(RELEASE_DIR)/usr/bin/tvmode

#
# ufs910
#
neutrino_release_ufs910:
	install -m 0755 $(SKEL_ROOT)/release/halt_ufs $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/vfd/vfd.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7100.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7100.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/dvb-fe-cx21143.fw $(RELEASE_DIR)/lib/firmware/dvb-fe-cx24116.fw
	cp -dp $(SKEL_ROOT)/release/lircd_ufs910.conf $(RELEASE_DIR)/etc/lircd.conf
	rm -f $(RELEASE_DIR)/bin/vdstandby

#
# ufs912
#
neutrino_release_ufs912:
	install -m 0755 $(SKEL_ROOT)/release/halt_ufs912 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# ufs913
#
neutrino_release_ufs913:
	install -m 0755 $(SKEL_ROOT)/release/halt_ufs912 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/multituner/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7105.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7105.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7105.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/component_7105_pdk7105.fw $(RELEASE_DIR)/lib/firmware/component.fw
	cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/

#
# ufs922
#
neutrino_release_ufs922:
	install -m 0755 $(SKEL_ROOT)/release/halt_ufs $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/ufs922_fan/fan_ctrl.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/dvb-fe-cx21143.fw $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/

#
# ufc960
#
neutrino_release_ufc960:
	install -m 0755 $(SKEL_ROOT)/release/halt_ufs $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/dvb-fe-cx21143.fw $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/

#
# spark
#
neutrino_release_spark:
	install -m 0755 $(SKEL_ROOT)/release/halt_spark $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/aotom_spark/aotom.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	rm -f $(RELEASE_DIR)/bin/vdstandby
	cp -dp $(SKEL_ROOT)/release/lircd_spark.conf $(RELEASE_DIR)/etc/lircd.conf

#
# spark7162
#
neutrino_release_spark7162:
	install -m 0755 $(SKEL_ROOT)/release/halt_spark7162 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/aotom_spark/aotom.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7105.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp -f $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/i2c_spi/i2s.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7105.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7105.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/component_7105_pdk7105.fw $(RELEASE_DIR)/lib/firmware/component.fw
	rm -f $(RELEASE_DIR)/bin/vdstandby
	cp -dp $(SKEL_ROOT)/release/lircd_spark7162.conf $(RELEASE_DIR)/etc/lircd.conf
	cp $(SKEL_ROOT)/release/fw_env.config_$(BOXTYPE)_neutrino $(RELEASE_DIR)/etc/fw_env.config

#
# fortis_hdbox
#
neutrino_release_fortis_hdbox:
	install -m 0755 $(SKEL_ROOT)/release/halt_fortis_hdbox $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/lib/firmware/audio.elf

#
# atevio7500
#
neutrino_release_atevio7500:
	install -m 0755 $(SKEL_ROOT)/release/halt_fortis_hdbox $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/multituner/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7105.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7105.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7105.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/component_7105_pdk7105.fw $(RELEASE_DIR)/lib/firmware/component.fw
	cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/
	rm -f $(RELEASE_DIR)/lib/modules/boxtype.ko
	rm -f $(RELEASE_DIR)/lib/modules/mpeg2hw.ko

#
# octagon1008
#
neutrino_release_octagon1008:
	install -m 0755 $(SKEL_ROOT)/release/halt_octagon1008 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/

#
# hs7110
#
neutrino_release_hs7110:
	install -m 0755 $(SKEL_ROOT)/release/halt_hs7110 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# hs7420
#
neutrino_release_hs7420:
	install -m 0755 $(SKEL_ROOT)/release/halt_hs742x $(RELEASE_DIR)/etc/init.d/halt
	chmod 755 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# hs7429
#
neutrino_release_hs7429:
	install -m 0755 $(SKEL_ROOT)/release/halt_hs742x $(RELEASE_DIR)/etc/init.d/halt
	chmod 755 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# hs7810a
#
neutrino_release_hs7810a:
	install -m 0755 $(SKEL_ROOT)/release/halt_hs7810a $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fww

#
# hs7119
#
neutrino_release_hs7119:
	install -m 0755 $(SKEL_ROOT)/release/halt_hs7119 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# hs7819
#
neutrino_release_hs7819:
	install -m 0755 $(SKEL_ROOT)/release/halt_hs7819 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# atemio520
#
neutrino_release_atemio520:
	install -m 0755 $(SKEL_ROOT)/release/halt_atemio520 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cn_micom/cn_micom.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# atemio530
#
neutrino_release_atemio530:
	install -m 0755 $(SKEL_ROOT)/release/halt_atemio530 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cn_micom/cn_micom.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# hl101
#
neutrino_release_hl101:
	install -m 0755 $(SKEL_ROOT)/release/halt_hl101 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/proton/proton.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/as102_data1_st.hex $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/as102_data2_st.hex $(RELEASE_DIR)/lib/firmware/
	cp -dp $(SKEL_ROOT)/release/lircd_hl101.conf $(RELEASE_DIR)/etc/lircd.conf

#
# adb_box
#
neutrino_release_adb_box:
	install -m 0755 $(SKEL_ROOT)/release/halt_adb_box $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/adb_box_vfd/vfd.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7100.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/adb_box_fan/cooler.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cec_adb_box/cec_ctrl.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/dvbt/as102/dvb-as102.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7100.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/as102_data1_st.hex $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/as102_data2_st.hex $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	cp -f $(SKEL_ROOT)/release/fstab_adb_box $(RELEASE_DIR)/etc/fstab
	cp -dp $(SKEL_ROOT)/release/lircd_adb_box.conf $(RELEASE_DIR)/etc/lircd.conf

#
# tf7700
#
neutrino_release_tf7700:
	install -m 0755 $(SKEL_ROOT)/release/halt_tf7700 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/tffp/tffp.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/dvb-fe-cx24116.fw $(RELEASE_DIR)/lib/firmware/
	cp -f $(SKEL_ROOT)/release/fstab_tf7700 $(RELEASE_DIR)/etc/fstab
	$(MAKE) tfinstaller

#
# vitamin_hd5000
#
neutrino_release_vitamin_hd5000:
	install -m 0755 $(SKEL_ROOT)/release/halt_ufs912 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/vitamin_hd5000/micom.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/smartcard/smartcard.ko $(RELEASE_DIR)/lib/modules/
	cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# sagemcom88
#
neutrino_release_sagemcom88:
	install -m 0755 $(SKEL_ROOT)/release/halt_ufs912 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7105.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/front_led/front_led.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/front_vfd/front_vfd.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/sagemcomtype/boxtype.ko $(RELEASE_DIR)/lib/modules/
	[ -e $(SKEL_ROOT)/release/fe_core_sagemcom88$(KERNEL_STM_LABEL).ko ] && cp $(SKEL_ROOT)/release/fe_core_sagemcom88$(KERNEL_STM_LABEL).ko $(RELEASE_DIR)/lib/modules/fe_core.ko || true
	cp $(SKEL_ROOT)/boot/video_7105.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7105.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/component_7105_pdk7105.fw $(RELEASE_DIR)/lib/firmware/component.fw
	cp -dp $(SKEL_ROOT)/release/lircd_sagemcom88.conf $(RELEASE_DIR)/etc/lircd.conf

#
# arivalink200
#
neutrino_release_arivalink200:
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/front_ArivaLink200/vfd.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/front_ArivaLink200/vfd.ko $(RELEASE_DIR)/lib/modules/ || true
	cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/lib/firmware/video.elf
	cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	cp $(SKEL_ROOT)/firmware/dvb-fe-cx24116.fw $(RELEASE_DIR)/lib/firmware/
	cp -dp $(SKEL_ROOT)/release/lircd_arivalink200.conf $(RELEASE_DIR)/etc/lircd.conf

#
# Mutant HD51
#
neutrino_release_hd51:
	install -m 0755 $(SKEL_ROOT)/release/halt_hd51 $(RELEASE_DIR)/etc/init.d/halt
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/*.ko $(RELEASE_DIR)/lib/modules/
	cp $(TARGET_DIR)/boot/zImage.dtb $(RELEASE_DIR)/boot/
	install -m 0644 $(SKEL_ROOT)/release/mdev_hd51.conf $(RELEASE_DIR)/etc/mdev.conf
	find $(RELEASE_DIR)/usr/lib/ -name '*.a' -exec rm -f {} \;
	find $(RELEASE_DIR)/usr/lib/ -name '*.o' -exec rm -f {} \;
	find $(RELEASE_DIR)/usr/lib/ -name '*.la' -exec rm -f {} \;

#
# neutrino_release_base
#
# the following target creates the common file base
neutrino_release_base:
	rm -rf $(RELEASE_DIR) || true
	install -d $(RELEASE_DIR)
	install -d $(RELEASE_DIR)/{autofs,bin,boot,dev,dev.static,etc,hdd,home,lib,media,mnt,proc,ram,root,sbin,swap,sys,tmp,usr,var}
	install -d $(RELEASE_DIR)/etc/{init.d,network,mdev,ssl}
	install -d $(RELEASE_DIR)/etc/network/if-{post-{up,down},pre-{up,down},up,down}.d
	install -d $(RELEASE_DIR)/lib/{modules,udev,firmware,tuxbox}
	install -d $(RELEASE_DIR)/lib/tuxbox/plugins
	install -d $(RELEASE_DIR)/media/{dvd,nfs,usb,sda1,sdb1}
	ln -sf /hdd $(RELEASE_DIR)/media/hdd
	install -d $(RELEASE_DIR)/mnt/{hdd,nfs,usb}
	install -d $(RELEASE_DIR)/mnt/mnt{0..7}
	install -d $(RELEASE_DIR)/usr/{bin,lib,local,sbin,share}
	install -d $(RELEASE_DIR)/usr/local/{bin,sbin}
	install -d $(RELEASE_DIR)/usr/share/{fonts,tuxbox,udhcpc,zoneinfo,lua}
	install -d $(RELEASE_DIR)/usr/share/tuxbox/neutrino
	install -d $(RELEASE_DIR)/usr/share/tuxbox/neutrino/icons/logo
	install -d $(RELEASE_DIR)/usr/share/lua/5.2
	ln -sf /usr/share/tuxbox/neutrino/icons/logo $(RELEASE_DIR)/logos
	ln -sf /usr/share $(RELEASE_DIR)/share
	install -d $(RELEASE_DIR)/var/{bin,boot,emu,etc,epg,httpd,keys,lib,logos,net,tuxbox,update}
	install -d $(RELEASE_DIR)/var/lib/{nfs,modules}
	install -d $(RELEASE_DIR)/var/net/epg
	install -d $(RELEASE_DIR)/var/tuxbox/{config,locale,plugins,themes}
	install -d $(RELEASE_DIR)/var/tuxbox/plugins/webtv
	install -d $(RELEASE_DIR)/var/tuxbox/config/{webtv,zapit}
	mkdir -p $(RELEASE_DIR)/etc/rc.d/rc0.d
	ln -s ../init.d/sendsigs $(RELEASE_DIR)/etc/rc.d/rc0.d/S20sendsigs
	ln -s ../init.d/umountfs $(RELEASE_DIR)/etc/rc.d/rc0.d/S40umountfs
	ln -s ../init.d/halt $(RELEASE_DIR)/etc/rc.d/rc0.d/S90halt
	mkdir -p $(RELEASE_DIR)/etc/rc.d/rc6.d
	ln -s ../init.d/sendsigs $(RELEASE_DIR)/etc/rc.d/rc6.d/S20sendsigs
	ln -s ../init.d/umountfs $(RELEASE_DIR)/etc/rc.d/rc6.d/S40umountfs
	ln -s ../init.d/reboot $(RELEASE_DIR)/etc/rc.d/rc6.d/S90reboot
	ln -sf /usr/share/tuxbox/neutrino/icons/logo $(RELEASE_DIR)/var/httpd/logos
	touch $(RELEASE_DIR)/var/etc/.firstboot
	cp -a $(TARGET_DIR)/bin/* $(RELEASE_DIR)/bin/
	cp -a $(TARGET_DIR)/usr/bin/* $(RELEASE_DIR)/usr/bin/
	cp -a $(TARGET_DIR)/sbin/* $(RELEASE_DIR)/sbin/
	cp -a $(TARGET_DIR)/usr/sbin/* $(RELEASE_DIR)/usr/sbin/
	cp -dp $(TARGET_DIR)/var/etc/.version $(RELEASE_DIR)/
	ln -sf /.version $(RELEASE_DIR)/var/etc/.version
	cp $(TARGET_DIR)/boot/$(KERNELNAME) $(RELEASE_DIR)/boot/
	ln -sf /proc/mounts $(RELEASE_DIR)/etc/mtab
	cp -dp $(SKEL_ROOT)/sbin/MAKEDEV $(RELEASE_DIR)/sbin/
	ln -sf ../sbin/MAKEDEV $(RELEASE_DIR)/dev/MAKEDEV
	ln -sf ../../sbin/MAKEDEV $(RELEASE_DIR)/lib/udev/MAKEDEV
	cp -aR $(SKEL_ROOT)/etc/mdev/* $(RELEASE_DIR)/etc/mdev/
	cp -aR $(SKEL_ROOT)/etc/mdev.conf $(RELEASE_DIR)/etc/mdev.conf
	cp -aR $(SKEL_ROOT)/usr/share/udhcpc/* $(RELEASE_DIR)/usr/share/udhcpc/
	cp -aR $(SKEL_ROOT)/usr/share/zoneinfo/* $(RELEASE_DIR)/usr/share/zoneinfo/
	cp $(SKEL_ROOT)/bin/autologin $(RELEASE_DIR)/bin/
	cp $(SKEL_ROOT)/bin/vdstandby $(RELEASE_DIR)/bin/
	cp $(SKEL_ROOT)/usr/sbin/fw_printenv $(RELEASE_DIR)/usr/sbin/
	cp -aR $(TARGET_DIR)/etc/init.d/* $(RELEASE_DIR)/etc/init.d/
	cp -aR $(TARGET_DIR)/etc/* $(RELEASE_DIR)/etc/
	echo "$(BOXTYPE)" > $(RELEASE_DIR)/etc/hostname
	ln -sf ../../bin/busybox $(RELEASE_DIR)/usr/bin/ether-wake
	ln -sf ../../bin/showiframe $(RELEASE_DIR)/usr/bin/showiframe
	ln -sf ../../usr/sbin/fw_printenv $(RELEASE_DIR)/usr/sbin/fw_setenv
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), atevio7500 fortis_hdbox octagon1008 ufs910 ufs912 ufs913 ufs922 ufc960 spark ipbox55 ipbox99 ipbox9900 cuberevo cuberevo_mini cuberevo_mini2 cuberevo_250hd cuberevo_2000hd cuberevo_3000hd adb_box tf7700 vitamin_hd5000))
	cp $(SKEL_ROOT)/release/fw_env.config_$(BOXTYPE) $(RELEASE_DIR)/etc/fw_env.config
endif
	install -m 0755 $(SKEL_ROOT)/release/rcS_neutrino_$(BOXTYPE) $(RELEASE_DIR)/etc/init.d/rcS
#
#
#
ifeq ($(BOXARCH), sh4)
#
# player
#
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stm_v4l2.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stm_v4l2.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmfb.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmfb.ko $(RELEASE_DIR)/lib/modules/ || true
	cd $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra && \
	for mod in \
		sound/pseudocard/pseudocard.ko \
		sound/silencegen/silencegen.ko \
		stm/mmelog/mmelog.ko \
		stm/monitor/stm_monitor.ko \
		media/dvb/stm/dvb/stmdvb.ko \
		sound/ksound/ksound.ko \
		media/dvb/stm/mpeg2_hard_host_transformer/mpeg2hw.ko \
		media/dvb/stm/backend/player2.ko \
		media/dvb/stm/h264_preprocessor/sth264pp.ko \
		media/dvb/stm/allocator/stmalloc.ko \
		stm/platform/platform.ko \
		stm/platform/p2div64.ko \
		media/sysfs/stm/stmsysfs.ko \
	;do \
		if [ -e player2/linux/drivers/$$mod ]; then \
			cp player2/linux/drivers/$$mod $(RELEASE_DIR)/lib/modules/; \
			$(TARGET)-strip --strip-unneeded $(RELEASE_DIR)/lib/modules/`basename $$mod`; \
		else \
			touch $(RELEASE_DIR)/lib/modules/`basename $$mod`; \
		fi; \
	done
#
# modules
#
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/avs/avs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/avs/avs.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/bpamem/bpamem.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/bpamem/bpamem.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/boxtype/boxtype.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/boxtype/boxtype.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/compcache/ramzswap.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/compcache/ramzswap.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/e2_proc/e2_proc.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/e2_proc/e2_proc.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/net/ipv6/ipv6.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/net/ipv6/ipv6.ko $(RELEASE_DIR)/lib/modules/ || true
#
# multicom 324
#
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxshell/embxshell.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxshell/embxshell.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxmailbox/embxmailbox.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxmailbox/embxmailbox.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxshm/embxshm.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxshm/embxshm.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/mme/mme_host.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/mme/mme_host.ko $(RELEASE_DIR)/lib/modules/ || true
#
#
#
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/simu_button/simu_button.ko $(RELEASE_DIR)/lib/modules/
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), vip2_v1 spark spark7162))
	cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cic/*.ko $(RELEASE_DIR)/lib/modules/
endif
#
# Boxtype sh4
#
endif
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/button/button.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/button/button.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cec/cec.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cec/cec.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cpu_frequ/cpu_frequ.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cpu_frequ/cpu_frequ.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/led/led.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/led/led.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/pti/pti.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/pti/pti.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/pti_np/pti.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/pti_np/pti.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/smartcard/smartcard.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/smartcard/smartcard.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/autofs4/autofs4.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/autofs4/autofs4.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/net/tun.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/net/tun.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/ftdi_sio.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/ftdi_sio.ko $(RELEASE_DIR)/lib/modules/ftdi_sio.ko || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/pl2303.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/pl2303.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/usbserial.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/usbserial.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/fuse/fuse.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/fuse/fuse.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/ntfs/ntfs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/ntfs/ntfs.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/cifs/cifs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/cifs/cifs.ko $(RELEASE_DIR)/lib/modules/ || true
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), ufs910 ufs922))
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/jfs/jfs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/jfs/jfs.ko $(RELEASE_DIR)/lib/modules/ || true
endif
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfsd/nfsd.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfsd/nfsd.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/exportfs/exportfs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/exportfs/exportfs.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfs_common/nfs_acl.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfs_common/nfs_acl.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfs/nfs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfs/nfs.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/sata_switch/sata.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/sata_switch/sata.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/mini_fo/mini_fo.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/mini_fo/mini_fo.ko $(RELEASE_DIR)/lib/modules/ || true
#
# wlan
#
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/mt7601u/mt7601Usta.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/mt7601u/mt7601Usta.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rt2870sta/rt2870sta.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rt2870sta/rt2870sta.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rt3070sta/rt3070sta.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rt3070sta/rt3070sta.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rt5370sta/rt5370sta.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rt5370sta/rt5370sta.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl871x/8712u.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl871x/8712u.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8188eu/8188eu.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8188eu/8188eu.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8192cu/8192cu.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8192cu/8192cu.ko $(RELEASE_DIR)/lib/modules/ || true
	[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8192du/8192du.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8192du/8192du.ko $(RELEASE_DIR)/lib/modules/ || true
ifeq ($(IMAGE), $(filter $(IMAGE), enigma2-wlandriver neutrino-wlandriver))
	install -d $(RELEASE_DIR)/etc/Wireless
	cp -aR $(SKEL_ROOT)/firmware/Wireless/* $(RELEASE_DIR)/etc/Wireless/
	cp -aR $(SKEL_ROOT)/firmware/rtlwifi $(RELEASE_DIR)/lib/firmware/
	cp -aR $(SKEL_ROOT)/firmware/*.bin $(RELEASE_DIR)/lib/firmware/
endif
#
# lib usr/lib
#
	cp -R $(TARGET_DIR)/lib/* $(RELEASE_DIR)/lib/
	rm -f $(RELEASE_DIR)/lib/*.{a,o,la}
	chmod 755 $(RELEASE_DIR)/lib/*
	ln -s /var/tuxbox/plugins/libfx2.so $(RELEASE_DIR)/lib/libfx2.so
	cp -R $(TARGET_DIR)/usr/lib/* $(RELEASE_DIR)/usr/lib/
	rm -rf $(RELEASE_DIR)/usr/lib/{engines,enigma2,gconv,libxslt-plugins,pkgconfig,python$(PYTHON_VER),sigc++-2.0}
	rm -f $(RELEASE_DIR)/usr/lib/*.{a,o,la}
	chmod 755 $(RELEASE_DIR)/usr/lib/*
#
# fonts
#
	if [ -e $(TARGET_DIR)/usr/share/fonts/neutrino.ttf ]; then \
		cp -aR $(TARGET_DIR)/usr/share/fonts/neutrino.ttf $(RELEASE_DIR)/usr/share/fonts; \
	fi
	if [ -e $(TARGET_DIR)/usr/share/fonts/micron.ttf ]; then \
		cp -aR $(TARGET_DIR)/usr/share/fonts/micron.ttf $(RELEASE_DIR)/usr/share/fonts; \
	fi
	if [ -e $(TARGET_DIR)/usr/share/fonts/DejaVuLGCSansMono-Bold.ttf ]; then \
		cp -aR $(TARGET_DIR)/usr/share/fonts/DejaVuLGCSansMono-Bold.ttf $(RELEASE_DIR)/usr/share/fonts; \
		ln -s /usr/share/fonts/DejaVuLGCSansMono-Bold.ttf $(RELEASE_DIR)/usr/share/fonts/tuxtxt.ttf; \
	fi
#
# neutrino
#
	ln -sf /usr/share $(RELEASE_DIR)/usr/local/share
	cp $(TARGET_DIR)/usr/local/bin/neutrino $(RELEASE_DIR)/usr/local/bin/
	cp $(TARGET_DIR)/usr/local/bin/pzapit $(RELEASE_DIR)/usr/local/bin/
	cp $(TARGET_DIR)/usr/local/bin/sectionsdcontrol $(RELEASE_DIR)/usr/local/bin/
	if [ -e $(TARGET_DIR)/usr/local/bin/install.sh ]; then \
		cp -aR $(TARGET_DIR)/usr/local/bin/install.sh $(RELEASE_DIR)/bin/; \
	fi
	if [ -e $(TARGET_DIR)/usr/local/bin/luaclient ]; then \
		cp $(TARGET_DIR)/usr/local/bin/luaclient $(RELEASE_DIR)/bin/; \
	fi
	if [ -e $(TARGET_DIR)/usr/local/bin/rcsim ]; then \
		cp $(TARGET_DIR)/usr/local/bin/rcsim $(RELEASE_DIR)/bin/; \
	fi
	if [ -e $(TARGET_DIR)/usr/local/sbin/udpstreampes ]; then \
		cp $(TARGET_DIR)/usr/local/sbin/udpstreampes $(RELEASE_DIR)/usr/local/sbin/; \
	fi
	if [ -e $(TARGET_DIR)/usr/local/bin/udpstreampes ]; then \
		cp $(TARGET_DIR)/usr/local/bin/udpstreampes $(RELEASE_DIR)/usr/local/bin/; \
	fi
#
# channellist / tuxtxt
#
	cp -aR $(TARGET_DIR)/var/tuxbox/config/* $(RELEASE_DIR)/var/tuxbox/config
#
# copy root_neutrino
#
	cp -aR $(SKEL_ROOT)/root_neutrino/* $(RELEASE_DIR)/
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), atevio7500 spark7162 cuberevo_mini2 cuberevo_3000hd))
	rm -f $(RELEASE_DIR)/var/tuxbox/config/cables.xml
	rm -f $(RELEASE_DIR)/var/tuxbox/config/terrestrial.xml
endif
#
# iso-codes
#
	[ -e $(TARGET_DIR)/usr/local/share/iso-codes ] && cp -aR $(TARGET_DIR)/usr/local/share/iso-codes $(RELEASE_DIR)/usr/share/ || true
#
# httpd/icons/locale/themes
#
	cp -aR $(TARGET_DIR)/usr/share/tuxbox/neutrino/* $(RELEASE_DIR)/usr/share/tuxbox/neutrino
#
# backup/restore NMP
#
	[ -e $(TARGET_DIR)/usr/local/bin/backup.sh ] && cp -aR $(TARGET_DIR)/usr/local/bin/backup.sh $(RELEASE_DIR)/bin || true
	[ -e $(TARGET_DIR)/usr/local/bin/restore.sh ] && cp -aR $(TARGET_DIR)/usr/local/bin/restore.sh $(RELEASE_DIR)/bin || true
#
# alsa
#
	if [ -e $(TARGET_DIR)/usr/share/alsa ]; then \
		mkdir -p $(RELEASE_DIR)/usr/share/alsa/; \
		mkdir $(RELEASE_DIR)/usr/share/alsa/cards/; \
		mkdir $(RELEASE_DIR)/usr/share/alsa/pcm/; \
		cp -dp $(TARGET_DIR)/usr/share/alsa/alsa.conf $(RELEASE_DIR)/usr/share/alsa/alsa.conf; \
		cp $(TARGET_DIR)/usr/share/alsa/cards/aliases.conf $(RELEASE_DIR)/usr/share/alsa/cards/; \
		cp $(TARGET_DIR)/usr/share/alsa/pcm/default.conf $(RELEASE_DIR)/usr/share/alsa/pcm/; \
		cp $(TARGET_DIR)/usr/share/alsa/pcm/dmix.conf $(RELEASE_DIR)/usr/share/alsa/pcm/; \
	fi
#
# xupnpd
#
	if [ -e $(TARGET_DIR)/usr/bin/xupnpd ]; then \
		cp -aR $(TARGET_DIR)/usr/share/xupnpd $(RELEASE_DIR)/usr/share; \
		mkdir -p $(RELEASE_DIR)/usr/share/xupnpd/playlists; \
	fi
#
# mc
#
	if [ -e $(TARGET_DIR)/usr/bin/mc ]; then \
		cp -aR $(TARGET_DIR)/usr/share/mc $(RELEASE_DIR)/usr/share/; \
		cp -af $(TARGET_DIR)/usr/libexec $(RELEASE_DIR)/usr/; \
	fi
#
# lua
#
	if [ -d $(TARGET_DIR)/usr/share/lua ]; then \
		cp -aR $(TARGET_DIR)/usr/share/lua $(RELEASE_DIR)/usr/share; \
	fi
#
# plugins
#
	if [ -d $(TARGET_DIR)/var/tuxbox/plugins ]; then \
		cp -af $(TARGET_DIR)/var/tuxbox/plugins $(RELEASE_DIR)/var/tuxbox/; \
	fi
	if [ -d $(TARGET_DIR)/lib/tuxbox/plugins ]; then \
		cp -af $(TARGET_DIR)/lib/tuxbox/plugins $(RELEASE_DIR)/lib/tuxbox/; \
	fi
	if [ -e $(RELEASE_DIR)/var/tuxbox/plugins/tuxwetter.so ]; then \
		cp -rf $(TARGET_DIR)/var/tuxbox/config/tuxwetter $(RELEASE_DIR)/var/tuxbox/config; \
	fi
	if [ -e $(RELEASE_DIR)/var/tuxbox/plugins/sokoban.so ]; then \
		cp -rf $(TARGET_DIR)/usr/share/tuxbox/sokoban $(RELEASE_DIR)/var/tuxbox/plugins; \
		ln -s /var/tuxbox/plugins/sokoban $(RELEASE_DIR)/usr/share/tuxbox/sokoban; \
	fi
#
# shairport
#
	if [ -e $(TARGET_DIR)/usr/bin/shairport ]; then \
		cp -f $(TARGET_DIR)/usr/bin/shairport $(RELEASE_DIR)/usr/bin; \
		cp -f $(TARGET_DIR)/usr/bin/mDNSPublish $(RELEASE_DIR)/usr/bin; \
		cp -f $(TARGET_DIR)/usr/bin/mDNSResponder $(RELEASE_DIR)/usr/bin; \
		cp -f $(SKEL_ROOT)/etc/init.d/shairport $(RELEASE_DIR)/etc/init.d/shairport; \
		chmod 755 $(RELEASE_DIR)/etc/init.d/shairport; \
		cp -f $(TARGET_DIR)/usr/lib/libhowl.so* $(RELEASE_DIR)/usr/lib; \
		cp -f $(TARGET_DIR)/usr/lib/libmDNSResponder.so* $(RELEASE_DIR)/usr/lib; \
	fi
#
# Neutrino HD2 Workaround Build in Player
#
	if [ -e $(TARGET_DIR)/usr/local/bin/eplayer3 ]; then \
		cp -f $(TARGET_DIR)/usr/local/bin/eplayer3 $(RELEASE_DIR)/bin/; \
		cp -f $(TARGET_DIR)/usr/local/bin/meta $(RELEASE_DIR)/bin/; \
	fi
#
# delete unnecessary files
#
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), ufs910 ufs922))
	rm -f $(RELEASE_DIR)/sbin/jfs_fsck
	rm -f $(RELEASE_DIR)/sbin/fsck.jfs
	rm -f $(RELEASE_DIR)/sbin/jfs_mkfs
	rm -f $(RELEASE_DIR)/sbin/mkfs.jfs
	rm -f $(RELEASE_DIR)/sbin/jfs_tune
	rm -f $(RELEASE_DIR)/etc/ssl/certs/ca-certificates.crt
endif
	rm -f $(RELEASE_DIR)/usr/lib/lua/5.2/*.la
	rm -rf $(RELEASE_DIR)/lib/autofs
	rm -f $(RELEASE_DIR)/lib/libSegFault*
	rm -f $(RELEASE_DIR)/lib/libstdc++.*-gdb.py
	rm -f $(RELEASE_DIR)/lib/libthread_db*
	rm -f $(RELEASE_DIR)/lib/libanl*
	rm -rf $(RELEASE_DIR)/lib/modules/$(KERNEL_VER)
	rm -rf $(RELEASE_DIR)/usr/lib/alsa
	rm -rf $(RELEASE_DIR)/usr/lib/glib-2.0
	rm -rf $(RELEASE_DIR)/usr/lib/cmake
	rm -f $(RELEASE_DIR)/usr/lib/libc.so
	rm -f $(RELEASE_DIR)/usr/lib/libglcdskin.so*
	rm -f $(RELEASE_DIR)/usr/lib/xml2Conf.sh
	rm -f $(RELEASE_DIR)/usr/lib/libfontconfig*
	rm -f $(RELEASE_DIR)/usr/lib/libdvdcss*
	rm -f $(RELEASE_DIR)/usr/lib/libdvdnav*
	rm -f $(RELEASE_DIR)/usr/lib/libdvdread*
	rm -f $(RELEASE_DIR)/usr/lib/libcurses.so
	[ ! -e $(RELEASE_DIR)/usr/bin/mc ] && rm -f $(RELEASE_DIR)/usr/lib/libncurses* || true
	rm -f $(RELEASE_DIR)/usr/lib/libthread_db*
	rm -f $(RELEASE_DIR)/usr/lib/libanl*
	rm -f $(RELEASE_DIR)/usr/lib/libopkg*
	rm -f $(RELEASE_DIR)/bin/gitVCInfo
	rm -f $(RELEASE_DIR)/bin/evtest
	rm -f $(RELEASE_DIR)/bin/meta
	rm -f $(RELEASE_DIR)/bin/streamproxy
	rm -f $(RELEASE_DIR)/bin/libstb-hal-test
	rm -f $(RELEASE_DIR)/sbin/ldconfig
#
# The main target depends on the model.
# IMPORTANT: it is assumed that only one variable is set. Otherwise the target name won't be resolved.
#
$(D)/neutrino_release: \
$(D)/%neutrino_release: neutrino_release_base neutrino_release_$(BOXTYPE)
	$(TUXBOX_CUSTOMIZE)
	@touch $@
#
# FOR YOUR OWN CHANGES use these folder in cdk/own_build/neutrino-hd
#
#	default for all receiver
	find $(OWN_BUILD)/neutrino-hd/ -mindepth 1 -maxdepth 1 -exec cp -at$(RELEASE_DIR)/ -- {} +
#	receiver specific (only if directory exist)
	[ -d "$(OWN_BUILD)/neutrino-hd.$(BOXTYPE)" ] && find $(OWN_BUILD)/neutrino-hd.$(BOXTYPE)/ -mindepth 1 -maxdepth 1 -exec cp -at$(RELEASE_DIR)/ -- {} + || true
	echo $(BOXTYPE) > $(RELEASE_DIR)/etc/model
	rm -f $(RELEASE_DIR)/for_your_own_changes
#
# nicht die feine Art, aber funktioniert ;)
#
	cp -dpfr $(RELEASE_DIR)/etc $(RELEASE_DIR)/var
	rm -fr $(RELEASE_DIR)/etc
	ln -sf /var/etc $(RELEASE_DIR)
#
	ln -s /tmp $(RELEASE_DIR)/lib/init
	ln -s /tmp $(RELEASE_DIR)/var/lib/urandom
	ln -s /tmp $(RELEASE_DIR)/var/lock
	ln -s /tmp $(RELEASE_DIR)/var/log
	ln -s /tmp $(RELEASE_DIR)/var/run
	ln -s /tmp $(RELEASE_DIR)/var/tmp
#
	mv -f $(RELEASE_DIR)/usr/share/tuxbox/neutrino/icons/scan.jpg $(RELEASE_DIR)/var/boot/
	ln -s /var/boot/scan.jpg $(RELEASE_DIR)/usr/share/tuxbox/neutrino/icons/
	mv -f $(RELEASE_DIR)/usr/share/tuxbox/neutrino/icons/mp3.jpg $(RELEASE_DIR)/var/boot/
	ln -s /var/boot/mp3.jpg $(RELEASE_DIR)/usr/share/tuxbox/neutrino/icons/
	rm -f $(RELEASE_DIR)/usr/share/tuxbox/neutrino/icons/mp3-?.jpg
	mv -f $(RELEASE_DIR)/usr/share/tuxbox/neutrino/icons/shutdown.jpg $(RELEASE_DIR)/var/boot/
	ln -s /var/boot/shutdown.jpg $(RELEASE_DIR)/usr/share/tuxbox/neutrino/icons/
	mv -f $(RELEASE_DIR)/usr/share/tuxbox/neutrino/icons/radiomode.jpg $(RELEASE_DIR)/var/boot/
	ln -s /var/boot/radiomode.jpg $(RELEASE_DIR)/usr/share/tuxbox/neutrino/icons/
	mv -f $(RELEASE_DIR)/usr/share/tuxbox/neutrino/icons/start.jpg $(RELEASE_DIR)/var/boot/
	ln -s /var/boot/start.jpg $(RELEASE_DIR)/usr/share/tuxbox/neutrino/icons/
#
	rm -f $(RELEASE_DIR)/bin/pic2m2v
	rm -f $(RELEASE_DIR)/usr/lib/*.py
#
# sh4-linux-strip all
#
ifneq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), kerneldebug debug))
	find $(RELEASE_DIR)/ -name '*' -exec $(TARGET)-strip --strip-unneeded {} &>/dev/null \;
endif
	@echo "***************************************************************"
	@echo -e "\033[01;32m"
	@echo " Build of Neutrino for $(BOXTYPE) successfully completed."
	@echo -e "\033[00m"
	@echo "***************************************************************"
#
# release-clean
#
neutrino-release-clean:
	rm -f $(D)/neutrino_release
