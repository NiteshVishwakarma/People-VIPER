//
//  Utils.swift
//  People
//
//  Created by Nitesh Vishwakarma on 14/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class Utils {
    
    /// Shared Instance
    public static func shared() -> Utils {
      return sharedManager
    }
    
    private static var sharedManager: Utils = {
      let manager = Utils()
      return manager
    }()
    
    
    /// Helps to convet Data to Array of dictionary
    /// - Parameter data: Pass API Data object
    /// - Returns: Array of dictionary.
    func toDictionary(data: Data) -> [[String: Any]]? {
        do {
            guard let dataStr = String(data: data, encoding: .utf8) else {
                return nil
            }
            if let json = try JSONSerialization.jsonObject(with: Data(dataStr.utf8), options: []) as? [[String: Any]] {
                return json
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return nil
    }
    
    /// Sets same color to multiple UILabels.
    /// - Parameter labels: Provide array of UILabels.
    /// - Parameter color: Provide one color to apply on all labels.
    func colorLabels(labels: [UILabel], color: UIColor) {
        for i in labels {
            i.textColor = color
        }
    }
    
    /// Checks whether network is reachable.
    /// - Returns: True if reachable else false.
    func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
    
}
