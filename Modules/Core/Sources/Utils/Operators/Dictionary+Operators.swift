//
//  Dictionary+Operators.swift
//  Ostin
//
//  Created by Alexey Ostroverkhov on 13/11/2019.
//

import Foundation

public func + <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>) -> Dictionary<K,V> {
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}
