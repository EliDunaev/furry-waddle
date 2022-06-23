//
//  UserModel.swift
//  Maps
//
//  Created by Илья Дунаев on 23.06.2022.
//

import Foundation
import RealmSwift

class UserModel: Object {
    
    @objc dynamic var login: String = ""
    @objc dynamic var password: String = ""
    
    override static func primaryKey() -> String? {
        return "login"
    }

    convenience required init(login: String, password: String) {
        self.init()

        self.login = login
        self.password = password
    }
}
