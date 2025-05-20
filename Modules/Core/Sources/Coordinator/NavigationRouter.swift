//
//  NavigationRouter.swift
//  Core
//
//  Created by Серик Абдиров on 14.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public protocol NavigationRouter: Hashable, Identifiable {
    associatedtype V: View

    var title: String? { get }

    @ViewBuilder
    func view() -> V
}

extension NavigationRouter {
    public var id: Self { self }
}
