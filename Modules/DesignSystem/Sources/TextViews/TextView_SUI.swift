//
//  TextView_SUI.swift
//  DesignSystem
//
//  Created by Александр Болотов on 24.03.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public struct TextView_SUI: View {
    @Binding
    var text: String

    @Binding
    var helperText: String

    @FocusState
    private var isTyping: Bool

    @State
    private var state: TextInputState = ._default

    @Environment(\.isEnabled)
    var isEnabled

    var placeholder: String
    var validation: ((String) -> Bool)?
    var maxSymbolsCount: Int?

    // MARK: - Private properties

    private var isValid: Bool {
        let validationResult = validation?(text) ?? true
        let maxSymbolsCountValidationResult =
            maxSymbolsCount == nil || text.count <= (maxSymbolsCount ?? .max)

        return validationResult && maxSymbolsCountValidationResult
    }

    private let textContentPadding = EdgeInsets(
        top: 0,
        leading: DS.Gap.M,
        bottom: 0,
        trailing: DS.Gap.M
    )

    // MARK: - Init

    public init(
        placeholder: String = "",
        text: Binding<String>,
        helperText: Binding<String> = .constant(""),
        maxSymbolsCount: Int? = nil,
        validation: ((String) -> Bool)? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self._helperText = helperText
        self.validation = validation
        self.maxSymbolsCount = maxSymbolsCount

        updateState()
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: .topLeading) {
                textView
                    .onTapGesture {
                        isTyping = true
                    }
                    .onChange(of: isTyping) {
                        updateState(isEnabled: isEnabled, isError: !isValid)
                    }
                    .onChange(of: text) {
                        updateState(isEnabled: isEnabled, isError: !isValid)
                    }
                    .onChange(of: isEnabled) {
                        updateState(isEnabled: isEnabled)
                    }
            }
            .overlay(alignment: .topLeading) {
                if !isTyping, text.isEmpty {
                    placeholderView
                        .padding(.top, DS.Gap.S)
                        .padding(.leading, DS.Gap.L)
                }
            }
            if !helperText.isEmpty || maxSymbolsCount != nil {
                bottomView
            }
        }
    }

    // MARK: - Private properties

    @ViewBuilder
    private var bottomView: some View {
        HStack(spacing: DS.Gap.M) {
            if !helperText.isEmpty {
                Text(helperText)
                    .font(UIFont.helperReg.swiftUIFont)
                    .foregroundColor(state.placeholderColor)
                    .frame(height: 14)
            }
            if let maxSymbolsCount {
                Spacer()
                Text("\(text.count) / \(maxSymbolsCount)")
                    .font(UIFont.helperReg.swiftUIFont)
                    .foregroundColor(state.placeholderColor)
                    .frame(height: 14)
            }
        }
    }

    @ViewBuilder
    private var textView: some View {
        TextEditor(text: $text)
            .focused($isTyping)
            .foregroundColor(state.textColor)
            .scrollContentBackground(.hidden)
            .padding(textContentPadding)
            .background(state.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: DS.Gap.S, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DS.Corner.S)
                    .stroke(state.borderColor, lineWidth: 1)
            )
    }

    @ViewBuilder
    private var placeholderView: some View {
        Text(placeholder)
            .font(UIFont.body1Reg.swiftUIFont)
            .foregroundStyle(UIColor.Text.secondary.swiftUIColor)
    }

    // MARK: - Private properties

    private func updateState(isEnabled: Bool = true, isError: Bool = false) {
        guard isEnabled else {
            state = .disabled
            return
        }

        guard !isError else {
            state = .error
            return
        }

        if isTyping {
            state = .focused
            debugPrint(state)
        } else if text.isEmpty {
            state = ._default
            debugPrint(state)
        } else {
            state = .filled
            debugPrint(state)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State
        var text = "dsfsdf"
        @State
        var text1 = "dsfsdf"
        @State
        var text2 = "dsfsdf"

        @State
        var disabled = false

        var body: some View {
            ScrollView {
                VStack(spacing: DS.Gap.L) {
                    TextView_SUI(placeholder: "Правила участия", text: $text)
                        .frame(height: 135)
                        .withBackgroundView()

                    TextView_SUI(placeholder: "Правила участия", text: $text)
                        .frame(height: 90)
                        .withBackgroundView()

                    TextView_SUI(placeholder: "Правила участия", text: $text, maxSymbolsCount: 8)
                        .disabled(disabled)
                        .frame(height: 57)
                        .withBackgroundView()

                    Button {
                        disabled.toggle()
                    } label: {
                        Text("Toggle: \(disabled)")
                    }
                }
                .padding(.horizontal, DS.Gap.M)
                .padding(.vertical, DS.Gap.L)
            }
        }
    }
    return PreviewWrapper()
}

enum TextInputState {
    case _default
    case filled
    case error
    case focused
    case disabled

    var borderColor: Color {
        switch self {
        case ._default:
            UIColor.Stroke.default.swiftUIColor
        case .filled:
            UIColor.Stroke.filled.swiftUIColor
        case .error:
            UIColor.Error.stroke.swiftUIColor
        case .disabled:
            UIColor.Grey._90.swiftUIColor
        case .focused:
            UIColor.Stroke.activeGreen.swiftUIColor
        }
    }

    var placeholderColor: Color {
        switch self {
        case ._default,
             .filled,
             .focused:
            UIColor.Text.secondary.swiftUIColor
        case .disabled:
            UIColor.Text.disabled.swiftUIColor
        case .error:
            UIColor.Error.text.swiftUIColor
        }
    }

    var textColor: Color {
        switch self {
        case ._default,
             .filled,
             .focused,
             .error:
            UIColor.Text.main.swiftUIColor
        case .disabled:
            UIColor.Text.disabled.swiftUIColor
        }
    }

    var backgroundColor: Color {
        switch self {
        case ._default,
             .filled,
             .focused,
             .error:
            UIColor.Background.white.swiftUIColor
        case .disabled:
            UIColor.Background.grey.swiftUIColor
        }
    }
}
