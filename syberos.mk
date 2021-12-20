LOCAL_PATH := $(call my-dir)

ifneq ($(SYBEROS_CACHE),)
LOCAL_KERNEL_COMPILE := "$(CC_WRAPPER) $(KERNEL_CC)"
LOCAL_LINUX_COMPILE := "$(CC_WRAPPER) $(LINUX_CC)"
else
LOCAL_LINUX_COMPILE := $(LINUX_CC)
LOCAL_KERNEL_COMPILE := $(KERNEL_CC)
endif

include $(CLEAR_VARS)
LOCAL_MODULE := fibdre
LOCAL_DEPENDENCIES := kernel
KDIR := /home/syberos/lcc/hemiao/syberos_1124/out/target/alpha_s9863a1h10_sharkl3-debug/obj/kernel
PWD := $(shell pwd)
LOCAL_POST_BUILD_HOOK := make ARCH=$(if $(findstring 64,$(BUILD_TARGET_ARCH)),arm64,arm) CROSS_COMPILE=$(LOCAL_LINUX_COMPILE) -C $(KDIR) M=$(PWD) modules 
LOCAL_CLEAN_OPTS := distclean
include $(BUILD_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := client
LOCAL_DEPENDENCIES := glibc
LOCAL_DEPENDENCIES += kernel-headers
PWD := $(shell pwd)
LOCAL_POST_BUILD_HOOK := $(LINUX_CC)gcc -o clien.c 
LOCAL_CLEAN_OPTS := distclean
include $(BUILD_PACKAGE)
