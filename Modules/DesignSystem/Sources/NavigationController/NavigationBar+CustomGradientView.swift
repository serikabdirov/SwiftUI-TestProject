//
//  NavigationBar+CustomGradientView.swift
//  DesignSystem
//
//  Created by Vladislav on 13.12.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import UIKit

public class CustomNavigationBarGradientView: UIView {
    public enum Point {
        case topRight
        case topLeft
        case bottomRight
        case bottomLeft
        case custom(point: CGPoint)

        var point: CGPoint {
            switch self {
            case .topRight: CGPoint(x: 1, y: 0)
            case .topLeft: CGPoint(x: 0, y: 0)
            case .bottomRight: CGPoint(x: 1, y: 1)
            case .bottomLeft: CGPoint(x: 0, y: 1)
            case let .custom(point): point
            }
        }
    }

    private weak var gradientLayer: CAGradientLayer!
    private weak var gradientLayer2: CAGradientLayer!

    convenience init() {
        self.init(frame: .zero)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        layer.addSublayer(gradientLayer)

        let gradientLayer2 = CAGradientLayer()
        gradientLayer2.frame = frame
        layer.addSublayer(gradientLayer2)

        self.gradientLayer = gradientLayer
        self.gradientLayer2 = gradientLayer2
        setupGradients()
        backgroundColor = .Background.white
    }

    func setupGradients() {
        setupGradient(
            for: gradientLayer,
            colors: [
                .Green.gradient,
                .Main.white,
            ],
            startPoint: .topLeft,
            endPoint: .bottomLeft,
            locations: [0.0, 1.0]
        )

        setupGradient(
            for: gradientLayer2,
            colors: [
                .Main.white.withAlphaComponent(0.1),
                .Main.white,
            ],
            startPoint: .topLeft,
            endPoint: .bottomLeft,
            locations: [0.1, 1.0]
        )
    }

    func setupGradient(
        for layer: CAGradientLayer,
        colors: [UIColor],
        startPoint: Point = .topLeft,
        endPoint: Point = .bottomLeft,
        locations: [NSNumber] = [0, 1]
    ) {
        layer.colors = colors.map(\.cgColor)
        layer.startPoint = startPoint.point
        layer.endPoint = endPoint.point
        layer.locations = locations
    }

    func setupConstraints() {
        guard let parentView = superview else { return }

        self.snp.makeConstraints { make in
            make.top.equalTo(parentView.snp.top)
            make.left.equalTo(parentView.snp.left)
            make.bottom.equalTo(parentView.snp.bottom)
            make.right.equalTo(parentView.snp.right)
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        guard let gradientLayer, let gradientLayer2 else { return }
        gradientLayer.frame = frame
        gradientLayer2.frame = frame
        superview?.addSubview(self)
    }
}

public extension UINavigationBar {
    func setGradientNavigationBar() {
        guard let backgroundView = value(forKey: "backgroundView") as? UIView else { return }
        guard backgroundView.subviews
            .first(where: { $0 is CustomNavigationBarGradientView }) is CustomNavigationBarGradientView
        else {
            let gradientView = CustomNavigationBarGradientView()
            backgroundView.addSubview(gradientView)
            gradientView.setupConstraints()
            return
        }
    }
}
