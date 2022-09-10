#
# Copyright 2018 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Display
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080


PRODUCT_SHIPPING_API_LEVEL := 29

# Dynamic Partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl:64 \
    gatekeeper.mt6853:64 \
    libSoftGatekeeper:64 \
    libMcClient:64 \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery

# Prebuilts
EXCLUDE_ELF_FILES := \
    recovery/root/vendor/lib64/hw/gatekeeper.mt6853.so \
    recovery/root/vendor/lib64/libMcClient.so \
    recovery/root/vendor/lib64/hw/android.hardware.gatekeeper@1.0-impl.so \
    recovery/root/vendor/lib64/hw/libSoftGatekeeper.so

ALL_RECOVERY_FILES := $(call find-copy-subdir-files, *, $(LOCAL_PATH)/recovery/root, recovery/root)

FILTERED_RECOVERY_FILES := $(foreach f,$(ALL_RECOVERY_FILES),\
    $(if $(filter $(lastword $(subst :, ,$(f))),$(EXCLUDE_ELF_FILES)),,$(f)))

PRODUCT_COPY_FILES += $(FILTERED_RECOVERY_FILES) \
    $(LOCAL_PATH)/prebuilt/dtb:dtb.img

# Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.treble.enabled=true
