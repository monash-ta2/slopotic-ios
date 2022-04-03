//
//  PlayCardView.swift
//  Slopotic
//
//  Created by Weiyi Kong on 3/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit
import SnapKit

class PlayCardView: UICollectionViewCell {
    let cardHeight: CGFloat = 112
    let horizontalPadding: CGFloat = 16
    let verticalPadding: CGFloat = 12

    lazy var image = UIImageView()
    lazy var title = UILabel()

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
        image.contentMode = .scaleAspectFill
        contentView.addSubview(image)

        title.font = .systemFont(ofSize: 20, weight: .semibold)
        title.textColor = .white
        contentView.addSubview(title)

        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
    }
    
    func layout() {
        image.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }

        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(cardHeight)
            make.width.equalTo(UIScreen.main.bounds.size.width - CGFloat(horizontalPadding * 2))
            make.center.equalToSuperview()
        }
    }

    func update(_ model: PlaylistModel) {
        title.text = model.title
        image.image = model.image
    }
}
