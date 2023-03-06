//
//  DegpegVideoCallViewController.swift
//  degpeg-video-call-ios-sdk
//
//  Created by Vignesh S on 04/03/23.
//

import UIKit
import WebKit
import MBProgressHUD

struct DegpegVideoCallModel {
    var host: String?
    var appId: String?
    var callId: String?
    var secretKey: String?
}

class DegpegVideoCallViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var webView: WKWebView?
    var model: DegpegVideoCallModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let webView = WKWebView(
            frame: self.view.bounds,
            configuration: getWKWebViewConfiguration())
        webView.uiDelegate = self
        self.view.addSubview(webView)
        self.webView = webView
        generateURL()
    }

    func getWKWebViewConfiguration() -> WKWebViewConfiguration {
        let userController = WKUserContentController()
        userController.add(self, name: "closeSdkMessageHandler")
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userController
        configuration.allowsInlineMediaPlayback = true
        return configuration
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }

}

extension DegpegVideoCallViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        DispatchQueue.main.async {
            if self.isModal {
                self.dismiss(animated: true)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension DegpegVideoCallViewController {
    private func generateURL() {
        guard let host = model?.host, let appId = model?.appId, let secretKey = model?.secretKey else { return }

        if let callId = model?.callId {
            loadURL(urlString: "https://admin.degpeg.com/onetoone/createcall/?host=\(host)&session=\(callId.toBase64())&publickey=\(secretKey)&appid=\(appId)")
        } else {
            loadURL(urlString: "https://admin.degpeg.com/onetoone/createcall/?host=\(host)&publickey=\(secretKey)&appid=\(appId)")
        }
    }

    private func loadURL(urlString: String) {
        let filteredURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: filteredURL ?? "") else {
            return
        }
        DispatchQueue.main.async {
            self.webView?.load(URLRequest(url: url))
            self.webView?.allowsBackForwardNavigationGestures = true
        }
    }
}
