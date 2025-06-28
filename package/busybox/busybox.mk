define BUSYBOX_INSTALL_MDEV_SCRIPT
	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_WEBCAMPI_PATH)/package/busybox/S10mdev \
		$(TARGET_DIR)/etc/init.d/S10mdev
endef
