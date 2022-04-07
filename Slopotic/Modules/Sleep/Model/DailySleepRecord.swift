//
//  DailySleepRecord.swift
//  Slopotic
//
//  Created by Weiyi Kong on 7/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import GRDB

struct DailySleepRecord: Codable {
    var date: Date
    var quality: Int
    var tablets: Double = 0
}

extension DailySleepRecord: FetchableRecord, TableRecord, PersistableRecord {
    static var databaseTableName = "sleep"
}
