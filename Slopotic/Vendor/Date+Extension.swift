//
//  Date+Extension.swift
//  Slopotic
//
//  Created by Weiyi Kong on 8/4/2022.
//  Copyright © 2022 Double Flash. All rights reserved.
//

import Foundation

extension Date {
    func dayOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: self)
    }
}
