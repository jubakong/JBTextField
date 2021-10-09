# JBTextField

[![CI Status](https://img.shields.io/travis/jubakong@gmail.com/JBTextField.svg?style=flat)](https://travis-ci.org/jubakong@gmail.com/JBTextField)
[![Version](https://img.shields.io/cocoapods/v/JBTextField.svg?style=flat)](https://cocoapods.org/pods/JBTextField)
[![License](https://img.shields.io/cocoapods/l/JBTextField.svg?style=flat)](https://cocoapods.org/pods/JBTextField)
[![Platform](https://img.shields.io/cocoapods/p/JBTextField.svg?style=flat)](https://cocoapods.org/pods/JBTextField)

💎  A textField which may resolve any inconvenience while using default iOS TextField

![ezgif com-gif-maker](https://user-images.githubusercontent.com/52398126/136664221-3631a670-5537-4523-9988-807390ec4f8d.gif)

## Tips and Tricks

- Use `isTitleOn` if want to show Title

    ```swift
    testTextField.isTitleOn = true
    ```

- Use `title` if want to declare title

   ```swift
    testTextField.title = "Title"
    }
    ```

- Use `validation` if want to check validation

    ```swift
    testTextField.validation = { $0.count == 4 }
    ```

- Use `errorMessage` if want to check validation

    ```swift
    testTextField.errorMessage = "Error!"
    ```
    
- Use `validation` if want to check validation

    ```swift
    testTextField.validation = { $0.count == 4 }
    ```
    
- Use `errorMessageAlignment` if want to switch alignment of error message

    ```swift
    testTextField.errorMessageAlignment = .left
    ```
    
- Use `rightImage` if want to set up image at `rightView`

    ```swift
    testTextField.rightImage = UIImage(named: "flagOfKorea")
    ```


## Installation
JBTextField is available through [CocoaPods](https://cocoapods.org). 
To install it, simply add the following line to your Podfile:

```ruby
pod 'JBTextField'
```

## How to Setup
```
1. Simply install the pod
2. Set subclass of textfield as 'JBTextField'
```

## Author

Jeongbae Kong, jubakong@gmail.com

## License

JBTextField is available under the MIT license. See the LICENSE file for more info.
