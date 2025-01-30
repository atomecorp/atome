import CoreAudioKit
import WebKit

public class AudioUnitViewController: AUViewController, AUAudioUnitFactory, WKScriptMessageHandler, WKNavigationDelegate {
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
        console.log("JavaScript loaded successfully!");
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
        webView.navigationDelegate = self // Définir le delegate
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
            print("Message from JS console:", message.body)
        }
    }

    // Méthode pour envoyer 'hello' à la fonction JS updateTimecode
    public func sendHelloToJavaScript() {
        let jsCode = """
        if (typeof updateTimecode === 'function') {
            console.log("updateTimecode is defined, calling it with 'hello'");
            updateTimecode('hello');
        } else {
            console.error("updateTimecode is not defined!");
        }
        """
        webView.evaluateJavaScript(jsCode) { result, error in
            if let error = error {
                print("Erreur lors de l'exécution du JavaScript: \(error.localizedDescription)")
            } else {
                print("JavaScript exécuté avec succès. Résultat: \(String(describing: result))")
            }
        }
    }

    // WKNavigationDelegate: Appelé lorsque la page est complètement chargée
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Page web chargée avec succès")
        sendHelloToJavaScript() // Appeler la fonction après le chargement
    }
}