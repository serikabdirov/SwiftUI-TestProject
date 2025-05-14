//
//  ViewState.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import SwiftUI
import Factory

@Observable
final class ViewState {
    @ObservationIgnored
    @Injected(\VIPERContainer.presenter)
    private var presenter

    var dataString: String?

    var isLoading = false
    var errorMessage: String?
    
    func updateDataButtonTapped() {
        presenter?.updateData()
    }
}
