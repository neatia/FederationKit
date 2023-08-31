//
//  Federation.Network.swift
//  
//
//  Created by PEXAVC on 8/30/23.
//

import Foundation
import LemmyKit

extension Federation {
    var lemmy: Lemmy? {
        currentServer?.lemmy
    }
}
