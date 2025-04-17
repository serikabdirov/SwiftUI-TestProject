//
//  SwiftUI+Injection.swift
//  DesignSystem
//
//  Created by Серик Абдиров on 17.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SnapKit
import SwiftUI

public extension View {
    func injectIn(_ parentView: UIView) {
        let hostingController = UIHostingController(rootView: self)
        let hostingView = hostingController.view!

        hostingView.translatesAutoresizingMaskIntoConstraints = false
        hostingView.backgroundColor = .clear
        parentView.addSubview(hostingView)

        hostingView.snp.makeConstraints { make in
            make.edges.equalTo(parentView)
        }
    }
}

public extension View {
    func injectIn(_ parentViewController: UIViewController) {
        let hostingController = UIHostingController(rootView: self)
        let hostingView = hostingController.view!

        hostingView.translatesAutoresizingMaskIntoConstraints = false
        hostingView.backgroundColor = .clear
        parentViewController.addChild(hostingController)
        parentViewController.view.addSubview(hostingView)
        hostingController.didMove(toParent: parentViewController)

        hostingView.snp.makeConstraints { make in
            make.edges.equalTo(parentViewController.view)
        }
    }
}
