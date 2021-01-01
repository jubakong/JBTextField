# JBTextField

[![CI Status](https://img.shields.io/travis/jubakong@gmail.com/JBTextField.svg?style=flat)](https://travis-ci.org/jubakong@gmail.com/JBTextField)
[![Version](https://img.shields.io/cocoapods/v/JBTextField.svg?style=flat)](https://cocoapods.org/pods/JBTextField)
[![License](https://img.shields.io/cocoapods/l/JBTextField.svg?style=flat)](https://cocoapods.org/pods/JBTextField)
[![Platform](https://img.shields.io/cocoapods/p/JBTextField.svg?style=flat)](https://cocoapods.org/pods/JBTextField)

TextField which may resolve any inconvenience while using provided iOS TextField

![ezgif com-gif-maker](https://user-images.githubusercontent.com/52398126/103441172-6e548800-4c8f-11eb-81b8-67ba89b33150.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS 9.0 or higher

## Installation

JBTextField is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JBTextField'
```

## How to Setup
```
1. Simply install the pod
2. Set your subclass as 'JBTextField'
```

## How to Use
- Set Title Text with `titleLabelText`
```swift
testTextField.titleLabelText = "TitleText"
```

- Set Error Message with `errorMessage`
```
testTextField.errorMessage = "Error!"
```

- Set restriction for showing errormessage with `validation`
```
testTextField.validation = { $0.count == 4 }
```

## Author

Jeongbae Kong, jubakong@gmail.com

## License

JBTextField is available under the MIT license. See the LICENSE file for more info.
