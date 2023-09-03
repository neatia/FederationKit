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
    
    var usersLemmy: Lemmy? {
        servers[currentUser?.host ?? ""]?.lemmy ?? lemmy
    }
    
    func tryUsersLemmy(_ actor: String) -> Lemmy? {
        if actor.host == currentUser?.host {
            return usersLemmy
        } else {
            return lemmy
        }
    }
    
    var mastodon: MastodonKit.Client? {
        currentServer?.mastodon
    }
    
    var isAutomatic: Bool {
        currentServer?.type == .automatic
    }
}
