//
//  ReportViewController.swift
//  Slopotic
//
//  Created by Weiyi Kong on 14/5/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import UIKit
import AAInfographics
import GRDB

class ReportViewController: UIViewController {
    lazy var contentView = SleepView()

    lazy var habitCell = ReportCell()
    lazy var habitChartModel = AAChartModel()
    lazy var hoursCell = ReportCell()
    lazy var hoursChartModel = AAChartModel()

    lazy var observation = [DatabaseCancellable]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Report"
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        configUI()

        updateChartsModel()
        habitCell.chart.aa_drawChartWithChartModel(habitChartModel)
        hoursCell.chart.aa_drawChartWithChartModel(hoursChartModel)

        DBManager.shared.delegates.append(self)
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
        contentView.tableView.dataSource = self
    }

    func updateChartsModel() {
        let lastMonthRecords = DBManager.shared.selectLastMonthSleep()
        var counter = [String: Int]()
        var playCounter = 0
        for record in lastMonthRecords {
            if record.quality == 1 {
                for habit in record.habits {
                    if let o = counter[habit] {
                        counter[habit] = o + 1
                    } else {
                        counter[habit] = 1
                    }
                }
                if DBManager.shared.selectPlay(date: record.date) {
                    playCounter += 1
                }
            }
        }
        let sorted = counter.sorted(by: { $0.value > $1.value })
        let top = [sorted[safe: 0], sorted[safe: 1]].compactMap({ $0 })
        var topHabits = top.map({ $0.key })
        topHabits.append("Play Music")
        var topHabitsCount = top.map({ $0.value })
        topHabitsCount.append(playCounter)
        habitChartModel = AAChartModel()
            .chartType(.bar)
            .animationType(.easeOutExpo)
            .legendEnabled(false)
            .tooltipEnabled(false)
            .touchEventEnabled(false)
            .dataLabelsEnabled(true)
            .xAxisLabelsEnabled(true)
            .colorsTheme(["#007AFF"])
            .title("Top 3 Sleep Habits Work for You")
            .categories(topHabits)
            .series([
                AASeriesElement()
                    .borderRadiusTopLeft(4)
                    .borderRadiusTopRight(4)
                    .data(topHabitsCount)
            ])

        var averageHours = [String: Double]()
        let habits = ["Play Music",
                      SleepHabit.tv.rawValue,
                      SleepHabit.sns.rawValue,
                      SleepHabit.bath.rawValue,
                      SleepHabit.book.rawValue,
                      SleepHabit.heat.rawValue]
        for habit in habits {
            var dayCount: Double = 0
            var totalHours: Double = 0
            if habit == "Play Music" {
                let playedDates = DBManager.shared.selectLastMonthPlay()
                print(playedDates)
                for record in lastMonthRecords {
                    if playedDates.contains(record.date) {
                        dayCount += 1
                        totalHours += Double(record.hours)
                    }
                }
            } else {
                for record in lastMonthRecords {
                    if record.habits.contains(habit) {
                        dayCount += 1
                        totalHours += Double(record.hours)
                    }
                }
            }
            averageHours[habit] = dayCount == 0 ? 0 : Double(round(100 * (totalHours / dayCount)) / 100)
        }
        print(averageHours)
        hoursChartModel = AAChartModel()
            .chartType(.bar)
            .animationType(.easeOutExpo)
            .legendEnabled(false)
            .tooltipEnabled(false)
            .touchEventEnabled(false)
            .dataLabelsEnabled(true)
            .xAxisLabelsEnabled(true)
            .colorsTheme(["#FF9500"])
            .title("Average Sleeping Hours")
            .categories(averageHours.map({ $0.key }))
            .series([
                AASeriesElement()
                    .borderRadiusTopLeft(4)
                    .borderRadiusTopRight(4)
                    .data(averageHours.map({ $0.value }))
            ])
    }
}

extension ReportViewController: DBDelegate {
    func dbUpdate() {
        updateChartsModel()
        habitCell.chart.aa_refreshChartWholeContentWithChartModel(habitChartModel)
        hoursCell.chart.aa_refreshChartWholeContentWithChartModel(hoursChartModel)
    }
}

extension ReportViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 2 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return habitCell
        case 1:
            return hoursCell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Habits and Sleep Quality"
        case 1:
            return "Habits and Sleeping Hours"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Here counts the number of dates with good sleeping quality in latest 30 days. You can find out how Sleep Music and other Sleep Habits influence your sleeping quality."
        case 1:
            return "Here calculates the average sleeping hours for each habit in latest 30 days."
        default:
            return nil
        }
    }
}
