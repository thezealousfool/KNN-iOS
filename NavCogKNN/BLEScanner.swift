//
//  BLEScanner.swift
//  NavCogKNN
//
//  Created by Vivek Roy on 12/12/19.
//  Copyright © 2019 Vivek Roy. All rights reserved.
//

import Foundation

import Foundation
import CoreLocation
import ImageScrollView

class BLEScanner : NSObject, CLLocationManagerDelegate, ObservableObject {

    private var locationManager : CLLocationManager? = CLLocationManager()
    private let proximityUUID = UUID(uuidString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")!
    private var model : KNN? = nil
    private var map : ImageScrollView? = nil
    private var baseImg : UIImage? = nil

    override init() {
        super.init()
        locationManager?.requestWhenInUseAuthorization()
        if !CLLocationManager.isRangingAvailable() {
            locationManager = nil
        }
        locationManager?.delegate = self
    }

    func startRanging(model : KNN?, map : ImageScrollView, img : UIImage) {
        self.map = map
        self.model = model
        self.baseImg = img
        locationManager?.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: proximityUUID))
    }

    func stopRanging() {
        locationManager?.stopRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: proximityUUID))
    }
    
    func render_map(point: CGPoint) {
        if let img = baseImg {
            if let mapView = map {
                let zoom = mapView.zoomScale
                let offset = mapView.contentOffset
                mapView.display(image: img.circle(center: point, diameter: 15))
                mapView.setZoomScale(zoom, animated: false)
                mapView.setContentOffset(offset, animated: false)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager,
                         didRangeBeacons beacons: [CLBeacon],
                         in region: CLBeaconRegion) {
        if let _model = self.model {
            let pred = _model.predict(oneHot: beacons.rssiVector())

            let x = pred[0] * 25.0
            let y = pred[1] * -25.0
            let cosT = 0.999708014 // cos pi/130
            let sinT = 0.0241637452 // sin pi/130

            let imgX = x*cosT + y*sinT + 218.0
            let imgY = -x*sinT + y*cosT + 700.0
            render_map(point: CGPoint(x: imgX, y: imgY))
        }
    }
}
