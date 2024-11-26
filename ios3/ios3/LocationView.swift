import SwiftUI
import CoreLocation

struct LocationView: View {
    @State private var latitude: String = "N/A"
    @State private var longitude: String = "N/A"
    @State private var address: String = "N/A"
    private let locationManager = LocationManager()

    var body: some View {
        VStack {
            HStack {
                Text("Latitude:")
                Spacer()
                Text(latitude)
            }
            HStack {
                Text("Longitude:")
                Spacer()
                Text(longitude)
            }
            HStack {
                Text("Address:")
                Spacer()
                Text(address)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
            }
            
            Button(action: fetchLocation) {
                Text("My Current Location")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)
        }
        .padding()
    }
    
    private func fetchLocation() {
        locationManager.fetchLocation { location, error in
            if let location = location {
                latitude = String(format: "%.6f", location.coordinate.latitude)
                longitude = String(format: "%.6f", location.coordinate.longitude)
                
                locationManager.fetchAddress(from: location) { address in
                    self.address = address ?? "Unable to fetch address"
                }
            } else {
                print("Error fetching location: \(String(describing: error))")
            }
        }
    }
}
