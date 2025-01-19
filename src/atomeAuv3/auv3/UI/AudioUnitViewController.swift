import CoreAudioKit
import WebKit

public class AudioUnitViewController: AUViewController, AUAudioUnitFactory {
    var audioUnit: AUAudioUnit?
    var webView: WKWebView!

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Créez le WKWebView directement
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
        
        // Chargez le fichier HTML
        if let myProjectBundle = Bundle.main.url(forResource: "src/index", withExtension: "html") {
            webView.loadFileURL(myProjectBundle, allowingReadAccessTo: myProjectBundle)
        }
    }
    
    public func createAudioUnit(with componentDescription: AudioComponentDescription) throws -> AUAudioUnit {
        audioUnit = try webviewauv3AudioUnit(componentDescription: componentDescription, options: [])
        
        return audioUnit!
    }
}
