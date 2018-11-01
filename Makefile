ARCHS = armv7 arm64
TARGET_IPHONEOS_DEPLOYMENT_VERSION=7.0
//export THEOS_DEVICE_IP=192.168.0.103
export THEOS_DEVICE_IP=192.168.0.105
include theos/makefiles/common.mk
GO_EASY_ON_ME = 1
export SDKVERSION=10.2

TWEAK_NAME = VKPreferences
VKPreferences_FILES = Tweak.xm \
VKPreferences.m \
UIAlertView+Sheet/UIAlertView+Blocks.m \
VersionComparator/VersionComparator.m \
UITableView+LongPressReorder/UITableView+LongPressReorder.m \
TDBadge/TDBadgedCell.m \
FBEncrypt/FBEncryptorAES.m \
FBEncrypt/NSData+Base64.m \
$(shell find Passcode -name '*.m') \
VKPrefsPasscode.mm \
vkpreferencesbundle/VKPreferencesBundle.mm \
vkpreferencesbundle/VKAccounts.mm \
vkpreferencesbundle/VKMenu.mm \
vkpreferencesbundle/ColorSwitch.m \
UAObfuscatedString/UAObfuscatedString.m
VKPreferences_FRAMEWORKS = UIKit CoreGraphics QuartzCore Foundation Security LocalAuthentication
VKPreferences_PRIVATE_FRAMEWORKS = Preferences Foundation Security
ADDITIONAL_OBJCFLAGS = -Wno-error
VKPreferences_LDFLAGS + = -Wl -segalign 4000

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 VkHdAppstore"
SUBPROJECTS += vkpreferencesbundle
include $(THEOS_MAKE_PATH)/aggregate.mk
