
//
//  Created by Alexandr Byzov on 28.11.2020.
//  Copyright (c) 2013 PixelCut. All rights reserved except as below:
//  This code is provided as-is, without warranty of any kind. You may use it in your projects as you wish.
//
//  https://www.paintcodeapp.com/news/code-for-ios-7-rounded-rectangles

import UIKit

extension UIBezierPath {
    
    public convenience init(ios7RoundedRect rect: CGRect, radius: CGFloat) {
        let path = UIBezierPath()
        let limit = min(rect.size.width, rect.size.height) / 2 // 1.52866483
        let limitedRadius = min(radius, limit)
        
        let topLeft: (_ x: CGFloat, _ y: CGFloat) -> CGPoint = {
            .init(x: rect.origin.x + $0 * limitedRadius, y: rect.origin.y + $1 * limitedRadius)
        }
        
        let topRight: (_ x: CGFloat, _ y: CGFloat) -> CGPoint = {
            .init(x: rect.origin.x + rect.size.width - $0 * limitedRadius, y: rect.origin.y + $1 * limitedRadius)
        }
        
        let bottomRight: (_ x: CGFloat, _ y: CGFloat) -> CGPoint = {
            .init(x: rect.origin.x + rect.size.width - $0 * limitedRadius, y: rect.origin.y + rect.size.height - $1 * limitedRadius)
        }
        
        let bottomLeft: (_ x: CGFloat, _ y: CGFloat) -> CGPoint = {
            .init(x: rect.origin.x + $0 * limitedRadius, y: rect.origin.y + rect.size.height - $1 * limitedRadius)
        }
        
        path.move(to: topLeft(1.52866483, 0.00000000))
        path.addLine(to: topRight(1.52866471, 0.00000000))
        path.addCurve(to: topRight(0.66993427, 0.06549600), controlPoint1: topRight(1.08849323, 0.00000000), controlPoint2: topRight(0.86840689, 0.00000000))
        path.addLine(to: topRight(0.63149399, 0.07491100))
        path.addCurve(to: topRight(0.07491176, 0.63149399), controlPoint1: topRight(0.37282392, 0.16905899), controlPoint2: topRight(0.16906013, 0.37282401))
        path.addCurve(to: topRight(0.00000000, 1.52866483), controlPoint1: topRight(0.00000000, 0.86840701), controlPoint2: topRight(0.00000000, 1.08849299))
        path.addLine(to: bottomRight(0.00000000, 1.52866471))
        path.addCurve(to: bottomRight(0.06549569, 0.66993493), controlPoint1: bottomRight(0.00000000, 1.08849323), controlPoint2: bottomRight(0.00000000, 0.86840689))
        path.addLine(to: bottomRight(0.07491111, 0.63149399))
        path.addCurve(to: bottomRight(0.63149399, 0.07491111), controlPoint1: bottomRight(0.16905883, 0.37282392), controlPoint2: bottomRight(0.37282392, 0.16905883))
        path.addCurve(to: bottomRight(1.52866471, 0.00000000), controlPoint1: bottomRight(0.86840689, 0.00000000), controlPoint2: bottomRight(1.08849323, 0.00000000))
        path.addLine(to: bottomLeft(1.52866483, 0.00000000))
        path.addCurve(to: bottomLeft(0.66993397, 0.06549569), controlPoint1: bottomLeft(1.08849299, 0.00000000), controlPoint2: bottomLeft(0.86840701, 0.00000000))
        path.addLine(to: bottomLeft(0.63149399, 0.07491111))
        path.addCurve(to: bottomLeft(0.07491100, 0.63149399), controlPoint1: bottomLeft(0.37282401, 0.16905883), controlPoint2: bottomLeft(0.16906001, 0.37282392))
        path.addCurve(to: bottomLeft(0.00000000, 1.52866471), controlPoint1: bottomLeft(0.00000000, 0.86840689), controlPoint2: bottomLeft(0.00000000, 1.08849323))
        path.addLine(to: topLeft(0.00000000, 1.52866483))
        path.addCurve(to: topLeft(0.06549600, 0.66993397), controlPoint1: topLeft(0.00000000, 1.08849299), controlPoint2: topLeft(0.00000000, 0.86840701))
        path.addLine(to: topLeft(0.07491100, 0.63149399))
        path.addCurve(to: topLeft(0.63149399, 0.07491100), controlPoint1: topLeft(0.16906001, 0.37282401), controlPoint2: topLeft(0.37282401, 0.16906001))
        path.addCurve(to: topLeft(1.52866483, 0.00000000), controlPoint1: topLeft(0.86840701, 0.00000000), controlPoint2: topLeft(1.08849299, 0.00000000))
        path.close()
        
        self.init(cgPath: path.cgPath)
    }
}
