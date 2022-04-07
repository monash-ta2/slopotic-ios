//
//  SleepRaterCell.swift
//  Slopotic
//
//  Created by Weiyi Kong on 6/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit
import Smile
import GestureRecognizerClosures

class SleepRaterCell: UITableViewCell {
    enum Choice: Int {
        case bad = 0
        case good = 1
    }

    enum Position {
        case left
        case right
    }

    lazy var badColor = UIColor.systemIndigo
    lazy var goodColor = UIColor.systemOrange
    lazy var unselectedColor = UIColor.systemGray3

    lazy var badChoice = setupChoice(backgroundColor: unselectedColor, emoji: "persevere", text: "Bad", position: .left)
    lazy var goodChoice = setupChoice(backgroundColor: goodColor, emoji: "sunglasses", text: "Good", position: .right)

    var delegate: SleepRaterCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        badChoice.onTap { _ in
            self.badChoice.backgroundColor = self.badColor
            self.goodChoice.backgroundColor = self.unselectedColor
            self.delegate?.sleepRaterCell(didChoose: .bad)
        }
        contentView.addSubview(badChoice)

        goodChoice.onTap { _ in
            self.goodChoice.backgroundColor = self.goodColor
            self.badChoice.backgroundColor = self.unselectedColor
            self.delegate?.sleepRaterCell(didChoose: .good)
        }
        contentView.addSubview(goodChoice)
    }

    func setupChoice(backgroundColor: UIColor, emoji: String, text: String, position: Position) -> UIView {
        let choice = UIView()
        choice.backgroundColor = backgroundColor

        let emojiLabel = UILabel()
        emojiLabel.font = .preferredFont(forTextStyle: .body, compatibleWith: nil)
        emojiLabel.text = Smile.emoji(alias: emoji)
        choice.addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints { make in
            switch position {
            case .left:
                make.left.equalToSuperview().offset(16)
            case .right:
                make.right.equalToSuperview().offset(-16)
            }
            make.centerY.equalToSuperview()
        }

        let textLabel = UILabel()
        textLabel.font = .preferredFont(forTextStyle: .body, compatibleWith: nil)
        textLabel.text = text
        textLabel.textColor = .white
        choice.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            switch position {
            case .left:
                make.right.equalToSuperview().offset(-32)
            case .right:
                make.left.equalToSuperview().offset(32)
            }
            make.centerY.equalToSuperview()
        }

        return choice
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        badChoice.frame = CGRect(x: contentView.frame.minX, y: contentView.frame.minY, width: contentView.frame.midX, height: contentView.frame.height)
        goodChoice.frame = CGRect(x: contentView.frame.midX, y: contentView.frame.minY, width: contentView.frame.midX, height: contentView.frame.height)
    }
}

protocol SleepRaterCellDelegate {
    func sleepRaterCell(didChoose choice: SleepRaterCell.Choice)
}
