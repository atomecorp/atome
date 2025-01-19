//
//  atome.swift
//  webview
//
//  Created by jeezs on 25/10/2024.
//

//import CoreAudioKit
//import UIKit
import SwiftUI
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let myProjectBundle:Bundle = Bundle.main
        let myUrl = myProjectBundle.url(forResource: "serc/index", withExtension: "html")!
                webView.loadFileURL(myUrl,allowingReadAccessTo: myUrl)
    }


}


struct MainView: View {
    var body: some View {
        WebView()
            .edgesIgnoringSafeArea(.all) // Pour que la WebView occupe tout l'écran
    }
}

struct WebView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        // Charger le fichier local HTML
        if let myProjectBundle = Bundle.main.url(forResource: "src/index", withExtension: "html") {
            webView.loadFileURL(myProjectBundle, allowingReadAccessTo: myProjectBundle)
        }
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Pas besoin d'implémenter updateUIView pour un fichier HTML statique
    }
}

#Preview {
    MainView()
}


