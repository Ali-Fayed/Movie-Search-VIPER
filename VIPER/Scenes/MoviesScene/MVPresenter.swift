//
//  MoviesViewPresenter.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import UIKit
import JGProgressHUD

class MoviesViewPresenter: MoviesPresenter {
   
    var router: MoviesRouter?
    var view: MoviesView?
    var interactor: MoviesInteractor? {
        didSet {
            interactor?.fetchMovies(with: "Avengers")
        }
    }
    
    func interactorDidFetchUsers(with result: Result<[Movie], Error>) {
        switch result {
        case .success(let movies):
            view?.updateViewWithData(with: movies)
        case .failure:
            view?.updateViewWithError(with: "Cannot Find Your Movie")
        }
    }
    
    func setupSearchController (search: UISearchController, navigationItem: UINavigationItem) {
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        search.searchBar.placeholder = "Search ..."
        navigationItem.searchController = search
    }
    
    func errorAlert(errorMessage: String, viewController: UIViewController, loadingIndicator: JGProgressHUD) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {_ in
            loadingIndicator.show(in: viewController.view)
        }
        alert.addAction(action)
        viewController.present(alert, animated: false, completion: nil)
    }
    
    func fetchDataToSearchBar(with query: String) {
        interactor?.fetchMovies(with: query)
    }
    
}
