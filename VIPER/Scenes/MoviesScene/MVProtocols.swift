//
//  MoviesProtocols.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import UIKit
import JGProgressHUD

protocol MoviesView {
    var presenter: MoviesPresenter? {get set}
    func updateViewWithData(with movies: [Movie])
    func updateViewWithError(with error: String)
}

protocol MoviesInteractor {
    var presenter: MoviesPresenter? {get set}
    func fetchMovies(with query: String)
}

protocol MovieCellViewModel {
    func cellData(with model: Movie)
}

protocol MoviesPresenter {
    var router: MoviesRouter? {get set}
    var interactor: MoviesInteractor? {get set}
    var view: MoviesView? {get set}
    func interactorDidFetchUsers(with result: Result<[Movie], Error>)
    func setupSearchController (search: UISearchController, navigationItem: UINavigationItem)
    func errorAlert (errorMessage: String, viewController: UIViewController, loadingIndicator: JGProgressHUD)
    func fetchDataToSearchBar(with query: String)
}

typealias EntryPoint = MoviesView & UIViewController
protocol MoviesRouter {
    var entry: EntryPoint? {get}
    static func start () -> MoviesRouter
}

enum FetchError: Error {
    case failed
}
