//
//  WeeklyRingView.swift
//  Slopotic
//
//  Created by Weiyi Kong on 5/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit
import MKRingProgressView

class WeeklyRingView: UIStackView {
    lazy var dailyViews = (0...6).map { _ in DailyRingView() }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        for (index, daily) in dailyViews.enumerated() {
            daily.dayOfWeek.text = Date.now.addingTimeInterval(TimeInterval(-86400 * index)).dayOfWeek()
            addArrangedSubview(daily)
        }

        axis = .horizontal
        alignment = .center
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 10, left: 18, bottom: 8, right: 18)
    }

    func layout() {
        for daily in dailyViews {
            daily.snp.makeConstraints { make in
                make.width.equalTo(40)
                make.height.equalTo(64)
            }
        }
    }

    func update(today model: DailySleepRecord) {
        dailyViews[6].update(model: model)
    }

    func update(latestEarlist models: [DailySleepRecord]) {
        for (index, model) in  models.enumerated() {
            if index > 6 { return }
            dailyViews[6 - index].update(model: model)
        }
    }
}
