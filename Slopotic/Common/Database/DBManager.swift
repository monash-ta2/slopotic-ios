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

    func insertOrUpdateSleep(record model: DailySleepRecord) {
        do {
            try dbQueue.write({ db in
                if try model.exists(db) {
                    try model.update(db)
                } else {
                    try model.insert(db)
                }
            })
        } catch {
            print(error)
        }
    }

    func insertSleep(record model: DailySleepRecord) {
        do {
            try dbQueue.write({ db in
                try model.insert(db)
            })
        } catch {
            print(error)
        }
    }

    func updateSleep(record model: DailySleepRecord) {
        do {
            try dbQueue.write({ db in
                try model.update(db)
            })
        } catch {
            print(error)
        }
    }

    func deleteSleep(record model: DailySleepRecord) {
        do {
            try dbQueue.write({ db in
                try model.delete(db)
            })
        } catch {
            print(error)
        }
    }

    func selectSleep(date: Data) -> DailySleepRecord? {
        do {
            try dbQueue.read({ db in
                return try DailySleepRecord.fetchOne(db, key: date)
            })
        } catch {
            print(error)
        }
        return nil
    }

//    func selectRecentSleep() -> [DailySleepRecord?] {
//        do {
//            try dbQueue.read({ db in
//                return DailySleepRecord.fetchAll(db, keys: [])
//            })
//        }
//    }
}
