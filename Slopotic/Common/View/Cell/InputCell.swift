//
//  InputCell.swift
//  Slopotic
//
//  Created by Weiyi Kong on 7/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit

class InputCell: UITableViewCell {
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
        title.text = ""
        title.font = .systemFont(ofSize: 17, weight: .regular)
        title.setContentHuggingPriority(.required, for: .horizontal)
        title.setContentCompressionResistancePriority(.required, for: .horizontal)
        contentView.addSubview(title)
        
        input.placeholder = "0"
        input.textAlignment = .right
        input.font = .preferredFont(forTextStyle: .body, compatibleWith: nil)
        input.keyboardType = .decimalPad
        contentView.addSubview(input)

        selectionStyle = .none
    }

    func layout() {
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        input.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(title.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
        }
    }
}
