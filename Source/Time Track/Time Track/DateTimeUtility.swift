//
//  DateTimeUtility.swift
//  Time Track
//
//  Created by Heath Sinclair on 7/16/24.
//

import Foundation

class DateTimeUtility{
    
    init() {

    }
    
    static func sameCalenderDay(date1:Date, date2:Date) -> Bool{
        var dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        let formattedDate1 = dateFormatter.string(from: date1)
        let formattedDate2 = dateFormatter.string(from: date2)
        return formattedDate1 == formattedDate2
    }
    
}
