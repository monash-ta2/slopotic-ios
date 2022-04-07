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

    private lazy var gmtFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.timeZone = .init(secondsFromGMT: 0)
        return formatter
    }()

    private lazy var localFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()

    func setupSleep() {
        do {
            try dbQueue.write({ db in
                try db.create(table: "sleep") { tb in
                    tb.column("date", .date).primaryKey()
                    tb.column("quality", .integer).notNull()
                    tb.column("tablets", .double)
                }
            })
        } catch {
            print(error)
        }
    }

    private func removeDateTimeAndTimezone(original date: Date) -> Date {
        return gmtFormatter.date(from: date.formatted(date: .numeric, time: .omitted))!
    }

    private func recoverDateTimeAndTimezone(converted date: Date) -> Date {
        return localFormatter.date(from: gmtFormatter.string(from: date))!
    }

    func insertOrUpdateSleep(record model: DailySleepRecord) {
        var convertedModel = model
        convertedModel.date = removeDateTimeAndTimezone(original: model.date)
        do {
            try dbQueue.write({ db in
                if try convertedModel.exists(db) {
                    try convertedModel.update(db)
                } else {
                    try convertedModel.insert(db)
                }
            })
        } catch {
            print(error)
        }
    }

    func insertSleep(record model: DailySleepRecord) {
        var convertedModel = model
        convertedModel.date = removeDateTimeAndTimezone(original: model.date)
        do {
            try dbQueue.write({ db in
                try convertedModel.insert(db)
            })
        } catch {
            print(error)
        }
    }

    func updateSleep(record model: DailySleepRecord) {
        var convertedModel = model
        convertedModel.date = removeDateTimeAndTimezone(original: model.date)
        do {
            try dbQueue.write({ db in
                try convertedModel.update(db)
            })
        } catch {
            print(error)
        }
    }

    func deleteSleep(record model: DailySleepRecord) {
        var convertedModel = model
        convertedModel.date = removeDateTimeAndTimezone(original: model.date)
        do {
            try dbQueue.write({ db in
                try convertedModel.delete(db)
            })
        } catch {
            print(error)
        }
    }

    func selectSleep(date: Date) -> DailySleepRecord? {
        var record: DailySleepRecord? = nil
        do {
            try dbQueue.read({ db in
                record = try DailySleepRecord.fetchOne(db, key: removeDateTimeAndTimezone(original: date))
                record?.date = recoverDateTimeAndTimezone(converted: date)
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
