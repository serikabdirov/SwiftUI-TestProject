import UIKit
import SafariServices
@_exported import UIKit
@_exported import Core
@_exported import R
@_exported import SnapKit
@_exported import CarbonKit

public enum DesignSystem {
    public enum Buttons {}
    public enum Views {}
    public enum ViewControllers {}
    public enum TextFields {}
    public enum Controls {}
    public enum ProgressBar {}
}

public extension DesignSystem.Buttons {
    enum M {}
    enum L {}
    enum S {}
}

public typealias DS = DesignSystem

// MARK: - Buttons

public extension DesignSystem.Buttons {
    static func primaryButton(title: String) -> BaseButton {
        let input = BaseButton()
        input.do { i in
            i.text = title
            i.height = 56
            i.cornerRadius = 10
            i.backgroundColors[.normal] = .systemBlue
            i.backgroundColors[.highlighted] = .systemBlue.withAlphaComponent(0.75)
            i.backgroundColors[.disabled] = .systemBlue.withAlphaComponent(0.5)
            i.textColors[.normal] = .white
            i.textColors[.disabled] = .white
            i.font = .systemFont(ofSize: 16)
            i.contentInsets = UIEdgeInsets(top: 4, left: 32, bottom: 4, right: 32)
        }
        return input
    }
    
    static func getNewCodeButton(title: String) -> BaseButton {
        let input = BaseButton()
        input.do { i in
            i.text = title
            i.height = 39
            i.backgroundColors[.normal] = .clear
            i.textColors[.normal] = UIColor.Button.textGreen
            i.font = .btn1SemiBold
        }
        
        return input
    }
}

// MARK: - Buttons.M

public extension DesignSystem.Buttons.M {
    
    static func primaryButton(title: String) -> BaseButton {
        let input = BaseButton()
        input.do { i in
            i.text = title
            i.height = 48
            i.cornerRadius = DesignSystem.Corner.M
            i.backgroundColors[.normal] = .Button.btnPrimary
            i.backgroundColors[.highlighted] = .Button.btnPrimaryTap
            i.backgroundColors[.disabled] = .Button.btnDisabled
            i.textColors[.normal] = .Button.textWhite
            i.textColors[.disabled] = .Button.textWhite
            i.textColors[.highlighted] = .Button.textWhite
            i.font = .btn1SemiBold
            i.contentInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        return input
    }
    
    static func secondaryButton(title: String) -> BaseButton {
        let input = BaseButton()
        input.do { i in
            i.text = title
            i.height = 48
            i.cornerRadius = DesignSystem.Corner.M
            i.backgroundColors[.normal] = .Button.btnSecondary
            i.backgroundColors[.highlighted] = .Button.btnSecondaryTap
            i.backgroundColors[.disabled] = .Button.btnDisabled
            i.textColors[.normal] = .Button.textWhite
            i.textColors[.highlighted] = .Button.textWhite
            i.textColors[.disabled] = .Button.textWhite
            i.font = .btn1SemiBold
            i.contentInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        return input
    }
}

// MARK: - Buttons.L

public extension DesignSystem.Buttons.L {
    
    static func primaryButton(title: String) -> BaseButton {
        let input = BaseButton()
        input.do { i in
            i.text = title
            i.height = 56
            i.cornerRadius = DesignSystem.Corner.M
            i.backgroundColors[.normal] = .Button.btnPrimary
            i.backgroundColors[.highlighted] = .Button.btnPrimaryTap
            i.backgroundColors[.disabled] = .Button.btnDisabled
            i.textColors[.normal] = .Button.textWhite
            i.textColors[.disabled] = .Button.textWhite
            i.textColors[.highlighted] = .Button.textWhite
            i.font = .btn1SemiBold
            i.contentInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        return input
    }
    
    static func secondaryButton(title: String) -> BaseButton {
        let input = BaseButton()
        input.do { i in
            i.text = title
            i.height = 56
            i.cornerRadius = DesignSystem.Corner.M
            i.backgroundColors[.normal] = .Button.btnSecondary
            i.backgroundColors[.highlighted] = .Button.btnSecondaryTap
            i.backgroundColors[.disabled] = .Button.btnDisabled
            i.textColors[.normal] = .Button.textWhite
            i.textColors[.highlighted] = .Button.textWhite
            i.textColors[.disabled] = .Button.textWhite
            i.font = .btn1SemiBold
            i.contentInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        return input
    }
}

public extension DesignSystem.Buttons.S {
        
    static func secondaryButton(title: String) -> BaseButton {
        let input = BaseButton()
        input.do { i in
            i.text = title
            i.height = 40
            i.cornerRadius = DesignSystem.Corner.M
            i.backgroundColors[.normal] = .Button.btnSecondary
            i.backgroundColors[.highlighted] = .Button.btnSecondaryTap
            i.backgroundColors[.disabled] = .Button.btnDisabled
            i.textColors[.normal] = .Button.textWhite
            i.textColors[.highlighted] = .Button.textWhite
            i.textColors[.disabled] = .Button.textWhite
            i.font = .btn3SemiBold
            i.contentInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        return input
    }
}

// MARK: - Views & Rows

public extension DesignSystem.Views {
    /// Main UIRefreshControl
    static func refreshControl() -> UIRefreshControl {
        let input = UIRefreshControl()
        input.do { i in
            i.layer.zPosition = -1
            i.tintColor = .blue
        }
        return input
    }
    
    /// Main UIActivityIndicatorView
    static func activityIndicator(style: UIActivityIndicatorView.Style = .medium) -> UIActivityIndicatorView {
        let input = UIActivityIndicatorView(style: style)
        input.do { i in
            i.color = .blue
        }
        return input
    }
}

// MARK: - ViewControllers

public extension DesignSystem.ViewControllers {
    /// Main system WebViewController
    static func webViewController(url: URL) -> UIViewController {
        let input = SFSafariViewController(url: url)
        input.do { i in
            i.dismissButtonStyle = .close
            i.preferredControlTintColor = .Green._70
        }
        return input
    }
}

// MARK: - TextFields

public extension DesignSystem.TextFields {
    
    static func borderTextField(
        placeholder: String? = nil,
        leftViewImage: UIImage? = nil,
        leftViewAction: (() -> Void)? = nil,
        rightViewImage: UIImage? = nil,
        rightViewAction: (() -> Void)? = nil
    ) -> BorderTextField {
        let input = BorderTextField()
        input.do { i in
            i.placeholder = placeholder

            i.font = .body1Reg
        
            i.textColor = .Text.main
            i.tintColor = .Text.main
            
            i.errorBorderColor = .Error.stroke
            i.borderColor = .Stroke.default
            i.focusedBorderColor = .Stroke.activeGreen
            i.disabledBorderColor = .Grey._90
            
            i.placeholderColor = .Text.secondary
            i.placeholderFont = .body1Reg
            
            i.hintInsets = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
            i.hintFont = .helperReg
            
            i.errorColor = .Error.text

            i.disabledContentBackgroundColor = .Button.btnDisabled
                        
            i.borderHeight = 52
            i.borderCorderRadius = DesignSystem.Corner.M
            i.sideViewTextInset = 8
            i.sideViewInset = 16
        }
        return input
    }
    
    static func floatingTextField(
        placeholder: String? = nil,
        rightViewText: String? = nil,

        normalRightViewImage: UIImage? = nil,
        highlightedRightViewImage: UIImage? = nil,

        rightViewAction: (() -> Void)? = nil,
        rightViewLabelText: String? = nil,
        rightViewLabeLFont: UIFont? = nil
    ) -> FloatingPlaceholderTextField {
        let input = FloatingPlaceholderTextField()
        input.do { i in
            i.textInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            i.floatingPlaceholderInsets = UIEdgeInsets(top: 6.5, left: 16, bottom: 0, right: 0)
            i.textFont = .body1Reg
            i.placeholderFont = .body1Reg
            i.floatingPlaceholderFont = .captionReg
            i.placeholder = placeholder
            i.normalTextColor = .Text.main
            
            i.placeholderColor = .Text.secondary
            i.borderWidth = 1
            i.borderCornerRadius = DesignSystem.Corner.M
                        
            i.normalBorderColor = .Stroke.default
            i.focusedBorderColor = .Stroke.activeGreen
            i.disabledBackgroundColor = .Grey._90

            i.floatingPlaceholderInsets = UIEdgeInsets(top: 6.5, left: 16, bottom: 0, right: 0)
            i.placeholderColor = .Text.secondary
            i.disabledPlaceholderColor = .Text.disabled
            i.placeholderFont = .body1Reg
            i.floatingPlaceholderFont = .captionReg
            
            i.hintInsets = UIEdgeInsets(top: 1, left: 12, bottom: 0, right: 12)
            i.hintFont = .helperReg
            
            i.normalHintColor = .Text.secondary
            i.errorHintColor = .Error.stroke

            i.normalBackgroundColor = .white
            i.disabledBackgroundColor = .white
            
            i.rightViewAction = rightViewAction
            
            i.rightViewLabelText = rightViewLabelText
            i.rightViewLabelFont = rightViewLabeLFont ?? .body1Med
            i.highlightedRightViewTintColor = .Grey._50
            
            i.normalRightViewImage = normalRightViewImage
            i.highlightedRightViewImage = highlightedRightViewImage
            
            i.sideViewsHorizontalInset = 14
            i.borderHeight = 52
        }
        return input
    }
    
    static func searchTextField(
        placeholder: String? = nil,
        leftViewImage: UIImage? = nil,
        leftViewAction: (() -> Void)? = nil,
        rightViewImage: UIImage? = nil,
        rightViewAction: (() -> Void)? = nil
    ) -> BorderTextField {
        let input = BorderTextField()
        input.do { i in
            i.placeholder = placeholder

            i.font = .body1Reg
            
            i.leftView = UIImageView(image: leftViewImage)
            i.leftViewMode = .always
            i.clearButtonMode = .whileEditing

            let clearButton = UIButton(type: .system)
            clearButton.setImage(rightViewImage, for: .normal)
            clearButton.addAction(UIAction { [weak i] _ in
                i?.clearCustomButtonTapped()
            }, for: .touchUpInside)

            i.rightView = clearButton
            i.rightViewMode = .always
            
            
            i.textColor = .Text.main
            i.tintColor = .Text.main
            
            i.errorBorderColor = .Error.stroke
            i.borderColor = .Stroke.default
            i.focusedBorderColor = .Stroke.activeGreen
            i.disabledBorderColor = .Grey._90
            
            i.placeholderColor = .Text.secondary
            i.placeholderFont = .body1Reg
            
            i.hintInsets = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
            i.hintFont = .helperReg
            
            i.errorColor = .Error.text

            i.disabledContentBackgroundColor = .Button.btnDisabled
                        
            i.borderHeight = 44
            i.borderCorderRadius = DesignSystem.Corner.M
            i.sideViewTextInset = 12
            i.sideViewInset = 12
        }
        return input
    }
}

// MARK: - Conrtolls

public extension DesignSystem.Controls {
    static func checkbox() -> CheckBox {
        let input = CheckBox()
        input.do { i in
            i.largeContentImageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            i.images[.normal] = RAsset.CheckBox.default.image
            i.images[.disabled] = RAsset.CheckBox.disabled.image
            i.images[.selected] = RAsset.CheckBox.active.image
            i.images[[.selected, .disabled]] = RAsset.CheckBox.disabledActive.image
            i.additionalTapAreaSize = 15
        }
        return input
    }
}
