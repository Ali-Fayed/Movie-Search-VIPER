//
//  Presenter.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import Foundation

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func InteractorDidFetchUsers(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    
    var router: AnyRouter?
    var view: AnyView?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
        
    func InteractorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
}
