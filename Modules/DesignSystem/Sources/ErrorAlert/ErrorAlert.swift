//
//  ErrorAlert.swift
//  DesignSystem
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

struct ErrorAlert: ViewModifier {
    @Binding var errorMessage: String?

    func body(content: Content) -> some View {
        content
            .alert(isPresented: Binding<Bool>(
                get: { errorMessage != nil },
                set: { newValue in
                    if !newValue { errorMessage = nil }
                }
            )) {
                Alert(
                    title: Text("Ошибка"),
                    message: Text(errorMessage ?? "Неизвестная ошибка"),
                    dismissButton: .default(Text("ОК"))
                )
            }
    }
}

public extension View {
    func errorAlert(_ errorMessage: Binding<String?>) -> some View {
        self.modifier(ErrorAlert(errorMessage: errorMessage))
    }
}
