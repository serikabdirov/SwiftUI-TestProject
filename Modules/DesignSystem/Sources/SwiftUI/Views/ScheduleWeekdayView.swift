//
//  ScheduleWeekdayView.swift
//  DesignSystem
//
//  Created by Александр Болотов on 31.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Platform
import SwiftUI

public struct ScheduleWeekdayView: View {
    private let title: String
    private let formatter = DateFormatter.hoursMinutesFormatter

    @ObservedObject
    private var dataModel: DataModel

    public init(title: String, dataModel: DataModel) {
        self.title = title
        self.dataModel = dataModel
    }

    public var body: some View {
        BackgroundView {
            VStack(alignment: .leading, spacing: 24) {
                Text(title)
                    .font(UIFont.body2Med.swiftUIFont)
                    .foregroundStyle(UIColor.Text.secondary.swiftUIColor)

                VStack(spacing: 32) {
                    ForEach(Schedule.ScheduleWeekday.allCases, id: \.self) { weekday in
                        HStack {
                            toggle(for: weekday)
                            datePicker(for: weekday)
                        }
                    }
                }
            }
            .padding([.horizontal, .top], 12)
            .padding(.bottom, 28)
            .background(UIColor.Main.white.swiftUIColor)
            .clipShape(.rect(cornerRadius: DesignSystem.Corner.M))
        }
    }

    @ViewBuilder
    private func toggle(for weekday: Schedule.ScheduleWeekday) -> some View {
        Toggle(isOn: dataModel.select(day: weekday)) {
            Text(weekday.title)
                .font(UIFont.body1Med.swiftUIFont)
                .foregroundStyle(UIColor.Text.main.swiftUIColor)

            Spacer()
        }
        .toggleStyle(.ballInCheckbox)
    }

    @ViewBuilder
    private func datePicker(for weekday: Schedule.ScheduleWeekday) -> some View {
        HStack(spacing: 4) {
            Text(formatter.string(from: dataModel.selectedDates[weekday] ?? dataModel.datesDict[weekday] ?? .now))
                .font(UIFont.body2Med.swiftUIFont)
                .foregroundStyle(UIColor.Button.textGreen.swiftUIColor)

            RAsset.Icons24.chevronDown.swiftUIImage
                .frame(width: 24, height: 24)
        }
        .overlay {
            DatePicker("", selection: dataModel.binding(for: weekday), displayedComponents: .hourAndMinute)
                .colorMultiply(.clear)
        }
    }
}

#Preview {
    ScheduleWeekdayView(title: RStrings.Ls.Courses.Planning.days, dataModel: .init())
}

public extension ScheduleWeekdayView {
    class DataModel: ObservableObject {
        @Published
        var datesDict: [Schedule.ScheduleWeekday: Date]

        @Published
        public var selectedDates: [Schedule.ScheduleWeekday: Date] = [:]

        public init() {
            self.datesDict = Schedule.ScheduleWeekday.allCases
                .reduce(into: [:]) { result, element in
                    result[element] = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: .now)
                }
            
            print(self.datesDict)
        }

        public func binding(for day: Schedule.ScheduleWeekday) -> Binding<Date> {
            .init(
                get: {
                    self.selectedDates[day] ?? self.datesDict[day] ?? .now
                },
                set: {
                    self.datesDict.updateValue($0, forKey: day)
                    self.selectedDates.updateValue($0, forKey: day)
                }
            )
        }

        public func select(day: Schedule.ScheduleWeekday) -> Binding<Bool> {
            .init(
                get: {
                    self.selectedDates[day] != nil
                },
                set: { isSelect in
                    if let selectedDate = self.selectedDates[day] {
                        self.datesDict.updateValue(selectedDate, forKey: day)
                    }
                    
                    if isSelect {
                        let date = self.datesDict[day] ?? .now
                        self.selectedDates.updateValue(date, forKey: day)
                    } else {
                        self.selectedDates.removeValue(forKey: day)
                    }
                }
            )
        }
    }
}
