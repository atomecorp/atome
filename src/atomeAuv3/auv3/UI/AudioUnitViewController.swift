import CoreAudioKit
import WebKit

public class AudioUnitViewController: AUViewController, AUAudioUnitFactory, WKScriptMessageHandler {
    var audioUnit: AUAudioUnit?
    var webView: WKWebView!

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Capture JS errors and rejects
        let scriptSource = """
        window.onerror = function(m, s, l, c, e) {
            var msg = "Error: " + m + " at " + s + ":" + l + ":" + c + (e && e.stack ? " stack: " + e.stack : "");
            try {
                window.webkit.messageHandlers.console.postMessage(msg);
            } catch(x) {
                console.warn("Error sending to Swift:", x);
            }
        };
        window.addEventListener("unhandledrejection", function(e) {
            var msg = "Unhandled Promise: " + e.reason + (e.reason && e.reason.stack ? " stack: " + e.reason.stack : "");
            try {
                window.webkit.messageHandlers.console.postMessage(msg);
            } catch(x) {
                console.warn("Error sending to Swift:", x);
            }
        });
        """

        // Configure WKUserContentController and add the script
        let contentController = WKUserContentController()
        let userScript = WKUserScript(source: scriptSource, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        contentController.addUserScript(userScript)
        contentController.add(self, name: "console")

        // Configure the WebView
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        config.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        config.setValue(true, forKey: "allowUniversalAccessFromFileURLs")

        // Initialize and set up the WebView
        webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        // Add constraints for Safe Areas
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Load the HTML file
        if let myProjectBundle = Bundle.main.url(forResource: "src/index", withExtension: "html") {
            webView.loadFileURL(myProjectBundle, allowingReadAccessTo: myProjectBundle)
        } else {
            print("Error: src/index.html introuvable dans le bundle")
        }
    }

    public func createAudioUnit(with componentDescription: AudioComponentDescription) throws -> AUAudioUnit {
        audioUnit = try webviewauv3AudioUnit(componentDescription: componentDescription, options: [])
        return audioUnit!
    }

    // Handle messages from the WebView
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "console" {
            print(message.body)
        }
    }
}
