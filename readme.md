# EarlGrey 2 Binary example

Example app demonstrating how to use EarlGrey 2 binaries.

Clone the repo:
- git clone --recursive https://github.com/bootstraponline/earlgrey-2-binary-example.git

If you didn't use the recursive flag, update the submodule:
- git submodule update --recursive --init

# Commands

```bash
git submodule add -b earlgrey2 https://github.com/google/EarlGrey.git
git submodule add https://github.com/google/eDistantObject.git
```

Follow instructions in the [setup guide](https://github.com/google/EarlGrey/blob/earlgrey2/docs/setup.md) on a sample app. Run iOS test on real device. Copy these files out of the Products directory and into `ios-frameworks`.

- libUILib.a
- AppFramework.framework
- libChannelLib.a
- libCommonLib.a
- libeDistantObject.a
- libTestLib.a

Follow setup guide again. This time reference the prebuilt binaries.

- In the Application target, `Link Binary With Libraries`, link to `AppFramework.framework`
- In the Build Phases of your test target, drag and drop the prebuilt libTestLib.a into the "Link Binary With Libraries" section.
- In Build Settings add -ObjC to Other Linker Flags
- Point `User Header Search Paths` at:
  - `../EarlGrey` enable Recursive
  - `../eDistantObject` enable Recursive

- In Build Phases, new Copy Files Phase.

```
Destination: Absolute Path
Path: $(TARGET_BUILD_DIR)/../../<YOUR_APPLICATION_TARGET_NAME.app>/Frameworks
```
Uncheck Copy only when installing
Drag and drop the pre-built AppFramework.framework.
Select Code Sign On Copy

- Create `bridge.h` in the UI testing target.

```
#import "AppFramework/Action/GREYAction.h"
#import "AppFramework/Action/GREYActionBlock.h"
#import "AppFramework/Action/GREYActions.h"
#import "AppFramework/Matcher/GREYElementMatcherBlock.h"
#import "CommonLib/DistantObject/GREYHostApplicationDistantObject.h"
#import "CommonLib/Matcher/GREYMatcher.h"
#import "TestLib/AlertHandling/XCTestCase+GREYSystemAlertHandler.h"
#import "TestLib/EarlGreyImpl/EarlGrey.h"
```

Update `Objective-C Bridging Header` with `$(TARGET_NAME)/bridge.h`

Add [EarlGrey.swift](https://github.com/google/EarlGrey/blob/earlgrey2/TestLib/Swift/EarlGrey.swift) to the UI testing target.

- Update `Library Search Paths` to include `$(SRCROOT)/../ios-frameworks` recursive

- Update `Framework Search Paths` to include `$(SRCROOT)/../ios-frameworks` recursive

Use this Swift test.

```swift
  func testExample() {
    let application: XCUIApplication = XCUIApplication()
    application.launch()
    EarlGrey.selectElement(with: grey_keyWindow())
      .perform(grey_tap())
  }
```

Note that in real world usage, the `ios-frameworks` folder is also a submodule that uses Git LFS to avoid committing binary blobs to git.
