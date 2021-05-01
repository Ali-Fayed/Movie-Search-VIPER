//
//  MoviesViewController.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import UIKit
import SafariServices
import JGProgressHUD

class MoviesViewController: UIViewController {

    var presenter: MoviesPresenter?
    var movies = [Movie]()
    
    lazy var loadingIndicator = JGProgressHUD(style: .dark)
    lazy var searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var tableView: UITableView!
        
    private let searchForLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
           label.isHidden = true
           label.text = "Search For Movies or Series"
           return label
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(searchForLabel)
        definesPresentationContext = true
        tableView.isHidden = true
        searchForLabel.isHidden = true
        searchController.searchBar.delegate = self
        tableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        presenter?.setupSearchController(search: searchController, navigationItem: navigationItem)
        loadingIndicator.show(in: view)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchForLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        searchForLabel.center = view.center
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
      navigationItem.hidesSearchBarWhenScrolling = true
    }
}

  // MARK:- ViewLogic

extension MoviesViewController: MoviesView {
    
    func updateViewWithData(with movies: [Movie]) {
        DispatchQueue.main.async {
            self.movies = movies
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.loadingIndicator.dismiss()
        }
    }
    
    func updateViewWithError(with error: String) {
        DispatchQueue.main.async {
            self.movies = []
            self.tableView.reloadData()
            self.presenter?.errorAlert(errorMessage: error, viewController: self, loadingIndicator: self.loadingIndicator)
            self.tableView.isHidden = true
            
        }
    }
}

 // MARK:- tableView

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.cellData(with: movies[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Show movie details
        let imdbURL = "https://www.imdb.com/title/\(movies[indexPath.row].movieImdbID)/"
        let imdbVC = SFSafariViewController(url: URL(string: imdbURL)!)
        present(imdbVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK:- SearchBar

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.loadingIndicator.dismiss()
            self.searchForLabel.isHidden = false
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
            self.searchForLabel.isHidden = true
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            guard let searchText = searchBar.text else {
                return
            }
            self.presenter?.fetchDataToSearchBar(with: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.loadingIndicator.dismiss()
            self.searchForLabel.isHidden = true
            self.presenter?.fetchDataToSearchBar(with: "Avengers")
        }
    }
}
