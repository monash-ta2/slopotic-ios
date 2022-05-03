//
//  DBManager.swift
//  Slopotic
//
//  Created by Weiyi Kong on 7/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import GRDB

class DBManager {
    static let shared = DBManager()

    let dbPath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!)/db.sqlite3"
    lazy var dbQueue = try! DatabaseQueue(path: self.dbPath)

    func setupSleepRecord() {
        do {
            try dbQueue.write({ db in
                try db.create(table: "sleep") { tb in
                    tb.column("date", .date).primaryKey()
                    tb.column("quality", .integer).notNull()
                    tb.column("hours", .double)
                    tb.column("habit", .text)
                }
            })
        } catch {
            print(error)
        }
    }

    func todaySleep(record model: SleepRecord) {
        if let _ = selectSleep(date: model.date) {
            updateSleep(record: model)
        } else {
            insertSleep(record: model)
        }
    }

    func insertSleep(record model: SleepRecord) {
        do {
            try dbQueue.write({ db in
                try db.execute(
                    sql: "INSERT INTO sleep (date, quality, hours, habit) VALUES (?, ?, ?, ?)",
                    arguments: [model.dbDate, model.quality, model.hours, model.dbHabit]
                )
            })
        } catch {
            print(error)
        }
    }

    func updateSleep(record model: SleepRecord) {
        do {
            try dbQueue.write({ db in
                try db.execute(
                    sql: "UPDATE sleep SET quality = ?, hours = ?, habit = ? WHERE date = ?",
                    arguments: [model.quality, model.hours, model.dbHabit, model.dbDate]
                )
            })
        } catch {
            print(error)
        }
    }

    func deleteSleep(date: DateComponents) {
        do {
            try dbQueue.write({ db in
                try db.execute(
                    sql: "DELETE FROM sleep WHERE date = ?",
                    arguments: [DatabaseDateComponents(date, format: .YMD)]
                )
            })
        } catch {
            print(error)
        }
    }

    func selectSleep(date: DateComponents) -> SleepRecord? {
        var record: SleepRecord? = nil
        do {
            try dbQueue.read({ db in
                if let row = try Row.fetchOne(db, sql: "SELECT * FROM sleep WHERE date = ?", arguments: [DatabaseDateComponents(date, format: .YMD)]) {
                    record = SleepRecord(date: row["date"], quality: row["quality"], hours: row["hours"], habit: row["habit"])
                }
            })
        } catch {
            print(error)
        }
        return record
    }

//    func selectRecentSleep() -> [DailySleepRecord?] {
//        do {
//            try dbQueue.read({ db in
//                return DailySleepRecord.fetchAll(db, keys: [])
//            })
//        }
//    }
}
