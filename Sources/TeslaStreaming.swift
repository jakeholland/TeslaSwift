//
//  TeslaStreaming.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 23/04/2017.
//  Copyright © 2017 Joao Nunes. All rights reserved.
//

import Foundation
import Starscream

/*
 * Streaming class takes care of the different types of data streaming from Tesla servers
 *
 */
class TeslaStreaming {
	
    private var socket: WebSocket?
	var debuggingEnabled = false
	
	func openStream(endpoint: StreamEndpoint, dataReceived: @escaping ((event: StreamEvent?, error: Error?)) -> Void) {
        let url = endpoint.url
        let socket = WebSocket(url: url)
        socket.enabledSSLCipherSuites = [TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256, TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384]
        self.socket = socket
        
        socket.onConnect = {
            logDebug("Stream open", debuggingEnabled: self.debuggingEnabled)
            socket.write(string: endpoint.subscribe)
        }

        socket.onDisconnect = { (error: Error?) in
            logDebug("Stream disconnected: \(error)", debuggingEnabled: self.debuggingEnabled)
        }

        socket.onText = { (text: String) in
            logDebug("Stream string: \(text)", debuggingEnabled: self.debuggingEnabled)
            
            let event = StreamEvent(values: text)
            DispatchQueue.main.async {
                dataReceived((event, nil))
            }
        }

        socket.onData = { (data: Data) in
            guard let string = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return }
            
            logDebug("Stream data: \(string)", debuggingEnabled: self.debuggingEnabled)
            
//            let event = StreamEvent(values: data)
//            DispatchQueue.main.async {
//                dataReceived((event, nil))
//            }
        }
        
        logDebug("Opening Stream to: \(url)", debuggingEnabled: debuggingEnabled)
        socket.connect()
	}
	
	func closeStream() {
        socket?.disconnect()
		logDebug("Stream closed", debuggingEnabled: self.debuggingEnabled)
	}

}
