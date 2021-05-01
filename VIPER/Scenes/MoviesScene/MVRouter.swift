//
//  MoviesViewRouter.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import UIKit

class MoviesViewRouter : MoviesRouter {
    var entry: EntryPoint?
    
    static func start() -> MoviesRouter {
        let router = MoviesViewRouter()
        var view: MoviesView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesView
        var presenter: MoviesPresenter = MoviesViewPresenter()
        var interactor: MoviesInteractor = MoviesViewInteractor()
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        router.entry = view as? EntryPoint
        return router
    }
    
}
