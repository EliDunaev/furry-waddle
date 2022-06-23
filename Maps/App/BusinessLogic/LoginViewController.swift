//
//  LoginViewController.swift
//  Maps
//
//  Created by Илья Дунаев on 23.06.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let DB = DatabaseService()
    
    var onLogin: (() -> Void)?
    var onRegister: (() -> Void)?
    
    private func showLoginError() {
        let alert = UIAlertController(title: "Ошибка", message: "Логин или пароль пользователя введены неверно!", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard
            let login = loginTextField.text,
            !login.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty
        else { return }
        
        if let users = self.DB.read(object: UserModel.self, filter: "login == '\(login)'") as? [UserModel],
           let user = users.first,
           user.password == password
        {
            self.onLogin?()
        } else {
            self.showLoginError()
        }
    }
    
    @IBAction func register(_ sender: UIButton) {
        guard
            let login = loginTextField.text,
            !login.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty
        else { return }
        
        if let users = self.DB.read(object: UserModel.self, filter: "login == '\(login)'") as? [UserModel],
           let user = users.first
        {
            print("Пользователю \(user.login) будет изменен пароль")
        }
        
        let user = UserModel(login: login, password: password)
        
        self.DB.add(model: user)
        
        self.onRegister?()
    }
}
