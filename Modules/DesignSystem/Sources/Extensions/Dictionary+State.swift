//
//  Dictionary+State.swift
//  DesignSystem
//
//  Created by Александр Болотов on 03.02.2025.
//  Copyright © 2025 Spider Group. All rights reserved.
//


public extension Dictionary where Key == UIControl.State {
    func value(for state: UIControl.State) -> Value? {
        let key = keys
            .filter { $0.isSubset(of: state) }
            .max { $0.rawValue.nonzeroBitCount < $1.rawValue.nonzeroBitCount }
        return key.flatMap { self[$0] }
    }
}

extension UIControl.State: Hashable {}