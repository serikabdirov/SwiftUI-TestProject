//
//  ScheduleTimeViewCell.swift
//  DesignSystem
//
//  Created by Александр Болотов on 09.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public struct ScheduleTimeViewCell: View {
    let time: String
    let day: String
    
    public init(time: String, day: String) {
        self.time = time
        self.day = day
    }

    public var body: some View {
        HStack {
            weekdayText(day)
            Spacer()
            timeText(time)
        }
        .frame(height: 40, alignment: .center)
        .padding(.horizontal, DS.Gap.S)
        .background(UIColor.Background.grey.swiftUIColor)
        .clipShape(.rect(cornerRadius: DesignSystem.Corner.S))
    }

    private func weekdayText(_ text: String) -> some View {
        Text(text)
            .font(UIFont.body1Reg.swiftUIFont)
            .foregroundStyle(UIColor.Content.default.swiftUIColor)
    }

    private func timeText(_ text: String) -> some View {
        Text(text)
            .font(UIFont.body1Med.swiftUIFont)
            .foregroundStyle(UIColor.Content.default.swiftUIColor)
    }
}
