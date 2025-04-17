//
//  TargetProcessingFinder.swift
//  Core
//
//  Created by Александр Болотов on 10.04.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//

import RouteComposer
import UIKit

public struct TargetProcessingFinder<VC, C, F: Finder>: Finder where
    VC: UIViewController,
    F.ViewController == VC,
    F.Context == C
{
    // MARK: Associated types

    public typealias ViewController = VC

    public typealias Context = C

    // MARK: - Private properties

    private let finder: F
    private let onFound: (ViewController, Context) -> Void

    public init(_ finder: F, onFound: @escaping (ViewController, Context) -> Void) {
        self.finder = finder
        self.onFound = onFound
    }

    public func findViewController(with context: C) throws -> VC? {
        let vc = try finder.findViewController(with: context)
        if let vc {
            onFound(vc, context)
        }
        return vc
    }
}
