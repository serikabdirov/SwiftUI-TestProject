//
//  ApiVersionRequestAdapter.swift
//  Platform
//
//  Created by Денис Кожухарь on 06.10.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import Alamofire
import Foundation

final class ApiVersionRequestAdapter: RequestAdapter {
    private let version = "1.0"

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var urlRequest = urlRequest
        var acceptHeader: String = ""
        if let accept = urlRequest.headers.value(for: "Accept") {
            acceptHeader = "\(accept), application/json; version=\(version)"
        } else {
            acceptHeader = "application/json; version=\(version)"
        }
        urlRequest.setValue(acceptHeader, forHTTPHeaderField: "Accept")
        completion(.success(urlRequest))
    }
}
