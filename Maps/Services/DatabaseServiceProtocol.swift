//
//  DatabaseServiceProtocol.swift
//  Maps
//
//  Created by Илья Дунаев on 22.06.2022.
//

import Foundation
import RealmSwift

protocol DatabaseServiceProtocol {
    func add(locations: [Object])
    func read(locationsObject: Object.Type) -> [Object]
    func read(locationsObject: Object.Type, filter: String) -> [Object]
    func delete(locations: Object)
    func delete(locationsObject: Object.Type)
}
