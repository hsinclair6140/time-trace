//
//  EntriesManager.swift
//  Time Track
//
//  Created by Heath Sinclair on 7/18/24.
//

import Foundation


class EntriesUtility{
    
    var entries: [Entry]
    private var totalHoursForDay = 0.0
    
    init(entries:[Entry]) {
        self.entries = entries
    }
    
    func getEntriesForDay(date:Date) -> [Entry]{
        totalHoursForDay = 0
        var entriesForDay:[Entry] = []
        let day = DateTimeUtility.getDay(date: date)
        for entry in entries{
            let entryStartDay = DateTimeUtility.getDay(date: entry.start)
            if (day == entryStartDay){
                entriesForDay.append(entry)
                totalHoursForDay+=entry.duration
            }
        }
        return entriesForDay
    }
    
    static func getIndex(entries:[Entry], entryToFind:Entry) -> Int{
        var i = 0
        for entry in entries{
            if entry.getStart() == entryToFind.getStart(){
                return i
            }
            i+=1
        }
        return -1
    }
    
    func getTotalHoursForDay() -> Double{
        return self.totalHoursForDay
    }
}
