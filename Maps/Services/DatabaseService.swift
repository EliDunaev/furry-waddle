//
//  DatabaseService.swift
//  Maps
//
//  Created by Илья Дунаев on 22.06.2022.
//

import Foundation
import RealmSwift

class DatabaseService: DatabaseServiceProtocol {
    
    let config = Realm.Configuration(schemaVersion: 2)
    lazy var realm = try! Realm(configuration: config)
    
    func add(models: [Object]) {
        do {
            self.realm.beginWrite()
            self.realm.add(models, update: .modified)
            try self.realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func add(model: Object) {
        do {
            self.realm.beginWrite()
            self.realm.add(model, update: .modified)
            try self.realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read(object: Object.Type) -> [Object] {
        let model = self.realm.objects(object)
        
        return Array(model)
    }
    
    func read(object: Object.Type, filter: String) -> [Object] {
        let model = realm.objects(object).filter(filter)
        
        return Array(model)
    }
    
    func delete(model: Object) {
        do {
            self.realm.beginWrite()
            self.realm.delete(model)
            try self.realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(object: Object.Type) {
        let model = self.realm.objects(object)
        
        do {
            self.realm.beginWrite()
            self.realm.delete(model)
            try self.realm.commitWrite()
            print(realm.configuration.fileURL as Any)
        } catch {
            print(error.localizedDescription)
        }
    }
}
