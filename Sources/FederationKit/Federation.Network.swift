//
//  Federation.Network.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
import LemmyKit
import MastodonKit

extension Federation {
    var lemmy: Lemmy? {
        currentServer?.lemmy
    }
    
    var mastodon: MastodonKit.Client? {
        currentServer?.mastodon
    }
    
    var isAutomatic: Bool {
        currentServer?.type == .automatic
    }
}
