import SwiftUI

struct GestureView: View {
    @State private var gestureMessage: String = "Perform a gesture"
    
    var body: some View {
        VStack {
            Text(gestureMessage)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .gesture(
            TapGesture(count: 3)
                .onEnded {
                    gestureMessage = "Triple Tap Gesture Detected"
                }
        )
        .gesture(
            LongPressGesture(minimumDuration: 2)
                .onEnded { _ in
                    gestureMessage = "Long Press Gesture Detected"
                }
        )
        .gesture(
            DragGesture(minimumDistance: 50)
                .onEnded { _ in
                    gestureMessage = "Swipe Gesture Detected"
                }
        )
        .gesture(
            MagnificationGesture()
                .onEnded { _ in
                    gestureMessage = "Pinch Gesture Detected"
                }
        )
        .padding()
    }
}
