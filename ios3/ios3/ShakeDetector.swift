import SwiftUI
import UIKit

/// `ShakeDetector` - Modyfikator widoku obsługujący gest potrząśnięcia.
struct ShakeDetector: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

extension View {
    /// Dodaje obsługę gestu potrząśnięcia do dowolnego widoku.
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(ShakeDetector(action: action))
    }
}

extension UIDevice {
    /// Powiadomienie niestandardowe dla gestu potrząśnięcia.
    static let deviceDidShakeNotification = Notification.Name("deviceDidShakeNotification")
}

extension UIWindow {
    /// Przechwytuje zdarzenie potrząśnięcia i wysyła powiadomienie.
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
    }
}
