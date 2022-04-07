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

    var innerStartColor: UIColor = .systemGreen {
        didSet {
            innerRing.startColor = innerStartColor
        }
    }

    var innerEndColor: UIColor = .systemPurple {
        didSet {
            innerRing.endColor = innerEndColor
        }
    }

    var outerStartColor: UIColor = .systemPurple {
        didSet {
            outerRing.startColor = outerStartColor
        }
    }

    var outerEndColor: UIColor = .systemOrange {
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
        outerRing.startColor = outerStartColor
        outerRing.endColor = outerEndColor
        addSubview(outerRing)

        innerRing.startColor = innerStartColor
        innerRing.endColor = innerEndColor
        addSubview(innerRing)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        outerRing.frame = bounds
        innerRing.frame = bounds.insetBy(dx: ringWidth + ringSpacing, dy: ringWidth + ringSpacing)
    }
}
