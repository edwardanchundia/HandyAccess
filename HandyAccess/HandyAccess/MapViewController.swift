//
//  MapViewController.swift
//  HandyAccess
//
//  Created by Karen Fuentes on 2/17/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import UIKit
import Mapbox
import SnapKit
import CoreLocation

class MapViewController: UIViewController,  UIViewControllerTransitioningDelegate, CLLocationManagerDelegate, MGLMapViewDelegate /*UICollectionViewDelegate, UICollectionViewDataSource*/ {
    class MyCustomPointAnnotation: MGLPointAnnotation {
        var willUseImage: Bool = false
    }
    let vc = UIViewController.self
    var wheelMapLocationsArr = [WheelMapLocations]()
    var effect: UIVisualEffect!
    var annotations = [MGLAnnotation]()
    let locationManager: CLLocationManager = {
        let locMan: CLLocationManager = CLLocationManager()
        locMan.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locMan.distanceFilter = 50.0
        return locMan
    }()
    let geocoder: CLGeocoder = CLGeocoder()
    var userLatitude = Float()/* = 40.776104*/
    var userLongitude = Float() /*= -73.920822*/
    let cellIdentifier = "ButtonCell"
    var filterString = String()
    let color = ColorScheme()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        mapView.delegate = self
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = color._50
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest

        setupViewHierarchy()
        setupView()
        //showModal()
        // Remove current annotations
        annotationPointsMap()
        


        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(filterButtonBarButtonPressed))
//        let pointA = MyCustomPointAnnotation()
//        pointA.coordinate = CLLocationCoordinate2D(latitude: 40.7420, longitude: -73.9354)
//        pointA.title = "Stovepipe Wells"
//        pointA.willUseImage = true
//        
//        let myPlaces = [pointA]
//        mapView.addAnnotations(myPlaces)

    }
    
    func filterButtonBarButtonPressed() {
        let buttonViewController = MapButtonViewController()
        buttonViewController.setMapController(map1: self)
        guard let annotations = mapView.annotations else { return print("Annotations Error") }
        
        if annotations.count != 0 {
            for annotation in annotations {
                mapView.removeAnnotation(annotation)
            }
        } else {
            return
        }
        
       
        
        self.present(buttonViewController, animated: true, completion: nil)
    
       
    }
    
    func annotationPointsMap() -> [MyCustomPointAnnotation] {
        var arrOfAnnotation = [MyCustomPointAnnotation]()
        
        for location in wheelMapLocationsArr {
            let point = MyCustomPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: (location.lat) , longitude: (location.lon))
            point.title = location.name
            point.willUseImage = true
            
            arrOfAnnotation.append(point)
            mapView.addAnnotation(point)
            //mapView.setCenter(point.coordinate, zoomLevel: 13, animated: false)
            mapView.selectAnnotation(point, animated: true)
            
        }
        
        return arrOfAnnotation

    }
    
    
    public func refresh(object1: [WheelMapLocations]) {
        // Remove current annotations
        for annotation in annotations {
            self.mapView.removeAnnotation(annotation)
        }
        wheelMapLocationsArr = object1
        annotationPointsMap()
    }

    public func getmapbounds() -> MGLCoordinateBounds {
        let c = mapView.convert(CGRect(x:0, y:0, width:500, height:500), toCoordinateBoundsFrom: mapView)
        return c
    }
    
    func showModal() {
        let modalViewController = MapButtonViewController()
        //modalViewController.mapView = self
        modalViewController.modalPresentationStyle = .overCurrentContext


        modalViewController.view.backgroundColor = .clear
        present(modalViewController, animated: true, completion: nil)

//        present(modalViewController, animated: true, completion: nil)
        navigationController?.pushViewController(modalViewController, animated: true)



    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("All good!")
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("NOPE")
        case .notDetermined:
            print("IDK")
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let validLocation: CLLocation = locations.last else { return }
        let locationValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
        userLatitude =  Float(locationValue.latitude)
        userLongitude = Float(locationValue.longitude)
       
    
        let coordinateRegion = CLLocationCoordinate2D(latitude: validLocation.coordinate.latitude, longitude: validLocation.coordinate.longitude)
        mapView.setCenter(coordinateRegion, zoomLevel: 12, animated: true)
        
        let pinAnnotation: MGLPointAnnotation = MGLPointAnnotation()
        pinAnnotation.title = "Hey, Title"
        pinAnnotation.coordinate = validLocation.coordinate
        pinAnnotation.subtitle = "Wassup"
        mapView.addAnnotation(pinAnnotation)
        
        geocoder.reverseGeocodeLocation(validLocation) { (placemarks: [CLPlacemark]?, error: Error?) in
            //error handling
            if error != nil {
                dump(error!)
            }
            
            guard let validPlaceMarks: [CLPlacemark] = placemarks,
                let validPlace: CLPlacemark = validPlaceMarks.last else { return }
            print(validPlace)
        }
    }
    
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        
        if let castAnnotation = annotation as? MyCustomPointAnnotation {
            if (castAnnotation.willUseImage) {
                return nil;
            }
        }
        
        // Assign a reuse identifier to be used by both of the annotation views, taking advantage of their similarities.
        let reuseIdentifier = "reusableDotView"
        
        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = MGLAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            annotationView?.layer.cornerRadius = (annotationView?.frame.size.width)! / 2
            annotationView?.layer.borderWidth = 4.0
            annotationView?.layer.borderColor = UIColor.white.cgColor
            annotationView!.backgroundColor = UIColor(red:0.03, green:0.80, blue:0.69, alpha:1.0)
        }
        
        return annotationView
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error encountered")
        dump(error)
    }
    
    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        let newlogitude = center.longitude
        let newlatitude = center.latitude
        print("log = \(newlogitude), lat = \(newlatitude)")
        mapView.setCenter(center, animated: true)
        userLongitude = Float(newlogitude)
        userLatitude = Float(newlatitude)
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    
    
    func mapView(_ mapView: MGLMapView, leftCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        
        
        for location in wheelMapLocationsArr {
       
            if (annotation.title! == location.name) {
            // Callout height is fixed; width expands to fit its content.
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
            label.textAlignment = .right
            label.textColor = UIColor(red: 0.81, green: 0.71, blue: 0.23, alpha: 1)
            label.text = "Name: \(location.name), Type: \(location.categoryIdentifier), Latitude:\(location.lat), Longitude: \(location.lon)"
            
            return label
            }
        }
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        return UIButton(type: .detailDisclosure)
    }
    
    func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
        // Hide the callout view.
        mapView.deselectAnnotation(annotation, animated: false)
        
        UIAlertView(title: annotation.title!!, message: "A lovely (if touristy) place.", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK").show()
    }

    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        print(annotation)
        mapView.selectAnnotation(annotation, animated: true)
    }

    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ButtonCollectionViewCell
//        
//        cell.filterButton.backgroundColor = UIColor.brown
//        cell.filterButton.titleLabel?.text = "button"
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return CGSize(width: view.frame.width/5, height: 150)
//    }
    
    
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        
        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
//        mapView.addSubview(buttonCategoriesCollectionView)
    }

    func setupView() {
//        buttonCategoriesCollectionView.snp.makeConstraints({ (view) in
//            view.bottom.equalToSuperview().inset(20)
//            view.width.equalToSuperview().multipliedBy(0.8)
//            view.height.equalTo(150)
//            view.centerX.equalToSuperview()
//        })
//        buttonCategoriesCollectionView.delegate = self
//        buttonCategoriesCollectionView.dataSource = self
//        buttonCategoriesCollectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }

    internal var mapView: MGLMapView = {
        let mapView = MGLMapView()
        return mapView
    }()
    internal lazy var blur: UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffectStyle.light)
        var blurEffectView = UIVisualEffectView(effect: blur)
        return blurEffectView
    }()
//    internal lazy var buttonCategoriesCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = UIColor.black
//        return collectionView
//    }()

}
