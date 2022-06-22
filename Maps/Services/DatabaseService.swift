//
//  DatabaseService.swift
//  Maps
//
//  Created by Илья Дунаев on 22.06.2022.
//

import Foundation
import RealmSwift

class DatabaseService: DatabaseServiceProtocol {
    
    let config = Realm.Configuration(schemaVersion: 1)
    lazy var realm = try! Realm(configuration: config)
    
    func add(locations: [Object]) {
        do {
            self.realm.beginWrite()
            self.realm.add(locations, update: .modified)
            try self.realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read(locationsObject: Object.Type) -> [Object] {
        let locations = self.realm.objects(locationsObject)
        
        return Array(locations)
    }
    
    func read(locationsObject: Object.Type, filter: String) -> [Object] {
        let locations = realm.objects(locationsObject).filter(filter)
        
        return Array(locations)
    }
    
    func delete(locations: Object) {
        do {
            self.realm.beginWrite()
            self.realm.delete(locations)
            try self.realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(locationsObject: Object.Type) {
        let locations = self.realm.objects(locationsObject)
        
        do {
            self.realm.beginWrite()
            self.realm.delete(locations)
            try self.realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error.localizedDescription)
        }
    }
}
