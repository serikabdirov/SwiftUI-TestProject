//
//  AppNameTarget.swift
//
//  Created by Денис Кожухарь on 29.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Foundation
@_exported import Networking

private struct TargetTypeWrapper: TargetType {
    let baseURL: URL
    let path: String
    let method: HTTPMethod
    let parameters: RequestParameters
    let headers: HTTPHeaders?
    let multipartFormData: (MultipartFormData) -> Void

    init(target: TargetType) {
        self.baseURL = target.baseURL
        self.path = target.path
        self.method = target.method
        self.parameters = target.parameters
        self.headers = target.headers
        self.multipartFormData = target.multipartFormData
    }
}

public protocol BallTarget: TargetType {
    var shouldAuthorize: Bool { get }
    var timeout: TimeInterval { get }
}

// swiftlint:disable force_unwrapping
public extension BallTarget {
    var baseURL: URL {
        URL(string: "https://dev.back.ball-in.spider.ru")!
    }

    var timeout: TimeInterval { 30 }

    func asURLRequest() throws -> URLRequest {
        let superTarget = TargetTypeWrapper(target: self)
        var request = try superTarget.asURLRequest()
        request.timeoutInterval = timeout
        return request
    }
}

// swiftlint:enable force_unwrapping
public struct BallTargetModel: BallTarget {
    public let path: String
    public let method: HTTPMethod
    public let parameters: RequestParameters
    public let headers: HTTPHeaders?
    public let shouldAuthorize: Bool
    public let timeout: TimeInterval
    public let multipartFormData: (MultipartFormData) -> Void

    public init(
        path: String,
        method: HTTPMethod = .get,
        parameters: RequestParameters = .requestPlain,
        headers: HTTPHeaders? = nil,
        shouldAuthorize: Bool = true,
        timeout: TimeInterval = 60,
        multipartFormData: @escaping (MultipartFormData) -> Void = { _ in }
    ) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.shouldAuthorize = shouldAuthorize
        self.timeout = timeout
        self.multipartFormData = multipartFormData
    }
}

enum BallTargetKeys {
    static let shouldAuthorizeHeader = "BallTarget.shouldAuthorize"
    static let hashHeader = "Hash"
    static let timestampHeader = "Timestamp"
}
