//
//  Router.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    
    var entry: EntryPoint? {get}
    static func start () -> AnyRouter
}

class UserRouter : AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        var view: AnyView = ViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        router.entry = view as? EntryPoint
        return router
    }
    
}
