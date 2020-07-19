//
//  RestuarantAnnotationView.swift
//  EatUpAll
//
//  Created by delma on 2020/07/19.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit
import MapKit

final class RestaurantAnnotationView: MKAnnotationView {
    let restaurantTitleLabel = RestaurantAnnotationLabel()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        addSubview(restaurantTitleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        restaurantTitleLabel.text = nil
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        guard let annotation = annotation as? RestaurantAnnotation else { return }
        restaurantTitleLabel.text = annotation.restaurant.name
        setNeedsLayout()
    }
}
