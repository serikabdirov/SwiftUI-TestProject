//
//  PreviewInteractor.swift
//  VIPER
//
//  Created by Серик Абдиров on 13.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//



final class PreviewInteractor: VIPERInteractorProtocol {
    func getData() -> String {
        "PreviewInteractor ::: \(Int.random(in: 0 ..< 1000))"
    }
}