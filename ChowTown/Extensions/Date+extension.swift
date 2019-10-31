//
//  Date+extension.swift
//  VisitorsApp
//
//  Created by Jordain Gijsbertha on 5/14/19.
//  Copyright © 2019 Jordain  Gijsbertha. All rights reserved.
//

import Foundation

public extension Date {
    enum DateFormatType: String {
        /// Time
        case time = "HH:mm"

        /// Date with hours
        case dateWithTime = "dd-MMM-yyyy  H:mm"

        /// Date
        case date = "dd-MMM-yyyy"
    }

    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func convertToString(dateformat formatType: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.rawValue
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }

    func convertToString(dateformat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }

    func removeTimeStamp(fromDate: Date) -> Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: fromDate)) else {
            fatalError("Failed to strip time from Date object")
        }
        return date
    }

    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }

    /**
     - Returns: an optional ISO 8610 formatted String.
     */
    func toISO8601String() -> String? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.string(from: self)
    }
}
