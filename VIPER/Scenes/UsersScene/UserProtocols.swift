//
//  UserProtocols.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import UIKit

protocol UsersView {
    var presenter: UserPresenter? {get set}
    func updateViewWithData(with users: [User])
    func updateViewWithError(with error: String)
}

protocol UserInteractor {
    var presenter: UserPresenter? {get set}
    func getUsers ()
}

protocol UserPresenter {
    var router: AnyRouter? {get set}
    var interactor: UserInteractor? {get set}
    var view: UsersView? {get set}
    func InteractorDidFetchUsers(with result: Result<[User], Error>)
}

typealias EntryPoint = UsersView & UIViewController
protocol AnyRouter {
    var entry: EntryPoint? {get}
    static func start () -> AnyRouter
}
