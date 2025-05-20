//
//  Coordinator.swift
//  Core
//
//  Created by Серик Абдиров on 14.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

@Observable
public final class Coordinator<Router: NavigationRouter> {
    public var path = NavigationPath()
    public var sheet: Router?

    public init() {}

    public func push(_ page: Router) {
        path.append(page)
        
    }

    public func pop() {
        path.removeLast()
    }

    public func popToRoot() {
        path.removeLast(path.count)
    }

    public func present(sheet: Router) {
        self.sheet = sheet
    }

    public func dismissSheet() {
        sheet = nil
    }

    @ViewBuilder
    public func build(_ route: Router) -> some View {
        route.view()
    }
}
