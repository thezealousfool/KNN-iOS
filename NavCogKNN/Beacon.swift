//
//  Beacon.swift
//  NavCogKNN
//
//  Created by Vivek Roy on 12/12/19.
//  Copyright © 2019 Vivek Roy. All rights reserved.
//

import Foundation
import CoreLocation

extension Array where Element:CLBeacon {
    func rssiVector() -> [Int] {
        let order = [1,2,3,4,5,6,7,8,11,9,87,12,10,13,14,15,
                     16,17,18,19,20,21,41,42,43,44,45,46,47,
                     48,49,50,51,52,53,54,188,190,191,194,195,
                     196,199,200,201,202,253,89]
        var oneHot = [Int](repeating: 0, count: order.count)
        if self.count > 0 {
            self.forEach { beacon in
                let idx = order.firstIndex(of: beacon.minor.intValue)
                if (beacon.major == 65535 && idx != nil) {
                    oneHot[idx!] = -beacon.rssi
                }
            }
        }
        return oneHot
    }
}
