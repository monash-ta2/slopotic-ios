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
    let cardHeight = 112
    let horizontalPadding = 16
    let verticalPadding = 12

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
        contentView.addSubview(image)
        contentView.addSubview(title)
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
            make.left.equalToSuperview().offset(horizontalPadding)
            make.right.equalToSuperview().offset(-horizontalPadding)
            make.top.equalToSuperview().offset(verticalPadding)
            make.bottom.equalToSuperview().offset(-verticalPadding)
        }
    }
}
