//
//  Circle.swift
//  NavCogKNN
//
//  Created by Vivek Roy on 12/13/19.
//  Copyright © 2019 Vivek Roy. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func circle(center: CGPoint, diameter: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext( self.size )
        draw(at: CGPoint.zero)
        let ctx = UIGraphicsGetCurrentContext()!
        let circleRect = CGRect(x: center.x-diameter/2, y: center.y-diameter/2, width: diameter, height: diameter)
        let color = CGColor(srgbRed: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        ctx.setStrokeColor(color)
        ctx.setFillColor(color)
        ctx.fillEllipse(in: circleRect)
        let retImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return retImg!
    }
}
