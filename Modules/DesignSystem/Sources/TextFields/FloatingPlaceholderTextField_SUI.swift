//
//  FloatingPlaceholderTextField_SUI.swift
//  DesignSystem
//
//  Created by Kostikov Dmitriy on 19.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public struct FloatingPlaceholderTextField_SUI<RightView: View>: View {
    @Binding
    var text: String

    @Binding
    var helperText: String

    @FocusState
    private var isTyping: Bool

    @State
    private var state: TextFieldState = ._default

    @Environment(\.isEnabled)
    var isEnabled

    var isRequired: Bool
    var placeholder: String
    var validation: ((String) -> Bool)?
    var maxSymbolsCount: Int?

    let rightView: RightView

    // MARK: - Private properties

    private var shouldAnimateFloating: Bool {
        !text.isEmpty || isTyping
    }

    private var isValid: Bool {
        let validationResult = validation?(text) ?? true
        let maxSymbolsCountValidationResult =
            maxSymbolsCount == nil || text.count <= (maxSymbolsCount ?? .max)

        return validationResult && maxSymbolsCountValidationResult
    }

    private let filledPlaceholderPadding: EdgeInsets = .init(
        top: 6.5,
        leading: DS.Gap.L,
        bottom: 29.5,
        trailing: DS.Gap.L
    )
    private let defaultPlaceholderPadding: EdgeInsets = .init(
        top: 14.5,
        leading: DS.Gap.L,
        bottom: 14.5,
        trailing: DS.Gap.L
    )
    private let textContentPadding = EdgeInsets(
        top: 22.5,
        leading: DS.Gap.L,
        bottom: 6.5,
        trailing: DS.Gap.L
    )

    // MARK: - Init

    public init(
        placeholder: String = "",
        text: Binding<String>,
        helperText: Binding<String> = .constant(""),
        isRequired: Bool = false,
        maxSymbolsCount: Int? = nil,
        validation: ((String) -> Bool)? = nil,
        @ViewBuilder rightView: () -> RightView = { EmptyView() }
    ) {
        self._text = text
        self._helperText = helperText
        self.isRequired = isRequired
        self.placeholder = placeholder
        self.validation = validation
        self.maxSymbolsCount = maxSymbolsCount
        self.rightView = rightView()

        updateState()
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 0) {
                ZStack(alignment: .leading) {
                    placeholderView
                    textField
                }
                rightView
                    .padding(.trailing, DS.Gap.L)
            }
            .frame(height: 52)
            .background(
                state.backgroundColor,
                in: RoundedRectangle(cornerRadius: DS.Corner.M)
            )
            .overlay(
                RoundedRectangle(cornerRadius: DS.Corner.M)
                    .stroke(state.borderColor, lineWidth: 1)
            )
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
            if !helperText.isEmpty || maxSymbolsCount != nil {
                bottomView
            }
        }
    }

    // MARK: - Private properties

    @ViewBuilder
    private var placeholderView: some View {
        HStack(spacing: 2) {
            Text(placeholder)
                .foregroundColor(state.placeholderColor)
            if isRequired {
                Text("*")
                    .foregroundStyle(
                        UIColor.Error.text.swiftUIColor
                    )
            }
        }
//        .allowsHitTesting(false)
        .font(
            shouldAnimateFloating
                ? UIFont.captionReg.swiftUIFont
                : UIFont.body1Reg.swiftUIFont
        )
        .frame(height: shouldAnimateFloating ? 16 : 23)
        .padding(
            shouldAnimateFloating
                ? filledPlaceholderPadding
                : defaultPlaceholderPadding
        )
        .animation(
            .easeOut(duration: 0.2), value: shouldAnimateFloating
        )
    }

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
    private var textField: some View {
        TextField("", text: $text)
            .focused($isTyping)
            .foregroundColor(state.textColor)
            .frame(height: 23)
            .padding(textContentPadding)
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
                BackgroundView {
                    VStack {
                        FloatingPlaceholderTextField_SUI(
                            placeholder: "Placeholder", text: $text
                        )

                        FloatingPlaceholderTextField_SUI(
                            placeholder: "Placeholder", text: $text1
                        )
                        .keyboardType(.URL)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()

                        FloatingPlaceholderTextField_SUI(
                            placeholder: "Placeholder", text: $text2
                        )
                        .disabled(disabled)

                        Button {
                            disabled.toggle()
                        } label: {
                            Text("Toggle: \(disabled)")
                        }
                    }
                }
                .padding(.horizontal, DS.Gap.M)
                .padding(.vertical, DS.Gap.L)
            }
        }
    }
    return PreviewWrapper()
}

fileprivate enum TextFieldState {
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
