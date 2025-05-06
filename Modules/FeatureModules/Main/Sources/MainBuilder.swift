//
//  MainBuilder.swift
//  Main
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public protocol Builder {
    associatedtype BuildableView: View
    func build() -> BuildableView
}

public class MainBuilder: Builder {

    public init() {}
    
    public func build() -> MainView {
        MainView()
    }
}
