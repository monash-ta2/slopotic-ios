//
//  DailyRingView.swift
//  Slopotic
//
//  Created by Weiyi Kong on 6/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit

class DailyRingView: UIView {
    lazy var ringView = RingView()
    lazy var dayOfWeek = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        ringView.innerRing.progress = 0.5
        ringView.outerRing.progress = 1.0
        ringView.ringWidth = 6
        ringView.ringSpacing = 1
        addSubview(ringView)

        dayOfWeek.text = "Sun"
        dayOfWeek.font = .systemFont(ofSize: 13, weight: .regular)
        dayOfWeek.textColor = .label
        addSubview(dayOfWeek)
    }

    func layout() {
        ringView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(ringView.snp.width)
        }

        dayOfWeek.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
