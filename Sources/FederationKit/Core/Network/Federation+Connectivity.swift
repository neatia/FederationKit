//
//  Federation+Connectivity.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation

//MARK: Ping
public extension Federation {
    func ping(_ baseUrl: String? = nil) async -> (isUp: Bool, time: TimeInterval)? {
        guard let urlString = baseUrl ?? currentServer?.baseUrl else { return nil }
        if let url = URL(string: urlString) {
            FederationLog("Ping Test: \(url.absoluteString)", level: .debug)
            var request = URLRequest(url: url)
            request.httpMethod = "HEAD"
            
            let time = DispatchTime.now().uptimeNanoseconds
            
            let data = try? await URLSession.shared.data(for: request)
            
            let elapsed = DispatchTime.now().uptimeNanoseconds - time
            let totalTime = TimeInterval(elapsed)/1e9
            
            guard let data,
                  let response = data.1 as? HTTPURLResponse else {
                return (false, totalTime)
            }
            
            switch response.statusCode {
            case 200:
                return (true, totalTime)
            default:
                return (false, totalTime)
            }
        } else {
            return nil
        }
    }
    static func ping(_ host: String? = nil) async -> (isUp: Bool, time: CFAbsoluteTime)? {
        return await shared.ping(host)
    }
}
