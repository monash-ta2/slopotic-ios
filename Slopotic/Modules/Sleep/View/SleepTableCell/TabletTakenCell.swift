//
//  TabletTakenCell.swift
//  Slopotic
//
//  Created by Weiyi Kong on 7/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit

class TabletTakenCell: UITableViewCell {
    lazy var title = UILabel()
    lazy var input = UITextField()

    var value: String {
        get {
            input.text!
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        title.text = "Count of Tablet(s)"
        title.font = .preferredFont(forTextStyle: .body, compatibleWith: nil)
        contentView.addSubview(title)
        
        input.placeholder = "0"
        input.textAlignment = .right
        input.font = .preferredFont(forTextStyle: .body, compatibleWith: nil)
        contentView.addSubview(input)

        selectionStyle = .none
    }

    func layout() {
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(title.intrinsicContentSize.width)
        }
        input.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(title.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
        }
    }
}
