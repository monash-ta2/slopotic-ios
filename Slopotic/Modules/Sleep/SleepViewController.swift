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

    lazy var raterCell: SleepRaterCell = {
        let rater = SleepRaterCell()
        rater.delegate = self
        return rater
    }()
    lazy var quality = SleepRaterCell.Choice.good.rawValue

    lazy var hoursCell: InputCell = {
        let cell = InputCell()
        cell.title.text = "Sleep Hours"
        return cell
    }()
    var hours: String {
        get {
            hoursCell.input.text ?? "0"
        }
    }

    lazy var habits = ["Read a Book", "Watch TV", "Adjust Heat", "Use Social Media", "Take a Warm Bath"]
    lazy var habitCells: [MultiSelectCell] = habits.map { text in
        let cell = MultiSelectCell()
        cell.title.text = text
        return cell
    }

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

    func configTextField() {
        hoursCell.input.delegate = self
    }

    func saveRecord() {
//        saveButton.onTap { [weak self] _ in
//            let countOfTablets = Double(self!.tablets) ?? 0
//
//            if self?.tablets.range(of: "^\\d*(\\.\\d{0,2})?$", options: .regularExpression) == nil {
//                let alert = UIAlertController(title: "Check Tablet Count", message: "Please ensure your tablet count is valid.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
//                self?.present(alert, animated: true)
//                return
//            }
//
//            let sleepRecord = DailySleepRecord(date: Date.now, quality: self!.sleepQuality, tablets: countOfTablets)
//            DBManager.shared.insertOrUpdateSleep(record: sleepRecord)
//        }
    }
}

extension SleepViewController: SleepRaterCellDelegate {
    func sleepRaterCell(didChoose choice: SleepRaterCell.Choice) {
        quality = choice.rawValue
    }
}

extension SleepViewController: UITextFieldDelegate {
}

extension SleepViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { 4 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 3:
            return 1
        case 2:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return raterCell
        case 1:
            return hoursCell
        case 2:
            return habitCells[indexPath.row]
        case 3:
            return saveButton
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Sleep Quality"
        case 2:
            return "Habit"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            habitCells[indexPath.row].isChecked.toggle()
        case 3:
            saveRecord()
        default:
            break
        }

        tableView.deselectRow(at: indexPath, animated: false)
    }
}
