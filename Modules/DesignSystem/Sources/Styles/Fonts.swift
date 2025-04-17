import R
import UIKit

// MARK: - Styles
public extension UIFont {
    /// montserrat-bold 40
    static let h1Bold = MontserratBold(size: 40)
    /// montserrat-bold 24
    static let h2Bold = MontserratBold(size: 24)
    /// montserrat-bold 20
    static let h3Bold = MontserratBold(size: 20)
    /// montserrat-semi-bold 20
    static let h3SemiBold = MontserratSemiBold(size: 20)
    
    /// montserrat-semi-bold 18
    static let sub1SemiBold = MontserratSemiBold(size: 18)
    /// montserrat-semi-bold 16
    static let sub2SemiBold = MontserratSemiBold(size: 16)
    
    /// montserrat-semi-bold 16
    static let body1SemiBold = MontserratSemiBold(size: 16)
    /// montserrat-medium 16
    static let body1Med = MontserratMedium(size: 16)
    /// montserrat-regular 16
    static let body1Reg = MontserratRegular(size: 16)
    /// montserrat-semi-bold 14
    static let body2SemiBold = MontserratSemiBold(size: 14)
    /// montserrat-medium 14
    static let body2Med = MontserratMedium(size: 14)
    /// montserrat-regular 14
    static let body2Reg = MontserratRegular(size: 14)
    
    /// montserrat-semi-bold 12
    static let captionSemiBold = MontserratSemiBold(size: 12)
    /// montserrat-medium 12
    static let captionMed = MontserratMedium(size: 12)
    /// montserrat-regular 12
    static let captionReg = MontserratRegular(size: 12)
    /// montserrat-regular 10
    static let helperReg = MontserratRegular(size: 10)
    /// montserrat-medium 10
    static let helperMed = MontserratMedium(size: 10)
    
    /// montserrat-semi-bold 16
    static let btn1SemiBold = MontserratSemiBold(size: 16)
    /// montserrat-semi-bold 14
    static let btn2SemiBold = MontserratSemiBold(size: 14)
    /// montserrat-medium 14
    static let btn2Med = MontserratMedium(size: 14)
    
    static let btn3SemiBold = MontserratSemiBold(size: 12)
}

// MARK: - Helpers

public extension UIFont {
    static func MontserratLight(size: CGFloat) -> UIFont {
        RFontFamily.Montserrat.light.font(size: size)
    }
    
    static func MontserratRegular(size: CGFloat) -> UIFont {
        RFontFamily.Montserrat.regular.font(size: size)
    }
    
    static func MontserratMedium(size: CGFloat) -> UIFont {
        RFontFamily.Montserrat.medium.font(size: size)
    }
    
    static func MontserratSemiBold(size: CGFloat) -> UIFont {
        RFontFamily.Montserrat.semiBold.font(size: size)
    }
    
    static func MontserratBold(size: CGFloat) -> UIFont {
        RFontFamily.Montserrat.bold.font(size: size)
    }
    
    static func MontserratExtraBold(size: CGFloat) -> UIFont {
        RFontFamily.Montserrat.extraBold.font(size: size)
    }
}
