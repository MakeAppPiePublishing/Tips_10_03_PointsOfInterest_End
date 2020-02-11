//
//  ViewController.swift
//  10_03_PointsOfInterest_Play
// An exercise file for iOS Development Tips Weekly
// A weekly course on LinkedIn Learning for iOS developers
//  Season 10 (Q2 202) video 03
//  by Steven Lipton (C)2020, All rights reserved
// Learn more at https://linkedin-learning.pxf.io/YxZgj
//This Week:  Learn how to use the MKPointOfInterestFilter for MapKit.
//  For more code, go to http://bit.ly/AppPieGithub


import UIKit
import MapKit
class ViewController: UIViewController {
    @IBOutlet weak var pointOfInterestLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var toggleAllPOI: UIButton!
    
    /// A pointer for the point of interest selected
    var currentPointOfInterest = 0
    /// List of all values in the extension for `MKPointsCategory`.
    /// - the `rawValue` of these is actually prefixed by *MKPOICategory* and the first letter is capitalized. For example, `MKPOICategoryAirport`
    var pointsOfInterest = ["airport","amusementPark","aquarium","atm",
                            "bakery","bank","beach","brewery",
                            "cafe","campground","carRental",
                            "evCharger",
                            "fireStation","fitnessCenter","foodMarket",
                            "gasStation",
                            "hospital","hotel",
                            "laundry","library",
                            "marina","movieTheater","museum",
                            "nationalPark","nightlife",
                            "park","parking","pharmacy", "police","postOffice","publicTransport",
                            "restaurant","restroom",
                            "school","stadium","store",
                            "theater",
                            "university",
                            "winery",
                            "zoo"]
    
    
    
    let mapCoordinate = CLLocationCoordinate2DMake(41.895, -87.6242)
    let distance = 1500.0
    var showAllPOI = true
    
    func showPointOfInterest(){
        let poiString = pointsOfInterest[currentPointOfInterest].capitalized
        pointOfInterestLabel.text = "#\(currentPointOfInterest): Point Of Interest: " + poiString
        let poiCategory = MKPointOfInterestCategory(rawValue: "MKPOICategory" + poiString)
        mapView.pointOfInterestFilter = MKPointOfInterestFilter(including: [poiCategory])
        
    }
    
    
    //rotate through the points of interest
    @IBAction func increasePointOfinterest(_ sender: UIButton) {
        currentPointOfInterest = (currentPointOfInterest + 1) % pointsOfInterest.count
        showPointOfInterest()
    }
    
    
    @IBAction func decreasePOI(_ sender: Any) {
        currentPointOfInterest -= 1
        if currentPointOfInterest < 0{
            currentPointOfInterest = pointsOfInterest.count - 1
        }
        showPointOfInterest()
    }
    
    @IBAction func toggleAllPOI(_ sender: UIButton) {
        showAllPOI.toggle()
        // update labels and buttons
        let poiText = showAllPOI ? "All" : "No"
        pointOfInterestLabel.text = poiText + " points of interest"
        sender.setTitle(poiText, for: .normal)
        
        //update map
        //mapView.showsPointsOfInterest = showAllPOI
        mapView.pointOfInterestFilter = showAllPOI ? MKPointOfInterestFilter.includingAll : MKPointOfInterestFilter.excludingAll
    }
    
    
    func configureMapView(){
        let region = MKCoordinateRegion(center: mapCoordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.region = region
        mapView.camera.centerCoordinate = mapCoordinate
        mapView.camera.altitude = distance
        mapView.pointOfInterestFilter = MKPointOfInterestFilter(including: [.cafe,.restaurant])
        mapView.pointOfInterestFilter = MKPointOfInterestFilter(excluding: [.store])
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        // Do any additional setup after loading the view.
    }
    
    
}

