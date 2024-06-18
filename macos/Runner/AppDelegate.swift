import Cocoa
import FlutterMacOS
import GoogleMaps

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationDidFinishLaunching(_ aNotification: Notification) {
    GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
    super.applicationDidFinishLaunching(aNotification)
  }

  override func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }
}
