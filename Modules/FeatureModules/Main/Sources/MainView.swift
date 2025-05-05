//
//  MainView.swift
//  Main
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    public var body: some View {
        Text(viewModel.data ?? "")
            .asyncContent(viewModel)
    }
}
