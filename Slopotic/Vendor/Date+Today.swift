//
//  Date+Today.swift
//  Slopotic
//
//  Created by Weiyi Kong on 8/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import Foundation

extension Date {
    static var today: Date {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            return formatter.date(from: Date.now.formatted(date: .numeric, time: .omitted))!
        }
    }
}
