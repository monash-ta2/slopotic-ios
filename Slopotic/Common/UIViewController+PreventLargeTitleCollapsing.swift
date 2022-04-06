//
//  UIViewController+PreventLargeTitleCollapsing.swift
//  Slopotic
//
//  Created by Weiyi Kong on 6/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit

extension UIViewController {
    func preventLargeTitleCollapsing() {
        let dummyView = UIView()
        view.addSubview(dummyView)
        view.sendSubviewToBack(dummyView)
    }
}
