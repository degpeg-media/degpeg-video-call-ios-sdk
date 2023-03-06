//
//  String+Extension.swift
//  degpeg-video-call-ios-sdk
//
//  Created by Vignesh S on 04/03/23.
//

import Foundation
extension String {
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
