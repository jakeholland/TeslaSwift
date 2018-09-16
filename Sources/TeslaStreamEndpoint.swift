//
//  TeslaStreamEndpoint.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 22/04/2017.
//  Copyright © 2017 Joao Nunes. All rights reserved.
//

import Foundation

enum StreamEndpoint {
	
	case stream(email: String, vehicleToken: String, vehicleId: String)
}

extension StreamEndpoint {
	
	var subscribe: String {
		switch self {
		case let .stream(email, vehicleToken, vehicleId):
            return StreamSubscribe(email: email, vehicleToken: vehicleToken, vehicleId: vehicleId).jsonString!
		}
	}
    
    var baseUrl: String { return "wss://streaming.vn.teslamotors.com/" }
    
	var path: String {
		switch self {
		case let .stream(_, _, _):
			return "streaming/"
		}
	}
    
    var url: URL { return URL(string: "\(baseUrl)\(path)")!  }
}

struct StreamSubscribe: Codable {
    
    let msg_type: String = "data:subscribe"
    let tag: String
    let token: String
    let value: String = "speed,odometer,soc,elevation,est_heading,est_lat,est_lng,est_corrected_lat,est_corrected_lng,native_latitude,native_longitude,native_heading,native_type,native_location_supported,power,shift_state"
    
    init(email: String, vehicleToken: String, vehicleId: String) {
        tag = vehicleId
        
        let authString = "\(email):\(vehicleToken)"
        let authData = authString.data(using: .utf8)
        let base64String = authData!.base64EncodedString()
        token = base64String
    }
    
}
