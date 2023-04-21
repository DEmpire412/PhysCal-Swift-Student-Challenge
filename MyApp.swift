import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(Color(UIColor(named: "BackgroundColor")!))
        }
    }
}

extension Binding where Value == String {
    func blockingNumbersAndPunctuation() -> Binding<String> {
        return Binding(get: { self.wrappedValue }, set: {
            let filtered = $0.filter { "0123456789.-".contains($0) }
            if filtered != $0 {
                self.wrappedValue = filtered
            } else {
                self.wrappedValue = $0
            }
        })
    }
}
