//
//  SleepViewController.swift
//  Slopotic
//
//  Created by Weiyi Kong on 30/3/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit
import SnapKit

class SleepViewController: UIViewController {
    lazy var contentView = SleepView()
    lazy var isViewAppeared = false

    lazy var raterCell: SleepRaterCell = {
        let rater = SleepRaterCell()
        rater.delegate = self
        return rater
    }()
    lazy var sleepQuality = SleepRaterCell.Choice.good
    lazy var tabletCell = TabletTakenCell()

    lazy var saveButton: UITableViewCell = {
        let button = UITableViewCell()
        button.backgroundColor = .link
        button.selectionStyle = .gray

        let label = UILabel()
        label.text = "Save"
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        button.addSubview(label)

        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        return button
    }()

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

extension SleepViewController: SleepRaterCellDelegate {
    func sleepRaterCell(didChoose choice: SleepRaterCell.Choice) {
        sleepQuality = choice
    }
}

extension SleepViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { 3 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return raterCell
        case 1:
            return tabletCell
        case 2:
            return saveButton
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
