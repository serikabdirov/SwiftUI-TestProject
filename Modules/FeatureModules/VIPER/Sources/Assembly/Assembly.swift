//
//  Assembly.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

public final class VIPERAssembly {
    public init() {}

    public func build() -> some View { VIPERCoordinatorView() }
}

#Preview {
    VIPERAssembly().build()
}
