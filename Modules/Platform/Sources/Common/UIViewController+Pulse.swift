//
//  File.swift
//  Platform
//
//  Created by Серик Абдиров on 16.01.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

#if PULSE_LOGGING
    import PulseUI
    import UIKit
    import RouteComposer

    extension UIViewController {
        override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            if motion == .motionShake {
                let pulseVC = PulseUI.MainViewController()
                UIWindow.keyWindow?.topmostViewController?.present(pulseVC, animated: true)
            }
        }
    }
#endif
