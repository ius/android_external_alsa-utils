
ifeq ($(strip $(BOARD_USES_ALSA_AUDIO)),true)
ifeq ($(strip $(BUILD_WITH_ALSA_UTILS)),true)

LOCAL_PATH:= $(call my-dir)

#
# Build aplay command
#

include $(CLEAR_VARS)

LOCAL_CFLAGS := \
	-fPIC -D_POSIX_SOURCE \
	-DALSA_CONFIG_DIR=\"/system/usr/share/alsa\" \
	-DALSA_PLUGIN_DIR=\"/system/usr/lib/alsa-lib\" \
	-DALSA_DEVICE_DIRECTORY=\"/dev/snd/\"

LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/android \
	external/alsa-lib/include

LOCAL_SRC_FILES := \
	aplay/aplay.c

LOCAL_MODULE_TAGS := debug
LOCAL_MODULE := alsa_aplay

LOCAL_SHARED_LIBRARIES := \
	libaudio \
	libasound \
	libc

include $(BUILD_EXECUTABLE)

#
# Build alsactl command
#

include $(CLEAR_VARS)

LOCAL_CFLAGS := \
	-fPIC -D_POSIX_SOURCE \
	-DALSA_CONFIG_DIR=\"/system/usr/share/alsa\" \
	-DALSA_PLUGIN_DIR=\"/system/usr/lib/alsa-lib\" \
	-DALSA_DEVICE_DIRECTORY=\"/dev/snd/\"

LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/android \
	external/alsa-lib/include

LOCAL_SRC_FILES := \
	alsactl/alsactl.c \
	alsactl/init_parse.c \
	alsactl/state.c \
	alsactl/utils.c

LOCAL_MODULE_TAGS := debug
LOCAL_MODULE := alsa_ctl

LOCAL_SHARED_LIBRARIES := \
	libaudio \
	libasound \
	libc

include $(BUILD_EXECUTABLE)

#
# Build amixer command
#

include $(CLEAR_VARS)

LOCAL_CFLAGS := \
	-fPIC -D_POSIX_SOURCE \
	-DALSA_CONFIG_DIR=\"/system/usr/share/alsa\" \
	-DALSA_PLUGIN_DIR=\"/system/usr/lib/alsa-lib\" \
	-DALSA_DEVICE_DIRECTORY=\"/dev/snd/\"

LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/android \
	external/alsa-lib/include

LOCAL_SRC_FILES := \
	amixer/amixer.c

LOCAL_MODULE_TAGS := debug
LOCAL_MODULE := alsa_amixer

LOCAL_SHARED_LIBRARIES := \
	libaudio \
	libasound \
	libc

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

ALSAINIT_DIR := $(TARGET_OUT)/usr/share/alsa/init

files := $(addprefix $(ALSAINIT_DIR)/,00main default hda help info test)

$(files): PRIVATE_MODULE := alsactl_initdir
$(files): $(ALSAINIT_DIR)/%: $(LOCAL_PATH)/alsactl/init/% | $(ACP)
	$(transform-prebuilt-to-target)

ALL_PREBUILT += $(files)

endif
endif
