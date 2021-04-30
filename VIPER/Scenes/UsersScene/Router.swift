//
//  Router.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import UIKit

class UserRouter : AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        var view: UsersView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! UsersView
        var presenter: UserPresenter = UsersPresenter()
        var interactor: UserInteractor = UsersInteractor()
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        router.entry = view as? EntryPoint
        return router
    }
    
}
