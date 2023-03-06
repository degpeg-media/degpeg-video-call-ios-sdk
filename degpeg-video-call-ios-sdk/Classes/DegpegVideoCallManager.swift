//
//  DegpegVideoCallManager.swift
//  degpeg-video-call-ios-sdk
//
//  Created by Vignesh S on 04/03/23.
//

import Foundation

public class DegpegViewManager {

    public static func getVideoCallViewController(
        host: String,
        appId: String,
        secretKey: String) -> UIViewController {

        let vc = DegpegVideoCallViewController()
        vc.model = DegpegVideoCallModel(
            host: host,
            appId: appId,
            secretKey: secretKey)
        return vc
    }

}
