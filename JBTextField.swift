//
//  JBTextField.swift
//  JBTextField
//
//  Created by Jeongbae Kong on 2020/12/20.
//

import UIKit

@IBDesignable
open class JBTextField: UITextField {
  
  enum ValidStatus {
    case normal
    case fail
    case success
  }
  
  
  // MARK: Properties
  @IBInspectable open var bottomBorderColor: UIColor = .black {
    didSet {
      updateUI()
    }
  }
  
  @IBInspectable open var errorMessage: String? {
    didSet {
      initializeErrorLabel()
    }
  }
  
  var isValid: Bool = false
  var validation: ((String) -> Bool)?
  var bottomBorder = CALayer()
  
  private let topSetupView = UIView()
  private let bottomSetupView = UIView()
  
  private let titleLabel = UILabel()
  private let errorLabel = UILabel()
  
  private var titleTextHeight: CGFloat = 0
  private var contextTextHeight: CGFloat = 0
  
  // MARK: Initialize
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initTextField()
  }
  
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    initTextField()
  }
  
  // MARK: Methods
  
  private func initTextField() {
    borderStyle = .none
    validationStatus = .normal
    addTarget(self, action: #selector(textChanged), for: .editingChanged)
  }
  
  @objc private func textChanged() {
    
    if let isValid = validation?(text ?? ""),
       isValid {
      self.isValid = isValid
      validationStatus = .success
    } else {
      self.isValid = !isValid
      validationStatus = .fail
    }
    
    if text == "" {
      validationStatus = .normal
    }
  }
  
  private func updateUI() {
    initializeBottomBorder()
    initializeTitleLabel()
    initializeErrorLabel()
  }
  
  private var validationStatus: ValidStatus = .normal {
    didSet {
      switch validationStatus {
      case .normal:
        bottomBorderColor = .black
        UIView.animate(withDuration: 0.3) {
          self.bottomSetupView.alpha = 0
        }
      case .fail:
        bottomBorderColor = .red
      
        UIView.animate(withDuration: 0.3) {
          self.bottomSetupView.alpha = 1
        }
      case .success:
        bottomBorderColor = .blue
      
        UIView.animate(withDuration: 0.3) {
          self.bottomSetupView.alpha = 0
        }
      }
    }
  }
  
  private func initializeBottomBorder() {
    self.borderStyle = .none
    bottomBorder.backgroundColor = bottomBorderColor.cgColor
    bottomBorder.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: 1)
    layer.addSublayer(bottomBorder)
  }
  
  private func initializeTitleLabel() {
    if !isValid {
      
      titleLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      titleLabel.font = UIFont.systemFont(ofSize: 13)
      titleLabel.alpha = 1.0
      titleLabel.numberOfLines = 0
      titleLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 10)
      titleLabel.text = "ABCABC"
      titleTextHeight = titleLabel.bounds.size.height
      addSubview(titleLabel)
      
    }
  }
  
  private func initializeErrorLabel() {
    if validationStatus == .fail {
      errorLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      
      //alpha가 0이면 투명, 1이면 불투명
      errorLabel.alpha = 1.0
      errorLabel.numberOfLines = 0
      
      errorLabel.frame = CGRect(x: 0, y: self.frame.height + 5, width: self.frame.width, height: 5)
      errorLabel.adjustsFontSizeToFitWidth = true
      errorLabel.sizeToFit()
      errorLabel.textColor = .red
      errorLabel.font = .systemFont(ofSize: 15)
      errorLabel.text = errorMessage
      bottomSetupView.addSubview(errorLabel)
      
      self.addSubview(bottomSetupView)
    }
  }
  
  open override func textRect(forBounds bounds: CGRect) -> CGRect {
    let superRect = super.textRect(forBounds: bounds)

    return CGRect(x: 0, y: 0, width: superRect.size.width, height: superRect.size.height + bottomSetupView.frame.height + titleTextHeight )
  }
  
  
  open override func editingRect(forBounds bounds: CGRect) -> CGRect {
    let superRect = super.editingRect(forBounds: bounds)


    return CGRect(x: 0, y: 0, width: superRect.size.width, height: superRect.size.height + bottomSetupView.frame.height + titleTextHeight )
  }
  
  
  open override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    updateUI()
  }
}

