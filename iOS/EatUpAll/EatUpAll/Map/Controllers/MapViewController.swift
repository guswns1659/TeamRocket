//
//  MapViewController.swift
//  EatUpAll
//
//  Created by delma on 2020/07/19.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        registerMapAnnotationView()
        displayAnnotations()
    }
    
    private func configure() {
        
    }
    
    private func configureMapView() {
        mapView.delegate = self
    }
    
    private func registerMapAnnotationView() {
        mapView.register(RestaurantAnnotationView.self, forAnnotationViewWithReuseIdentifier: String(describing: RestaurantAnnotationView.self))
    }
    
    private func displayAnnotations() {
        let request = NearRestaurantRequest()
        request.append(name: .latitude, value: "33.24859")
        request.append(name: .longitude, value: "126.5648")
        NetworkUseCase().getResources(request: request.asURLRequest(), dataType: RestaurantContainer.self) { result in
            switch result {
            case .success(let restaurants):
                let annotations = restaurants.data.map { RestaurantAnnotation(coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude), restaurant: $0)
                }
                self.mapView.addAnnotations(annotations)
                self.centerMapOnJeJu()
                self.mapView.setNeedsLayout()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func centerMapOnJeJu() {
        let center = CLLocationCoordinate2D(latitude: 33.24859, longitude: 126.5648)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
    }
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? RestaurantAnnotation else { return nil }
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: String(describing: RestaurantAnnotationView.self), for: annotation)
        return annotationView
    }
}
