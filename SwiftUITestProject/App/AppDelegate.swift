//
//  AppDelegate.swift
//  SwiftUITestProject
//
//  Created by Серик Абдиров on 14.05.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import Foundation
import UIKit
import Platform

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        print(#function)
        TabCoordinatorContainer.shared.tabCoordinator.register {
            TabCoordinator(tab: .main)
        }
        return true
    }
}
