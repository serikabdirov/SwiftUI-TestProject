//
//  LoadableObject.swift
//  DesignSystem
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public protocol LoadableObject: ObservableObject {
    var loadingState: LoadingState { get }
    @MainActor func load() async
}
