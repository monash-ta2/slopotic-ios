//
//  SleepViewController.swift
//  Slopotic
//
//  Created by Weiyi Kong on 30/3/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit

class SleepViewController: UIViewController {
    lazy var contentView = SleepView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sleep"
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        configUI()
    }

    func configUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
}
