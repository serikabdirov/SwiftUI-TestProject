//
//  CheckBox_SUI.swift
//  DesignSystem
//
//  Created by Серик Абдиров on 12.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI
import R

public struct CheckBox_SUI: ToggleStyle {
    public func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                configuration.isOn ? RAsset.CheckBox.active.swiftUIImage : RAsset.CheckBox.default.swiftUIImage
                configuration.label
            }
        }
    }
}

/// Toggle("Toggle text", isOn: $isOn)
/// .toggleStyle(.ballInCheckbox)

public extension ToggleStyle where Self == CheckBox_SUI {
    static var ballInCheckbox: Self {
        CheckBox_SUI()
    }
}
