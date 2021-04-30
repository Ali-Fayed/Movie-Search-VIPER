//
//  Interactor.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import Foundation
import Alamofire

class UsersInteractor: UserInteractor {
    
    var presenter: UserPresenter?
    
    func getUsers() {
        let url = "https://api.github.com/users"
        AF.request(url).responseDecodable(of: [User].self) { response in
            guard let results = response.value else {
                self.presenter?.InteractorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            self.presenter?.InteractorDidFetchUsers(with: .success(results))
        }
    }
    
}
