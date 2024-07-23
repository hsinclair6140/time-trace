//
//  DateTimeUtility.swift
//  Time Track
//
//  Created by Heath Sinclair on 7/16/24.
//

import Foundation

class DateTimeUtility{
    
    enum DateConversionError: Error {
        case runtimeError(String)
    }
    
    init() {

    }
    
    static func getDay(date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: date)
    }
    
    static func getDayWithHour(date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: date)
    }
    
    static func getDateFromString(dateString: String) -> Date {
        // Converts a string to date object. Must be in the form of "Jan 10, 2024 at 5:00AM"
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from:dateString)!
        return date
    }
    
    static func removeSeconds(date:Date) -> Date{
        let newDateSting = getDayWithHour(date:date)
        let newDate = getDateFromString(dateString: newDateSting)
        return newDate
    }
    
    static func sameCalenderDay(date1:Date, date2:Date) -> Bool{
        let formattedDate1 = getDay(date: date1)
        let formattedDate2 = getDay(date: date2)
        return formattedDate1 == formattedDate2
    }
}
