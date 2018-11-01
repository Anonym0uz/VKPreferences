export ARCHS = armv7 arm64
TARGET_IPHONEOS_DEPLOYMENT_VERSION=7.0
include theos/makefiles/common.mk

BUNDLE_NAME = VKPreferencesBundle
VKPreferencesBundle_FILES = VKPreferencesBundle.mm \
VKPrefsPasscode.mm \
VKMenu.mm \
VKAccounts.mm \
UIAlertView+Blocks.m \
ColorSwitch.m \
../FBEncrypt/FBEncryptorAES.m \
../FBEncrypt/NSData+Base64.m \
UITableView+LongPressReorder/UITableView+LongPressReorder.m \
$(shell find Passcode -name '*.m') 
VKPreferencesBundle_INSTALL_PATH = /Library/PreferenceBundles
VKPreferencesBundle_FRAMEWORKS = UIKit CoreGraphics QuartzCore Foundation Security LocalAuthentication
VKPreferencesBundle_PRIVATE_FRAMEWORKS = Preferences Security Foundation 
ADDITIONAL_OBJCFLAGS = -Wno-error
//VKPreferencesBundle_CFLAGS = -fno-objc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/VKPreferencesBundle.plist$(ECHO_END)
