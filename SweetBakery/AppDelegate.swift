import UIKit
import AppsFlyerLib
import AppTrackingTransparency

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        sweetConfigureAppsFlyer()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(sweetStartAppsFlyer),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        
        return true
    }
    
    private func sweetConfigureAppsFlyer() {
        AppsFlyerLib.shared().appsFlyerDevKey = "GMbycebmqbk7tjeRmygSpU"
        
        AppsFlyerLib.shared().appleAppID = "6757008025"
        
        AppsFlyerLib.shared().delegate = self
        
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        
        print("📱 [AppDelegate] AppsFlyer configured")
    }
    
    private static var sweetWasStarted = false
    
    @objc private func sweetStartAppsFlyer() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { [weak self] sweetStatus in
                print("📱 [AppDelegate] Tracking authorization: \(sweetStatus.rawValue)")
                self?.sweetLaunchAppsFlyer()
            }
        } else {
            sweetLaunchAppsFlyer()
        }
    }
    
    private func sweetLaunchAppsFlyer() {
        guard !Self.sweetWasStarted else { return }
        Self.sweetWasStarted = true
        
        AppsFlyerLib.shared().start()
        
        let sweetUid = AppsFlyerLib.shared().getAppsFlyerUID()
        print("📱 [AppDelegate] AppsFlyer started, UID: \(sweetUid)")
    }
}

extension AppDelegate: AppsFlyerLibDelegate {
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable: Any]) {
        print("✅ [AppDelegate] AppsFlyer conversion data received")
        
        let sweetAppsFlyerUID = AppsFlyerLib.shared().getAppsFlyerUID()
        print("🔑 [AppDelegate] AppsFlyer UID: \(sweetAppsFlyerUID), length: \(sweetAppsFlyerUID.count)")
        
        SweetFlowController.shared.sweetUpdateAppsFlyerData(
            sweetUid: sweetAppsFlyerUID,
            sweetConversionData: conversionInfo
        )
    }
    
    func onConversionDataFail(_ error: Error) {
        print("❌ [AppDelegate] AppsFlyer conversion data failed: \(error.localizedDescription)")
        
        let sweetAppsFlyerUID = AppsFlyerLib.shared().getAppsFlyerUID()
        print("🔑 [AppDelegate] AppsFlyer UID (fallback): \(sweetAppsFlyerUID), length: \(sweetAppsFlyerUID.count)")
        
        if !sweetAppsFlyerUID.isEmpty {
            SweetFlowController.shared.sweetUpdateAppsFlyerData(sweetUid: sweetAppsFlyerUID, sweetConversionData: [:])
        }
    }
}
