//
//  UIView+Round.swift
//  Slopotic
//
//  Created by Weiyi Kong on 5/5/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit

extension UIView {
    func addRoundedCorners(corners: UIRectCorner, with radii: CGSize, rect: CGRect) {
        let rounded = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        layer.mask = shape
    }
}
