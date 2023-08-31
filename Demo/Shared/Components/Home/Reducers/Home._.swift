import Granite
import SwiftUI
import Foundation

extension Home {
    struct DidAppear: GraniteReducer {
        typealias Center = Home.Center
        
        
        func reduce(state: inout Center.State) {
        }
    }
    
    struct UpdateSiteView: GraniteReducer {
        typealias Center = Home.Center
        
        struct Meta: GranitePayload {
        }
        
        @Payload var meta: Meta?
        
        func reduce(state: inout Center.State) {
        }
    }
}
