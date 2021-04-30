//
//  View.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UsersView {
        
    var presenter: UserPresenter?
    var users = [User]()
    @IBOutlet weak var tableView: UITableView!
        
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        errorLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        errorLabel.center = view.center
    }
    
    func updateViewWithData(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func updateViewWithError(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.tableView.reloadData()
            self.errorLabel.text = error
            self.tableView.isHidden = true
            self.errorLabel.isHidden = false
        }
    }

}

 // MARK:- tableView

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UsersTableViewCell
        cell.cellData(with: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = users[indexPath.row].userURL
        let safariVC = SFSafariViewController(url: URL(string: url)!)
        self.present(safariVC, animated: true)
    }
}
