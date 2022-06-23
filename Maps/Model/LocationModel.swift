//
//  LocationModel.swift
//  Maps
//
//  Created by Илья Дунаев on 21.06.2022.
//

import Foundation
import RealmSwift
import CoreLocation

class LocationModel: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var latitude: Double = 0.00
    @objc dynamic var longitude: Double = 0.00
    
    override static func primaryKey() -> String? {
        return "id"
    }

    convenience required init(data: CLLocationCoordinate2D) {
        self.init()

        self.latitude = data.latitude
        self.longitude = data.longitude
    }
}
