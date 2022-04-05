//
//  MineTableViewController.swift
//  Slopotic
//
//  Created by Mac on 2022/4/5.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit

class MineTableViewController: UITableViewController {
    let sectionMe = 0
    let sectionMore = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == sectionMe {
            switch indexPath.row {
            case 0:
                navigationController?.pushViewController(UIViewController(), animated: true)
            case 1:
                navigationController?.pushViewController(UIViewController(), animated: true)
            default:
                return
            }
        } else {
            switch indexPath.row {
            case 0:
                navigationController?.pushViewController(UIViewController(), animated: true)
            case 1:
                navigationController?.pushViewController(UIViewController(), animated: true)
            case 2:
                navigationController?.pushViewController(UIViewController(), animated: true)
            default:
                return
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
