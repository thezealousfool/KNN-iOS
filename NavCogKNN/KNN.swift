//
//  KNN.swift
//  NavCogKNN
//
//  Created by Vivek Roy on 12/12/19.
//  Copyright © 2019 Vivek Roy. All rights reserved.
//

import Foundation

class KNN {
    let data : [ [Int] : [Double] ]
    
    init (data : [ [Int] : [Double] ]) {
        self.data = data
    }
    
    static func getDistance( oneHot1 : [Int], oneHot2: [Int] ) -> Double {
        return sqrt(zip(oneHot1, oneHot2).map { y in
            pow(Double(abs(y.1-y.0)), 2.0)
        }.reduce(0, { (s, x) in s+x }))
    }
    
    func predict(oneHot : [Int], k : Int = 5) -> [Double] {
        let topK = Array(data.map { (key, value) in
            [ KNN.getDistance(oneHot1: oneHot, oneHot2: key), value[0], value[1] ]
            }.sorted { (d1, d2) in d2[0] > d1[0] }.prefix(k))
        print(topK)
        let sumDistTmp = topK.reduce(0) { (r, dist) in r + dist[0] }
        print(sumDistTmp)
        let sumDist = sumDistTmp > 0 ? sumDistTmp : 1.0
        print(sumDist)
        let topKCorrected = sumDistTmp > 0 ? topK : topK.map({ [1.0, $0[1], $0[2]] })
        print(topKCorrected)
        let prediction = topKCorrected.map({
            [ $0[1]*$0[0]/sumDist, $0[2]*$0[0]/sumDist ]
        }).reduce([0.0, 0.0]) { sum, element in
            [ sum[0]+element[0], sum[1]+element[1] ]
        }
        print(prediction)
        return prediction
    }
}
