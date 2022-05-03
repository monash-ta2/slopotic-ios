//
//  SleepRecord.swift
//  Slopotic
//
//  Created by Weiyi Kong on 7/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import GRDB

struct SleepRecord: Codable {
    var date: DateComponents
    var quality: Int
    var hours: Double = 0
    var habits: [String] = []

    var dbDate: DatabaseDateComponents {
        get { DatabaseDateComponents(date, format: .YMD) }
        set { date = newValue.dateComponents }
    }
    var dbHabit: String {
        get { habits.joined(separator: "\t") }
        set { habits = newValue.split(separator: "\t").map({ String($0) }) }
    }

    init(date: DateComponents, quality: Int, hours: Double, habits: [String]) {
        self.date = date
        self.quality = quality
        self.hours = hours
        self.habits = habits
    }

    init(date: DatabaseDateComponents, quality: Int, hours: Double, habits: [String]) {
        self.date = date.dateComponents
        self.quality = quality
        self.hours = hours
        self.habits = habits
    }

    init(date: DatabaseDateComponents, quality: Int, hours: Double, habit: String) {
        self.date = date.dateComponents
        self.quality = quality
        self.hours = hours
        self.habits = habit.split(separator: "\t").map({ String($0) })
    }

    init(date: DateComponents, quality: Int, hours: Double, habit: String) {
        self.date = date
        self.quality = quality
        self.hours = hours
        self.habits = habit.split(separator: "\t").map({ String($0) })
    }
}

//extension SleepRecord: FetchableRecord, TableRecord, PersistableRecord {
//    static var databaseTableName = "sleep"
//}
