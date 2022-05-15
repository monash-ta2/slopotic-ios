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

    var delegates: [DBDelegate] = []

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

    func setupPlayRecord() {
        do {
            try dbQueue.write({ db in
                try db.create(table: "play") { tb in
                    tb.column("date", .date).primaryKey()
                }
            })
        } catch {
            print(error)
        }
    }

    private func notifyUpdates() {
        for delegate in delegates {
            delegate.dbUpdate()
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
            notifyUpdates()
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
            notifyUpdates()
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
            notifyUpdates()
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

    func selectLastMonthSleep() -> [SleepRecord] {
        var records: [SleepRecord] = []
        do {
            try dbQueue.read({ db in
                let rows = try Row.fetchAll(db, sql: "SELECT * FROM sleep WHERE date BETWEEN datetime('now', '-30 days') AND datetime('now', 'localtime')")
                records = rows.map({ SleepRecord(date: $0["date"], quality: $0["quality"], hours: $0["hours"], habit: $0["habit"]) })
            })
        } catch {
            print(error)
        }
        return records
    }

    func todayPlay(date: DateComponents) {
        if !selectPlay(date: date) {
            insertPlay(date: date)
        }
    }

    func insertPlay(date: DateComponents) {
        do {
            try dbQueue.write({ db in
                try db.execute(
                    sql: "INSERT INTO play (date) VALUES (?)",
                    arguments: [DatabaseDateComponents(date, format: .YMD)]
                )
            })
            notifyUpdates()
        } catch {
            print(error)
        }
    }

    func selectPlay(date: DateComponents) -> Bool {
        var result = false
        do {
            try dbQueue.read({ db in
                if let _ = try Row.fetchOne(db, sql: "SELECT * FROM play WHERE date = ?", arguments: [DatabaseDateComponents(date, format: .YMD)]) {
                    result = true
                }
            })
        } catch {
            print(error)
        }
        return result
    }

    func selectLastMonthPlay() -> [DateComponents] {
        var records = [DateComponents]()
        do {
            try dbQueue.read({ db in
                let rows = try Row.fetchAll(db, sql: "SELECT * FROM play WHERE date BETWEEN datetime('now', '-30 days') AND datetime('now', 'localtime')")
                records = rows.compactMap({ row in
                    let dbDate: DatabaseDateComponents = row["date"]
                    return dbDate.dateComponents
                })
            })
        } catch {
            print(error)
        }
        return records
    }
}
