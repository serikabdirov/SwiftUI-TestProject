//
//  PlannedView.swift
//  DesignSystem
//
//  Created by Серик Абдиров on 21.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import R
import SwiftUI

public struct PlannedView: View {
    let data: DataModel

    public init(data: DataModel) {
        self.data = data
    }

    public var body: some View {
        let _ = Self._printChanges()
        VStack(alignment: .leading, spacing: 8) {
            headerView
            timeView
            button
        }

        .frame(maxWidth: .infinity, alignment: .leading)

        .padding(12)
        .background(UIColor.Main.white.swiftUIColor)
        .clipShape(.rect(cornerRadius: DesignSystem.Corner.M))
    }

    var headerView: some View {
        HStack {
            RAsset.Icons24.planIcon.swiftUIImage
            Text(data.name)
                .font(UIFont.body2Med.swiftUIFont)
                .foregroundStyle(UIColor.Text.secondary.swiftUIColor)
        }
    }

    var timeView: some View {
        HStack {
            weekdayText
            Spacer()
            timeText
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 10)

        .background(UIColor.Background.grey.swiftUIColor)
        .clipShape(.rect(cornerRadius: DesignSystem.Corner.S))
    }

    var weekdayText: some View {
        Text(data.weekday)
            .font(UIFont.body1Reg.swiftUIFont)
            .foregroundStyle(UIColor.Content.default.swiftUIColor)
    }

    var timeText: some View {
        Text(data.time)
            .font(UIFont.body1Med.swiftUIFont)
            .foregroundStyle(UIColor.Content.default.swiftUIColor)
    }

    var button: some View {
        Button {
            data.buttonAction?()
        } label: {
            Text(data.buttonName)
                .font(UIFont.btn2SemiBold.swiftUIFont)
                .foregroundStyle(UIColor.Button.textGreen.swiftUIColor)
        }
    }
}

public extension PlannedView {
    struct DataModel {
        let name: String
        let weekday: String
        let time: String
        let buttonName: String

        let buttonAction: (() -> Void)?

        public init(name: String, weekday: String, time: String, buttonName: String, buttonAction: (() -> Void)?) {
            self.name = name
            self.weekday = weekday
            self.time = time
            self.buttonName = buttonName
            self.buttonAction = buttonAction
        }
    }
}

#Preview {
    PlannedView(
        data: .init(
            name: "Запланировано",
            weekday: "Пятница",
            time: "20:00",
            buttonName: "Перейти в календарь",
            buttonAction: { print("tap") }
        )
    )
}
