//
//  ActivityIndicatorComponent.swift
//  DesignSystem
//
//  Created by Денис Кожухарь on 13.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import UIKit
import CarbonKit

public struct ActivityIndicatorComponent: IdentifiableComponent {
    
    public let id = UUID()

    public init() {}

    public func renderContent() -> UIActivityIndicatorView {
        DesignSystem.Views.activityIndicator(style: .large)
    }

    public func render(in content: UIActivityIndicatorView) {}

    public func contentWillDisplay(_ content: UIActivityIndicatorView) {
        content.startAnimating()
    }

    public func contentDidEndDisplay(_ content: UIActivityIndicatorView) {
        content.stopAnimating()
    }

    public func shouldContentUpdate(with next: ActivityIndicatorComponent) -> Bool {
        false
    }
}
