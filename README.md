# Slopotic

## Develop

Before contributing, make sure you have [XcodeGen](https://github.com/yonaskolb/XcodeGen) and [CocoaPods](https://cocoapods.org/) installed.

After each pulling or file changes, run following command to generate new `.xcodeproj` and `.xcworkspace` files.

```bash
# Generate .xcodeproj from project.yml config.
$ xcodegen

# Install CocoaPods dependencies and generate .xcworkspace file.
$ pod install
```
