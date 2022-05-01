//
//  MultiSelectCell.swift
//  Slopotic
//
//  Created by Weiyi Kong on 29/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit

class MultiSelectCell: UITableViewCell {
    lazy var title = UILabel()
    lazy var checkbox = UIImageView()

    var itemName: String {
        title.text ?? ""
    }
    lazy var isChecked = false {
        didSet {
            checkbox.image = UIImage(systemName: isChecked ? "checkmark.circle.fill" : "checkmark.circle")
            checkbox.tintColor = isChecked ? .systemGreen : .systemGray
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

        isChecked = false
        checkbox.contentMode = .scaleAspectFit
        contentView.addSubview(checkbox)
    }

    func layout() {
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }

        checkbox.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(title.snp.height)
            make.right.equalToSuperview().offset(-16)
        }
    }
}
