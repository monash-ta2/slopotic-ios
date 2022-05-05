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
    let mineVC: MineTableViewController = {
        let storyboard = UIStoryboard(name: "MineTableViewController", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "MineTableViewController") as! MineTableViewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = UIColor.systemBackground

        homeVC.tabBarItem.title = "Home"
        homeVC.tabBarItem.image = UIImage(systemName: "doc.text.image.fill")

        playVC.tabBarItem.title = "Play"
        playVC.tabBarItem.image = UIImage(systemName: "play.fill")

        sleepVC.tabBarItem.title = "Sleep"
        sleepVC.tabBarItem.image = UIImage(systemName: "powersleep")

        mineVC.tabBarItem.title = "Me"
        mineVC.tabBarItem.image = UIImage(systemName: "person.crop.circle.fill")

        viewControllers = [
//            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: playVC),
            UINavigationController(rootViewController: sleepVC)
//            UINavigationController(rootViewController: mineVC)
        ]

        initialSetup()
    }

    func initialSetup() {
        if !UserDefaults.standard.bool(forKey: "didSetup") {
            DBManager.shared.setupSleepRecord()
            UserDefaults.standard.set(true, forKey: "didSetup")
        }
    }
}
