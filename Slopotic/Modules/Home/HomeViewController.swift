//
//  HomeViewController.swift
//  Slopotic
//
//  Created by Weiyi Kong on 30/3/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import SnapKit
import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white

        configUI()
    }

    func configUI() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))

        view.addSubview(scrollView)

        let welCard = WelCardView(frame: CGRect(x: 16, y: 5, width: view.frame.size.width - 16*2, height: 300))
        scrollView.addSubview(welCard)

        let infoCard = InfoCardView(frame: CGRect(x: 16, y: 330, width: view.frame.size.width - 16*2, height: 470))

        scrollView.addSubview(infoCard)

        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 850)
    }
}
