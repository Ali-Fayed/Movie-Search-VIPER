//
//  APIcaller.swift
//  VIPER
//
//  Created by Ali Fayed on 01/05/2021.
//

import Alamofire
import UIKit

class APIcaller {
    
    static let shared = APIcaller()
    
    let session: Session = {
      let configuration = URLSessionConfiguration.af.default
      configuration.requestCachePolicy = .returnCacheDataElseLoad
      let responseCacher = ResponseCacher(behavior: .modify { _, response in
        let userInfo = ["date": Date()]
        return CachedURLResponse(
          response: response.response,
          data: response.data,
          userInfo: userInfo,
          storagePolicy: .allowed)
      })

      let networkLogger = RequestLogger()
      let interceptor = RequsetInterceptor()

      return Session(
        configuration: configuration,
        interceptor: interceptor,
        cachedResponseHandler: responseCacher,
        eventMonitors: [networkLogger])
    }()
    
    func performRequest<T: Decodable>(dataModel: T.Type, requestData: RequestRouter, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            self.session.request(requestData).responseDecodable(of: T.self) { response in
                guard let results = response.value else {
                    completion(.failure(FetchError.failed))
                    return
                }
                completion(.success(results))
            }
        }
    }
}
