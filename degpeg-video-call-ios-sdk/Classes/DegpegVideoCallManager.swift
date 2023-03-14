//
//  DegpegVideoCallManager.swift
//  degpeg-video-call-ios-sdk
//
//  Created by Vignesh S on 04/03/23.
//

import Foundation

public class DegpegViewManager {

    /// Method to initiate DegpegVideoCallViewController
    /// - Parameters:
    ///   - host: Denotes Host ID
    ///   - appId: Denotes AppID
    ///   - secretKey: Denotes app  secretKey
    ///   - callId: Denotes call ID
    /// - Returns: UIViewController
    public static func getVideoCallViewController(
        host: String,
        appId: String,
        secretKey: String,
        callId: String? = nil) -> UIViewController {

        let vc = DegpegVideoCallViewController()
        vc.model = DegpegVideoCallModel(
            host: host,
            appId: appId,
            callId: callId,
            secretKey: secretKey)
        return vc
    }

}
