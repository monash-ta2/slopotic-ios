//
//  ReportCell.swift
//  Slopotic
//
//  Created by Weiyi Kong on 14/5/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit
import AAInfographics

class ReportCell: UITableViewCell {
    lazy var chart = AAChartView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        chart.scrollEnabled = false
        contentView.addSubview(chart)

        selectionStyle = .none
    }

    func layout() {
        chart.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(200)
        }
    }
}
