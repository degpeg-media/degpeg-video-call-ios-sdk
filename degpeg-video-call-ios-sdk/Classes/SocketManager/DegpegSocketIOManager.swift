//
//  DegpegSocketIOManager.swift
//  degpeg-video-call-ios-sdk
//
//  Created by Vignesh S on 14/03/23.
//

import SocketIO

public class DegpegSocketIOManager {
    public static let shared = DegpegSocketIOManager()
    var socket: SocketIOClient?
    weak var delegate: DegpegSocketDelegate?
    private var socketManager: SocketManager?

    /// Method to connect Degpeg socketIO
    /// - Parameter userDetails: DegpegUserDetailsProtocol
    public func connect(with userDetails: DegpegUserDetailsProtocol, delegate: DegpegSocketDelegate) {
        disconnectSocket()
        socketManager = SocketManager(socketURL: URL(string: generateURL(to: userDetails))!,
                                      config: [.log(false), .compress, .forcePolling(false)])
        socketManager?.setConfigs([.connectParams(getConnectionParams(for: userDetails)), .forcePolling(false)])
        socket = socketManager!.socket(forNamespace: getNameSpace(with: userDetails))
        socketListeners(socket: socket!)
        self.delegate = delegate
        socket?.connect()
    }
    
    private func getNameSpace(with userDetails: DegpegUserDetailsProtocol) -> String {
        userDetails.getDegpegUserRole().nameSpace
    }
    
    private func getConnectionParams(for user: DegpegUserDetailsProtocol) -> [String: Any] {
        [user.getDegpegUserRole().socketConnectionParam : user.getDegpegUserId()]
    }

    private func generateURL(to user: DegpegUserDetailsProtocol) -> String {
        "\(ServiceURL.degpegVideoSocketIOURL)\(user.getDegpegUserRole().rawValue)"
    }
    
    /// Method to disconnect Degpeg socket
    public func disconnectSocket() {
        socket?.removeAllHandlers()
        socket?.disconnect()
    }
    
    /// Method to get socket connection status
    /// - Returns: Bool
    public func isDegpegSocketConnected() -> Bool {
        (socket?.manager?.status == .connected)
    }
    
    private func socketListeners(socket: SocketIOClient) {
        debugPrint("Listening something!!!")
        
        socket.on(clientEvent: .connect, callback: { (data, ack) in
            debugPrint("<<<<<<<<<<<< Degpeg Socket connected >>>>>>>>>>>")
        })
        
        socket.on(clientEvent: .disconnect, callback: { (data, ack) in
            debugPrint("Degpeg Socket disconnected")
        })
        
        socket.on(clientEvent: .error, callback: { (data, ack) in
            debugPrint("Degpeg Socket error: \(data)")
        })
        
        socket.on(clientEvent: .reconnect) { data, ack in
            debugPrint("Degpeg Socket reconnect")
        }
        
        socket.on(clientEvent: .statusChange) { data, ack in
            debugPrint("Degpeg Socket Status changes")
        }
        
        socket.on("video_call_created") { [weak self] data, ack in
            guard let self = self else { return }
            debugPrint("Video call received...")
            debugPrint(data)
            if let response = self.getResponseData(data: data) {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: response)
                    let newCallRequest = try JSONDecoder().decode(ReceivedVideoCall.self, from: jsonData)
                    self.delegate?.receivedNewCallRequest(with: newCallRequest)
                } catch {
                    debugPrint(error)
                }
            }
        }
    }
}

private extension DegpegSocketIOManager {
    //MARK:- Socket response data
    private func getResponseData(data: [Any]) -> [String: Any]? {
        if let result = data.first as? [String: Any] {
            return result
        }
        return nil
    }
}
