//
//  AuthorizationRequestAdapter.swift
//  Platform
//

import Alamofire
import Foundation

final class AuthorizationRequestInterceptor: RequestInterceptor {
    // MARK: - Private properties

    private let authManager: AuthManager

    // MARK: - Init

    init(authManager: AuthManager) {
        self.authManager = authManager
    }

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var urlRequest = urlRequest
        if
            urlRequest.headers.value(for: BallTargetKeys.shouldAuthorizeHeader) != nil ||
                urlRequest.headers.value(for: "Authorization") != nil
        {
            Task {
                do {
                    let token = try await authManager.validToken()

                    urlRequest.setValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
                    // чистим temp header, установленный в Target, если нужно
                    urlRequest.setValue(nil, forHTTPHeaderField: BallTargetKeys.shouldAuthorizeHeader)
                    
                    completion(.success(urlRequest))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        } else {
            completion(.success(urlRequest))
        }
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, request.retryCount < 1, response.statusCode == 401 {
            Task {
                do {
                    // Попробуем обновить токен
                    _ = try await authManager.refreshToken()
                    completion(.retry)
                } catch {
                    completion(.doNotRetryWithError(error))
                }
            }
        } else {
            completion(.doNotRetry)
        }
    }
}
