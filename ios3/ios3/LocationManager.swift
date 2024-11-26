import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var locationCallback: ((CLLocation?, Error?) -> Void)?

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }

    func fetchLocation(completion: @escaping (CLLocation?, Error?) -> Void) {
        locationCallback = completion
        manager.requestLocation()
    }

    func fetchAddress(from location: CLLocation, completion: @escaping (String?) -> Void) {
        geocoder.reverseGeocodeLocation(location) { placemarks, _ in
            completion(placemarks?.first?.name)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationCallback?(locations.first, nil)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationCallback?(nil, error)
    }
}
