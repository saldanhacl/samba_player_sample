import UIKit
import Flutter

protocol GoBackDelegate {
    func goBack()
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, GoBackDelegate {
    
    var navigationController: UINavigationController?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let channelName = "samba.flutter.channel/player"
        let flutterViewController : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        self.navigationController = UINavigationController(rootViewController: flutterViewController)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: flutterViewController.binaryMessenger)
        
        
        methodChannel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
            if (call.method == "openPlayer") {
                self.goToSambaPlayerViewController()
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func goToSambaPlayerViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let sambaPlayerViewController =  storyboard.instantiateViewController(withIdentifier: "SambaPlayerViewController") as? SambaPlayerViewController {
            
            sambaPlayerViewController.delegate = self
            
            self.navigationController?.pushViewController(sambaPlayerViewController, animated: true)
        }
    }
    
    //MARK: GoBackDelegate
    
    func goBack() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
