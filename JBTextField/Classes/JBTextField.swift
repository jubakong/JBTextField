//
//  JBTextField.swift
//  JBTextField
//
//  Created by Jeongbae Kong on 2020/12/20.
//

import UIKit

@IBDesignable open class JBTextField: UITextField {
  @objc public enum JBTextFieldType: Int {
    case dropdown
    case `default`
  }
  
  // MARK: Right Image View
  
  private var rightViewPadding: CGFloat = 0
  private var widthOfImageInRightView: CGFloat = 35
  private var rightFlagImageWidth: CGFloat = 0
  
  // MARK: Heights
  
  private var lineHeight: CGFloat = 0
  private var selectedLineHeight: CGFloat = 0
  private var edgeInsetPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  
  // MARK: IBInspectable
  
  @IBInspectable open var isTitleOn: Bool = true {
    didSet {
      update()
    }
  }
  
  @IBInspectable open var isLineHidden: Bool = false {
    didSet {
      update()
    }
  }
  
  @IBInspectable open var titleText: String = "TITLE" {
    didSet {
      update()
    }
  }
  
  @IBInspectable open var titleFont: UIFont = .appleSDGothicNeo(.medium, size: 12) {
    didSet {
      update()
      createTitleLabel()
    }
  }
  
  @IBInspectable open var titleColor: UIColor = .black {
    didSet {
      update()
    }
  }
  
  @IBInspectable open var lineViewColor: UIColor = .gray {
    didSet {
      update()
    }
  }
  
  @IBInspectable open var errorColor: UIColor = .red {
    didSet {
      update()
    }
  }
  
  @IBInspectable open var errorFont: UIFont = .appleSDGothicNeo(.regular, size: 12) {
    didSet {
      update()
      createTitleLabel()
    }
  }
  
  @IBInspectable open var errorMessage: String? {
    didSet {
      update()
    }
  }
  
  @IBInspectable open var disabledColor = UIColor(white: 0.88, alpha: 1.0) {
    didSet {
      update()
      updatePlaceholder()
    }
  }
  
  @IBInspectable override open var placeholder: String? {
    didSet {
      setNeedsDisplay()
      update()
    }
  }
  
  @IBInspectable open var placeholderColor = UIColor(red: 0.49, green: 0.49, blue: 0.49, alpha: 1.0) {
    didSet {
      updatePlaceholder()
    }
  }
  
  @IBInspectable open var rightImage: UIImage?
  @IBInspectable open var errorMessageAlignment: NSTextAlignment = .right
  
  // MARK: Properties
  
  open var validation: ((String) -> Bool)? {
    didSet {
      editingChanged()
    }
  }
  
  open var isValid = false
  //  open var valid = BehaviorSubject<Bool>(value: false)
  
  private lazy var rightImageView = UIImageView()
  
  private lazy var rightButton = UIButton()
  
  private var rightContainerView: UIView?
  
  private lazy var titleLabel = UILabel()
  
  private lazy var errorLabel = UILabel()
  
  private lazy var lineView = UIView()
  
  private var titleFadeInDuration: TimeInterval = 0.3
  
  private var titleFadeOutDuration: TimeInterval = 0.5
  
  private var placeholderFont: UIFont? {
    didSet {
      updatePlaceholder()
    }
  }
  
  private var isTitleVisible: Bool {
    return hasText
  }
  
  private var editingOrSelected: Bool {
    return super.isEditing || isSelected
  }
  
  // MARK: DropDown
  
  private var type: JBTextFieldType = .default {
    didSet {
      switch type {
      case .default:
        inputView = nil
        tintColor = .black
      case .dropdown:
        inputView = UIView()
        tintColor = .clear
        
        let dropdownImage = UIImageView()
        rightView = dropdownImage
        rightViewMode = .always
      }
    }
  }
  
  // MARK: Initialize
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initValidationTextField()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initValidationTextField()
  }
  
  private func initValidationTextField() {
    borderStyle = .none
    createTitleLabel()
    createLineView()
    createErrorLabel()
    addTarget(self, action: #selector(editingChanged), for: [.editingChanged, .valueChanged])
  }
  
  @objc private func editingChanged() {
    if let isValid = validation?(text ?? ""), !isValid {
      self.isValid = isValid
    } else {
      isValid = true
    }
    update()
    updateTitleVisibility(true)
  }
  
  private func createTitleLabel() {
    titleLabel = UILabel()
    
    titleLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    titleLabel.font = titleFont
    titleLabel.textColor = titleColor
    
    addSubview(titleLabel)
  }
  
  private func createLineView() {
    lineView.isUserInteractionEnabled = false
    lineView.backgroundColor = .gray
    configureDefaultLineHeight()
    
    lineView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
    addSubview(lineView)
  }
  
  private func createErrorLabel() {
    errorLabel.minimumScaleFactor = 0.5
    errorLabel.adjustsFontSizeToFitWidth = true
    
    errorLabel.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
    addSubview(errorLabel)
  }
  
  private func titleHeight() -> CGFloat {
    return titleLabel.font.lineHeight
  }
  
  func setrightImage(width: CGFloat, height: CGFloat, rightImage: UIImage?) {
    rightImageView = UIImageView(frame:
                                  CGRect(x: 0, y: 0, width: width, height: height)
    )
    
    let view = UIView()
    view.addSubview(rightImageView)
    
    rightImageView.image = rightImage
    rightImageView.translatesAutoresizingMaskIntoConstraints = false
    rightImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    rightImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    rightImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
    rightImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
    
    rightImageView.contentMode = .scaleAspectFit
    
    rightContainerView = view
    
    rightView = rightContainerView
    rightViewMode = .always
    
    rightFlagImageWidth = width
  }
  
  func setRightButton(isEnable: Bool, font _: UIFont? = .appleSDGothicNeo(.bold, size: 14), title: String, color: UIColor) {
    //    rightButton = UIButton()
    let testRightButton = UIButton()
    testRightButton.translatesAutoresizingMaskIntoConstraints = false
    testRightButton.isEnabled = isEnable
    testRightButton.setTitle(title, for: .normal)
    testRightButton.setTitleColor(color, for: .normal)
    testRightButton.sizeToFit()
    rightView = testRightButton
    rightViewMode = .always
  }
  
  private func errorHeight() -> CGFloat {
    return errorLabel.font.lineHeight + 10
  }
  
  private func configureDefaultLineHeight() {
    let pixel: CGFloat = 1.0 / UIScreen.main.scale
    lineHeight = 2.0 * pixel
    selectedLineHeight = 2.0 * lineHeight
  }
  
  private func titleRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
    if isTitleOn {
      return CGRect(
        x: 0,
        y: 0,
        width: bounds.size.width,
        height: titleHeight()
      )
    } else {
      if editing {
        return CGRect(
          x: 0,
          y: 0,
          width: bounds.size.width,
          height: titleHeight()
        )
      } else {
        return CGRect(
          x: 0,
          y: titleHeight(),
          width: bounds.size.width,
          height: titleHeight()
        )
      }
    }
  }
  
  private func lineViewRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
    let height = editing ? selectedLineHeight : lineHeight
    
    return CGRect(
      x: 0,
      y: bounds.size.height - height,
      width: bounds.size.width,
      height: height
    )
  }
  
  private func errorLabelRectForBounds(_ bounds: CGRect) -> CGRect {
    if isValid {
      return CGRect(
        x: 0,
        y: bounds.height + errorHeight(),
        width: 0,
        height: 0
      )
    } else {
      return CGRect(
        x: 0,
        y: bounds.height,
        width: bounds.size.width,
        height: errorHeight()
      )
    }
  }
  
  private func textHeight() -> CGFloat {
    guard let font = self.font else { return 0.0 }
    
    return font.lineHeight + 3.0
  }
  
  private func updateTitleVisibility(_ animated: Bool = false) {
    let alpha: CGFloat
    alpha = isTitleVisible ? 1.0 : 0.0
    let frame = titleRectForBounds(bounds, editing: isTitleVisible)
    
    let errorAlpha: CGFloat = isValid || text == "" ? 0.0 : 1.0
    let errorLabelFrame = errorLabelRectForBounds(bounds)
    
    let updateBlock = { () -> Void in
      self.titleLabel.alpha = alpha
      self.titleLabel.frame = frame
      
      self.errorLabel.alpha = errorAlpha
      self.errorLabel.frame = errorLabelFrame
    }
    
    if animated {
#if swift(>=4.2)
      let animationOptions: UIView.AnimationOptions = .curveEaseOut
#else
      let animationOptions: UIViewAnimationOptions = .curveEaseOut
#endif
      
      let duration = isTitleVisible ? titleFadeInDuration : titleFadeOutDuration
      
      UIView.animate(
        withDuration: duration,
        delay: 0,
        options: animationOptions,
        animations: { () -> Void in
          updateBlock()
        },
        completion: nil
      )
    }
  }
  
  private func update() {
    lineView.isHidden = isLineHidden
    
    if !isValid, text != "" {
      errorLabel.text = errorMessage
      errorLabel.textAlignment = errorMessageAlignment
      errorLabel.textColor = errorColor
      errorLabel.font = errorFont
      lineView.backgroundColor = errorColor
    } else {
      lineView.backgroundColor = lineViewColor
    }
    
    if isTitleOn {
      titleLabel.isHidden = false
      titleLabel.alpha = 1.0
    } else {
      titleLabel.isHidden = true
      titleLabel.alpha = 0.0
    }
    
    titleLabel.text = titleText
    titleLabel.textColor = titleColor
    titleLabel.font = titleFont
    
    updateTitleVisibility(true)
    
    if !isEnabled {
      lineView.backgroundColor = disabledColor
    }
  }
  
  private func updatePlaceholder() {
    guard let placeholder = placeholder, let font = placeholderFont ?? font else {
      return
    }
    let color = isEnabled ? placeholderColor : disabledColor
#if swift(>=4.2)
    attributedPlaceholder = NSAttributedString(
      string: placeholder,
      attributes: [
        NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font,
      ]
    )
#elseif swift(>=4.0)
    attributedPlaceholder = NSAttributedString(
      string: placeholder,
      attributes: [
        NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font,
      ]
    )
#else
    attributedPlaceholder = NSAttributedString(
      string: placeholder,
      attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: font]
    )
#endif
  }
  
  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    let superRect = super.textRect(forBounds: bounds)
    let titleHeight = self.titleHeight()
    
    let padding: CGFloat = 0
    return CGRect(
      x: superRect.origin.x + padding,
      y: titleHeight,
      width: superRect.size.width - padding,
      height: superRect.size.height - titleHeight - selectedLineHeight
    )
  }
  
  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    let superRect = super.editingRect(forBounds: bounds)
    let titleHeight = self.titleHeight()
    
    let padding: CGFloat = 0
    return CGRect(
      x: superRect.origin.x + padding,
      y: titleHeight,
      width: superRect.size.width,
      height: superRect.size.height - titleHeight - selectedLineHeight
    )
  }
  
  override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    let superRect = super.editingRect(forBounds: bounds)
    let titleHeight = self.titleHeight()
    
    let padding: CGFloat = 0
    let rect = CGRect(
      x: superRect.origin.x + padding,
      y: titleHeight,
      width: bounds.size.width - rightFlagImageWidth - padding,
      height: bounds.size.height - titleHeight - selectedLineHeight
    )
    return rect
  }
  
  override open func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    let titleHeight = self.titleHeight()
    
    let rect = CGRect(
      x: 0,
      y: titleHeight,
      width: rightFlagImageWidth,
      height: bounds.size.height - titleHeight - selectedLineHeight
    )
    return rect
  }
  
  override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
    let titleHeight = self.titleHeight()
    let size = bounds.size.height - titleHeight - selectedLineHeight
    let halfSize = ((bounds.size.height - titleHeight - selectedLineHeight) * 2) / 3
    
    return CGRect(
      x: bounds.width - halfSize,
      y: titleHeight,
      width: size,
      height: size
    )
  }
  
  override open func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    
    borderStyle = .none
    
    isSelected = true
    invalidateIntrinsicContentSize()
  }
  
  override open func layoutSubviews() {
    super.layoutSubviews()
    
    titleLabel.frame = titleRectForBounds(
      bounds,
      editing: isTitleVisible
    )
    
    lineView.frame = lineViewRectForBounds(
      bounds,
      editing: editingOrSelected
    )
    
    errorLabel.frame = errorLabelRectForBounds(bounds)
  }
  
  override open var intrinsicContentSize: CGSize {
    return CGSize(width: bounds.size.width, height: titleHeight() + textHeight() + 10)
  }
}

extension UIFont {
  
  enum FontType {
    case regular
    case medium
    case bold
    case light
    case semiBold
  }
  
  class func appleSDGothicNeo(_ type: FontType, size: CGFloat) -> UIFont {
    switch type {
    case .regular:
      return UIFont(name: "AppleSDGothicNeo-Regular", size: size) ?? .systemFont(ofSize: size)
    case .medium:
      return UIFont(name: "AppleSDGothicNeo-medum", size: size) ?? .systemFont(ofSize: size)
    case .bold:
      return UIFont(name: "AppleSDGothicNeo-Bold", size: size) ?? .systemFont(ofSize: size)
    case .light:
      return UIFont(name: "AppleSDGothicNeo-Light", size: size) ?? .systemFont(ofSize: size)
    case .semiBold:
      return UIFont(name: "AppleSDGothicNeo-SemiBold", size: size) ?? .systemFont(ofSize: size)
    }
  }
}
