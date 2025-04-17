//
//  Debounce.swift
//  KeyAuto
//
//  Created by Alexey Ostroverkhov on 01.07.2020.
//  Copyright © 2020 Spider. All rights reserved.
//

import Foundation

public typealias Debounce<T> = (_ : T) -> Void

public func debounce<T>(interval: Int, queue: DispatchQueue, action: @escaping Debounce<T>) -> Debounce<T> {
    var lastFireTime = DispatchTime.now()
    let dispatchDelay = DispatchTimeInterval.milliseconds(interval)

    return { param in
        lastFireTime = DispatchTime.now()
        let dispatchTime: DispatchTime = DispatchTime.now() + dispatchDelay

        queue.asyncAfter(deadline: dispatchTime) {
            let when: DispatchTime = lastFireTime + dispatchDelay
            let now = DispatchTime.now()

            if now.rawValue >= when.rawValue {
                action(param)
            }
        }
    }
}
