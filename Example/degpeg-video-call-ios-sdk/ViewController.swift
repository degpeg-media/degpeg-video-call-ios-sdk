//
//  ViewController.swift
//  degpeg-video-call-ios-sdk
//
//  Created by vignesh.mot@gmail.com on 03/04/2023.
//  Copyright (c) 2023 vignesh.mot@gmail.com. All rights reserved.
//

import UIKit
import degpeg_video_call_ios_sdk

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DegpegSocketIOManager.shared.connect(with: self, delegate: self)
    }

    @IBAction func actionOnCreateCall(_ sender: Any) {
        let vc = DegpegViewManager.getVideoCallViewController(
            host: "replace host",
            appId: "replace appID",
            secretKey: "replace secretKey")
        self.present(vc, animated: true)
    }
}

extension ViewController: DegpegSocketDelegate {
    func receivedNewCallRequest(with model: degpeg_video_call_ios_sdk.ReceivedVideoCall) {
        print("Received new call request....")
    }
}

extension ViewController: DegpegUserDetailsProtocol {
    func getDegpegUserRole() -> degpeg_video_call_ios_sdk.DegpegUserRole {
        .contentProvider
    }

    func getDegpegUserId() -> String {
        "user ID"
    }
}
