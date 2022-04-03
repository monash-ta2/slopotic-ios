//
//  PlayViewController.swift
//  Slopotic
//
//  Created by Weiyi Kong on 30/3/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit
import SnapKit

class PlayViewController: UIViewController {
    lazy var contentView = PlayView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Play"
        navigationController?.navigationBar.prefersLargeTitles = true

        configUI()
    }

    func configUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        contentView.collectionView.register(PlayCardView.self, forCellWithReuseIdentifier: "playCard")
    }
}
