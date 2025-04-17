//
//  TextFormatters.swift
//  Core
//
//  Created by Александр Болотов on 09.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import RegexBuilder
import SwiftUICore

public enum TextFormatters {
    public static func makeNumbersBold(in text: String, font: Font) -> AttributedString {
        var attributedString = AttributedString(text)

        let numberRegex = Regex {
            // Опциональный знак "-" или "+"
            Optionally {
                CharacterClass(.anyOf("+-"))
            }
            // Целая часть с опциональной дробной
            Regex {
                OneOrMore(.digit)
                Optionally {
                    CharacterClass(.anyOf(".,"))
                    OneOrMore(.digit)
                }
            }
        }

        // Ищем все совпадения в строке
        let matches = text.matches(of: numberRegex)

        // Применяем жирный шрифт к найденным цифрам
        for match in matches {
            if let range = Range(match.range, in: attributedString) {
                attributedString[range].font = font
            }
        }

        return attributedString
    }
}
