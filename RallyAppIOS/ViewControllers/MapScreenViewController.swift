//
//  MapScreenViewController.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-24.
//

import UIKit
import MapKit

class MapScreenViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let rallyLocation = LocationModel(
            title: "Rally Restaurant",
             locationName: "1660 O’Connor Dr., Toronto, Ontario M4A 2R4",
             discipline: "Restaurant",
             coordinate: CLLocationCoordinate2D(latitude: 43.71735, longitude: -79.30498))
        var showLocation = rallyLocation.coordinate
        showLocation.latitude =  43.71500
        mapView.centreToLocation(showLocation, regionRadius: 1000)
        mapView.addAnnotation(rallyLocation)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

private extension MKMapView{
    
    func centreToLocation(
        _ location: CLLocationCoordinate2D,
        regionRadius: CLLocationDistance = 1000
    ) {
        let cordinateRegion = MKCoordinateRegion(
            center: location,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        
        setRegion(cordinateRegion, animated: true)
    }
}

extension MapScreenViewController: MKMapViewDelegate {

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? LocationModel else {
            return nil
        }

        let identifier = "artwork"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(
                annotation: annotation,
                reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
  }
}
