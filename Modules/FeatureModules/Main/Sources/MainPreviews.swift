//
//  MainPreviews.swift
//  Main
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI

#Preview("DEV") {
    MainView()
}

#Preview("MOCK") {
    let _ = MainContainer.shared.setupMockService()
    return MainView()
}

#Preview("ERROR") {
    let _ = MainContainer.shared.setupErrorService()
    return MainView()
}
