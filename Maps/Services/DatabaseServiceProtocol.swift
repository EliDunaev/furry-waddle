//
//  DatabaseServiceProtocol.swift
//  Maps
//
//  Created by Илья Дунаев on 22.06.2022.
//

import Foundation
import RealmSwift

protocol DatabaseServiceProtocol {
    func add(models: [Object])
    func add(model: Object)
    func read(object: Object.Type) -> [Object]
    func read(object: Object.Type, filter: String) -> [Object]
    func delete(model: Object)
    func delete(object: Object.Type)
}
