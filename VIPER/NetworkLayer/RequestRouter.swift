//
//  RequestRouter.swift
//  VIPER
//
//  Created by Ali Fayed on 01/05/2021.
//

import Alamofire

enum RequestRouter {
    
    case fetchMovies(String)
    
    var baseURL: String {
        switch self {
        case .fetchMovies:
            return "https://www.omdbapi.com"
        }
    }
    
    var path: String? {
        switch self {
        case .fetchMovies:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchMovies:
            return .get
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .fetchMovies(let query):
            return ["apikey" : "3aea79ac" , "s" : "\(query)" , "type" : "movie"]
        }
    }
}

// MARK: - URLRequestConvertible

extension RequestRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let requestURL = try baseURL.asURL()
        var request = URLRequest(url: requestURL)
        request.method = method
        if method == .get {
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        } else if method == .post {
            request = try JSONParameterEncoder().encode(parameters, into: request)
        }
        return request
    }
}
