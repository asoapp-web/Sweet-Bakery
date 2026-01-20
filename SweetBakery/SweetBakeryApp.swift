import SwiftUI

@main
struct SweetBakeryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @AppStorage("seenOnboarding") var seenOnboarding: Bool = false
    
    var body: some Scene {
        WindowGroup {
            SweetAppContentView()
        }
    }
}

struct SweetAppContentView: View {
    @ObservedObject private var sweetFlowController = SweetFlowController.shared
    @AppStorage("seenOnboarding") var seenOnboarding: Bool = false
    
    var body: some View {
        ZStack {
            sweetContentView
                .opacity(sweetFlowController.sweetIsLoading ? 0 : 1)
            
            if sweetFlowController.sweetIsLoading {
                SweetLoadingView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: sweetFlowController.sweetIsLoading)
    }
    
    @ViewBuilder
    private var sweetContentView: some View {
        switch sweetFlowController.sweetDisplayMode {
        case .preparing:
            NavigationView {
                if seenOnboarding {
                    ContentView()
                } else {
                    Onboarding()
                }
            }
        case .original:
            NavigationView {
                if seenOnboarding {
                    ContentView()
                } else {
                    Onboarding()
                }
            }
        case .webContent:
            SweetDisplayView()
        }
    }
}
