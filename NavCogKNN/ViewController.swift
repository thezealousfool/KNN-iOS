//
//  ViewController.swift
//  NavCogKNN
//
//  Created by Vivek Roy on 12/12/19.
//  Copyright © 2019 Vivek Roy. All rights reserved.
//

import UIKit
import ImageScrollView

class ViewController: UIViewController {
    
    private let scanner = BLEScanner()
    private var knn : KNN? = nil
    @IBOutlet weak var imageView: ImageScrollView!
    private var mapImg : UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.setup()
        mapImg = UIImage(named: "nsh2ndf")
        imageView.display(image: mapImg!)
        imageView.imageContentMode = .aspectFill

        if let path = Bundle.main.path(forResource: "knn", ofType: "txt") {
            do {
                let dataString = try String(contentsOfFile: path)
                let dataStrings = dataString.components(separatedBy: .newlines)
                var data : [ [Int] : [Double] ] = [:]
                dataStrings.forEach { str in
                    if (str != "") {
                        let split = str.components(separatedBy: ":")
                        var key = split[0].components(separatedBy: ",")
                        let value = split[1].components(separatedBy: ",")
                        key.removeLast(1)
                        data[key.map{ Int($0)! }] = value.map{ Double($0)! }
                    }
                }
                knn = KNN(data: data)
            } catch {
                print(error)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // startScanning
        scanner.startRanging(model: knn, map: imageView, img: mapImg!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // stopScanning
        scanner.stopRanging()
    }
}

