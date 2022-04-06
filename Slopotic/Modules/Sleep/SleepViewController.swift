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
    lazy var isViewAppeared = false

    lazy var raterCell: SleepRaterCell = {
        let rater = SleepRaterCell()
        rater.delegate = self
        return rater
    }()
    lazy var sleepQuality = SleepRaterCell.Choice.good

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sleep"
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        preventLargeTitleCollapsing()
        configUI()
    }

    func configUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }

        configTableView()
    }

    func configTableView() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        isViewAppeared = true
    }
}

//extension SleepViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if isViewAppeared, navigationController!.navigationBar.showsLargeContentViewer, scrollView.contentOffset.y < 0 {
//            scrollView.contentOffset.y = 0
//        }
//    }
//}

extension SleepViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { 2 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return raterCell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Sleep Quality"
        case 1:
            return "Supplement Taken"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Select your sleeping quality."
        case 1:
            return "Maxinmum is 200."
        default:
            return nil
        }
    }
}

extension SleepViewController: SleepRaterCellDelegate {
    func sleepRaterCell(didChoose choice: SleepRaterCell.Choice) {
        sleepQuality = choice
    }
}
