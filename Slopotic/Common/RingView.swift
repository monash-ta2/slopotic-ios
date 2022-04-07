//
//  RingView.swift
//  Slopotic
//
//  Created by Weiyi Kong on 5/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit
import MKRingProgressView

class RingView: UIView {
    let outerRing = RingProgressView()
    let innerRing = RingProgressView()

    var innerStartColor: UIColor = .red {
        didSet {
            innerRing.startColor = innerStartColor
        }
    }

    var innerEndColor: UIColor = .blue {
        didSet {
            innerRing.endColor = innerEndColor
        }
    }

    var outerStartColor: UIColor = .red {
        didSet {
            outerRing.startColor = outerStartColor
        }
    }

    var outerEndColor: UIColor = .blue {
        didSet {
            outerRing.endColor = outerEndColor
        }
    }

    var ringWidth: CGFloat = 20 {
        didSet {
            innerRing.ringWidth = ringWidth
            outerRing.ringWidth = ringWidth
            setNeedsLayout()
        }
    }

    var ringSpacing: CGFloat = 2 {
        didSet {
            setNeedsLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(outerRing)
        addSubview(innerRing)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        outerRing.frame = bounds
        innerRing.frame = bounds.insetBy(dx: ringWidth + ringSpacing, dy: ringWidth + ringSpacing)
    }
}
