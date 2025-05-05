//
//  LoadingState.swift
//  DesignSystem
//
//  Created by Серик Абдиров on 05.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

public enum LoadingState {
    case idle
    case loading
    case loaded
    case failed(Error)
}
