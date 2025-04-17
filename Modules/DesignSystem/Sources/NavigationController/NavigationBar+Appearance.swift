import UIKit

public enum NavigationBar {
    public enum Appearance {
        case hidden

        case standard(
            standardAppearance: UINavigationBarAppearance,
            compactAppearance: UINavigationBarAppearance,
            scrollEdgeAppearance: UINavigationBarAppearance,
            compactScrollEdgeAppearance: UINavigationBarAppearance,
            barButtonsTintColor: UIColor,
            withGradient: Bool
        )

        case largeTitle(
            standardAppearance: UINavigationBarAppearance,
            compactAppearance: UINavigationBarAppearance,
            scrollEdgeAppearance: UINavigationBarAppearance,
            compactScrollEdgeAppearance: UINavigationBarAppearance,
            barButtonsTintColor: UIColor,
            withGradient: Bool
        )
    }
}

public extension NavigationBar.Appearance {
    static var adaptiveBlurred: NavigationBar.Appearance {
        let navTitleAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.Text.main,
            NSAttributedString.Key.font: UIFont.body1SemiBold
        ]
        
        let standardAppearance = UINavigationBarAppearance().then { appearance in
            appearance.configureWithDefaultBackground()
            appearance.backgroundEffect = UIBlurEffect(style: .light)
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = navTitleAttr
        }
        let scrollEdgeAppearance = UINavigationBarAppearance().then { appearance in
            appearance.configureWithTransparentBackground()
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = navTitleAttr
        }
        return .standard(
            standardAppearance: standardAppearance,
            compactAppearance: standardAppearance,
            scrollEdgeAppearance: scrollEdgeAppearance,
            compactScrollEdgeAppearance: scrollEdgeAppearance,
            barButtonsTintColor: .black,
            withGradient: true
        )
    }

    static var withoutGradient: NavigationBar.Appearance {
        let navTitleAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.Text.white,
            NSAttributedString.Key.font: UIFont.body1SemiBold
        ]

        let standardAppearance = UINavigationBarAppearance().then { appearance in
            appearance.configureWithDefaultBackground()
            appearance.backgroundEffect = UIBlurEffect(style: .light)
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = navTitleAttr
        }
        let scrollEdgeAppearance = UINavigationBarAppearance().then { appearance in
            appearance.configureWithTransparentBackground()
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = navTitleAttr
        }
        return .standard(
            standardAppearance: standardAppearance,
            compactAppearance: standardAppearance,
            scrollEdgeAppearance: scrollEdgeAppearance,
            compactScrollEdgeAppearance: scrollEdgeAppearance,
            barButtonsTintColor: .Text.white,
            withGradient: false
        )
    }
}
