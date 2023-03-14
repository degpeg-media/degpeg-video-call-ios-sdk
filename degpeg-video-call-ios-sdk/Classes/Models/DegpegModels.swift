//
//  DegpegModels.swift
//  degpeg-video-call-ios-sdk
//
//  Created by Vignesh S on 14/03/23.
//

import Foundation

/// Degpeg VideoCall data Model
struct DegpegVideoCallModel {
    var host: String?
    var appId: String?
    var callId: String?
    var secretKey: String?
}

/// ReceivedVideoCall
public struct ReceivedVideoCall: Codable {
    var videoCallId: String
    var contentProviderId: String
    var userId: String?
}

/// DegpegUserRole
public enum DegpegUserRole: String {
    case influencer
    case contentProvider = "content-provider"
    
    var nameSpace: String {
        switch self {
        case .influencer:
            return "/influencer"
        case .contentProvider:
            return "/content-provider"
        }
    }
    
    var socketConnectionParam: String {
        switch self {
        case .influencer:
            return "influencerId"
        case .contentProvider:
            return "contentProviderId"
        }
    }
}

/// DegpegUserDetailsProtocol
public protocol DegpegUserDetailsProtocol {
    func getDegpegUserRole() -> DegpegUserRole
    func getDegpegUserId() -> String
}

/// DegpegSocketDelegate to get new video call requests
public protocol DegpegSocketDelegate: AnyObject {
    /// Method to receive a new video call request
    /// - Parameter model: ReceivedVideoCall
    func receivedNewCallRequest(with model: ReceivedVideoCall)
}
