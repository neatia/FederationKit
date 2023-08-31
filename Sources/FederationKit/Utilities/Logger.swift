//
//  Logger.swift
//  
//
//  Created by PEXAVC on 8/28/23.
//

import Foundation
import os

struct Logger {
    
    //New Log Format
    enum Level: Int32, CustomStringConvertible {
        case panic = 0
        case fatal = 8
        case error = 16
        case warning = 24
        case info = 32
        case verbose = 40
        case debug = 48
        case trace = 56
        
        public var description: String {
            switch self {
            case .panic:
                return "panic"
            case .fatal:
                return "fault"
            case .error:
                return "error"
            case .warning:
                return "warning"
            case .info:
                return "info"
            case .verbose:
                return "verbose"
            case .debug:
                return "debug"
            case .trace:
                return "trace"
            }
        }
    }
    
    static var currentLevel: Logger.Level = .debug
}

@inline(__always) func FederationLog(_ message: CustomStringConvertible,
                                     level: Logger.Level = .warning,
                                     file: String = #file,
                                     function: String = #function,
                                     line: Int = #line) {
    if level.rawValue <= Logger.currentLevel.rawValue {
        let fileName = (file as NSString).lastPathComponent
        print("[FederationKit] | \(level) | \(fileName):\(line) \(function) | \(message)")
    }
}
