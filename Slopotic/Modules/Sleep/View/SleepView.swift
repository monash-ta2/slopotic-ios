//
//  SleepView.swift
//  Slopotic
//
//  Created by Weiyi Kong on 5/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit

class SleepView: UIView {
    lazy var weeklyView = WeeklyRingView()
    lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)
    lazy var weeklySeparator = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        tableView.keyboardDismissMode = .onDrag
        addSubview(tableView)

        setupWeeklyView()
        addSubview(weeklyView)
    }

    func layout() {
        weeklyView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(80)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(weeklyView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
    }

    func setupWeeklyView() {
        // add bottom separator
        weeklySeparator.backgroundColor = .separator
        weeklyView.addSubview(weeklySeparator)

        // FIXME: config shadow
        let shadowPath = UIBezierPath(roundedRect: weeklyView.frame, cornerRadius: 0)
        let shadowLayer = CALayer()
        shadowLayer.shadowPath = shadowPath.cgPath
        shadowLayer.shadowColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 0.25).cgColor
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 8
        shadowLayer.shadowOffset = CGSize(width: 0, height: 4)
        shadowLayer.bounds = weeklyView.frame
        shadowLayer.position = weeklyView.center
        layer.addSublayer(shadowLayer)
        weeklyView.clipsToBounds = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        weeklySeparator.frame = CGRect(x: 0, y: weeklyView.frame.maxY - CGFloat(0.5), width: weeklyView.frame.width, height: 0.5)
    }
}
