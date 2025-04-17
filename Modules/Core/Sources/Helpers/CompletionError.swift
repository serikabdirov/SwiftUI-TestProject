//
//  CompletionError.swift
//  BallApp
//
//  Created by Vladislav on 23.12.2024.
//  Copyright © 2024 Spider Group. All rights reserved.
//

import UIKit

typealias CompletionVoid = () -> ()

public typealias Completion<T> = (UIViewController, Result<T?, CompletionError>) -> ()

public enum CompletionError: Error {
    case close
    case error(Error)
    case message(String?)
}
