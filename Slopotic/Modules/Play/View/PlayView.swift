//
//  PlayView.swift
//  Slopotic
//
//  Created by Weiyi Kong on 3/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit
import SnapKit

class PlayView: UIView {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

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
        collectionView.alwaysBounceVertical = true
        addSubview(collectionView)
    }
    
    func layout() {
        collectionView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}
