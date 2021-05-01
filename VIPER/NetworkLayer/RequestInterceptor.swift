//
//  RequsetInterceptor.swift
//  VIPER
//
//  Created by Ali Fayed on 01/05/2021.
//

import Alamofire

class RequsetInterceptor: RequestInterceptor {
  let retryLimit = 5
  let retryDelay: TimeInterval = 10

  func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
    completion(.success(urlRequest))
  }

  func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
    let response = request.task?.response as? HTTPURLResponse
    // Retry for 5xx status codes
    if
      let statusCode = response?.statusCode,
      (500...599).contains(statusCode),
      request.retryCount < retryLimit {
        completion(.retryWithDelay(retryDelay))
    } else {
      return completion(.doNotRetry)
    }
  }

}
