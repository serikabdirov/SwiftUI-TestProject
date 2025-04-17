import Foundation

public extension NumberFormatter {

    static var rubblesWithOptionalFractionsFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.locale = Locale(identifier: "ru_RU")
        return numberFormatter
    }()
}
