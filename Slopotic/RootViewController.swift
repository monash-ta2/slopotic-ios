//
//  RootViewController.swift
//  Slopotic
//
//  Created by Weiyi Kong on 30/3/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {
    let homeVC = HomeViewController()
    let playVC = PlayViewController()
    let sleepVC = SleepViewController()
    let reportVC = ReportViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = UIColor.systemBackground

        homeVC.tabBarItem.title = "Home"
        homeVC.tabBarItem.image = UIImage(systemName: "doc.text.image.fill")

        playVC.tabBarItem.title = "Play"
        playVC.tabBarItem.image = UIImage(systemName: "play.fill")

        sleepVC.tabBarItem.title = "Record"
        sleepVC.tabBarItem.image = UIImage(systemName: "powersleep")

        reportVC.tabBarItem.title = "Report"
        reportVC.tabBarItem.image = UIImage(systemName: "chart.bar.doc.horizontal.fill")

        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: playVC),
            UINavigationController(rootViewController: sleepVC),
            UINavigationController(rootViewController: reportVC)
        ]

        initialSetup()
    }

    func initialSetup() {
        if !UserDefaults.standard.bool(forKey: "didSetup") {
            DBManager.shared.setupSleepRecord()
            DBManager.shared.setupPlayRecord()
            UserDefaults.standard.set(true, forKey: "didSetup")
        }
    }
}
