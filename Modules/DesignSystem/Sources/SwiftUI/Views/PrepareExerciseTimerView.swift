//
//  PrepareExerciseTimerView.swift
//  DesignSystem
//
//  Created by Александр Болотов on 06.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Lottie
import R
import SwiftUI

public struct PrepareExerciseTimerView: View {
    @Binding
    var timeRemaining: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let title: String
    let subtitle: String

    public init(
        _ timeRemaining: Binding<Int>,
        title: String = RStrings.Ls.Exercise.Detail.Prepare.title,
        subtitle: String = RStrings.Ls.Exercise.Detail.Prepare.subtitle
    ) {
        self._timeRemaining = timeRemaining
        self.title = title
        self.subtitle = subtitle
    }

    public var body: some View {
        VStack() {
            VStack(spacing: 8) {
                Text(title)
                    .font(UIFont.h3Bold.swiftUIFont)
                    .foregroundStyle(UIColor.Main.black.swiftUIColor)

                Text(subtitle)
                    .font(UIFont.body1Reg.swiftUIFont)
                    .foregroundStyle(UIColor.Main.black.swiftUIColor)
            }

            ZStack {
                LottieView(animation: .filepath(R.Files.Modules.R.Resources.Lottie.circleJson.path))
                    .playing(loopMode: .loop)
                    .aspectRatio(1, contentMode: .fit)

                Text("\(timeRemaining)")
                    .font(UIFont.MontserratBold(size: 80).swiftUIFont)
                    .contentTransition(.numericText(countsDown: true))
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            withAnimation {
                                timeRemaining -= 1
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State
        private var timeRemaining = 3

        var body: some View {
            PrepareExerciseTimerView($timeRemaining)
        }
    }
    return PreviewWrapper()
}
