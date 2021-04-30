//
//  Presenter.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import Foundation

class UsersPresenter: UserPresenter {
    
    var router: AnyRouter?
    var view: UsersView?
    var interactor: UserInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
            
    func InteractorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.updateViewWithData(with: users)
        case .failure:
            view?.updateViewWithError(with: "Something went wrong")
        }
    }
}
