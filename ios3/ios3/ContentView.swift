import SwiftUI

struct ContentView: View {
    @State private var backgroundColor: Color = .white
    @State private var showAlert: Bool = false

    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
                .onShake {
                    showAlert = true
                }
            
            Text("Shake the device to change background color!")
                .foregroundColor(.black)
                .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Change Background"),
                message: Text("Do you want to change the background color?"),
                primaryButton: .default(Text("Yes")) {
                    backgroundColor = Color.random
                },
                secondaryButton: .cancel {
                    print("Shake gesture detected but action canceled.")
                }
            )
        }
    }
}

extension Color {
    /// Generuje losowy kolor.
    static var random: Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}
