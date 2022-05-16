//
//  HomeViewController.swift
//  Slopotic
//
//  Created by Weiyi Kong on 30/3/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import SnapKit
import UIKit
import SafariServices

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground

        configUI()
    }

    func configUI() {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 850)
        view.addSubview(scrollView)

        let welCard = WelCardView(frame: CGRect(x: 16, y: 5, width: view.frame.size.width - 16*2, height: 300))
        scrollView.addSubview(welCard)

        let infoCard = InfoCardView(frame: CGRect(x: 16, y: 330, width: view.frame.size.width - 16*2, height: 470))
        infoCard.button.onTap { [weak self] _ in
            let web = SFSafariViewController(url: URL(string: "https://slopotic.tech/")!)
            self?.navigationController?.present(web, animated: true)
        }
        scrollView.addSubview(infoCard)
    }
}
