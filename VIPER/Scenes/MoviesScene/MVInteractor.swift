//
//  MoviesViewInteractor.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import Foundation
import Alamofire

class MoviesViewInteractor: MoviesInteractor {
    
    var presenter: MoviesPresenter?
    
    func fetchMovies(with query: String) {
        APIcaller.shared.performRequest(dataModel: MoviesEntity.self, requestData: RequestRouter.fetchMovies(query)) { response in
            switch response {
            case .success(let results):
                self.presenter?.interactorDidFetchUsers(with: .success(results.entityItems))
            case .failure:
                self.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
            }
        }
    }
    
}
