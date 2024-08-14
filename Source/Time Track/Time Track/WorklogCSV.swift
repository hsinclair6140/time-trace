//
//  WorklogCSVBuilder.swift
//  Time Track
//
//  Created by Heath Sinclair on 7/10/24.
//

import Foundation

class WorklogCSV : ObservableObject{
        
    static func buildCSVFromEntries(entries: [Entry]) -> String{
        var csv = "Project,Ticket,StartDate,StartTime,Duration,Comment\n"
        for entry in entries{
            csv.append("\(entry.getProject()),\(entry.getTicket()),\(entry.getStart().formatted()),\(entry.getDuration()),\(entry.getComment())\n")
        }
        return csv
    }
}
