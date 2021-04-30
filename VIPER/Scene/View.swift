//
//  View.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import UIKit

protocol AnyView {
    var presenter: AnyPresenter? {get set}
    func update(with users: [User])
    func update(with error: String)
}

class ViewController: UIViewController, AnyView, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: AnyPresenter?
    var users = [User]()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(errorLabel)
        view.backgroundColor = .systemBlue
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        errorLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        errorLabel.center = view.center
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].login
        return cell
    }

    func update(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.tableView.reloadData()
            self.errorLabel.text = error
            self.tableView.isHidden = true
            self.errorLabel.isHidden = false
        }
    }

}
