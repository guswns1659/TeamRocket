//
//  RestaurantAnnotation.swift
//  EatUpAll
//
//  Created by delma on 2020/07/19.
//  Copyright © 2020 team rocket. All rights reserved.
//

import MapKit

final class RestaurantAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    var restaurant: Restaurant
    
    init(coordinate: CLLocationCoordinate2D, restaurant: Restaurant) {
        self.coordinate = coordinate
        self.restaurant = restaurant
        super.init()
    }
}
