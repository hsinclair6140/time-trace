//
//  WorklogCSVBuilder.swift
//  Time Track
//
//  Created by Heath Sinclair on 7/10/24.
//

import Foundation

@Observable
class WorklogCSV : ObservableObject{
    
    private let header = "Project,Ticket,StartDate,StartTime,Duration,Comment\n"
    private var entries: [Entry] = []
    private var csv: String
    
    init() {
        csv = header
    }
    
    func addEntry(entry: Entry){
        entries.append(entry)
    }
    
    func clear(){
        csv = header
        entries.removeAll()
    }
    
    func build() -> String{
        for entry in entries{
            csv.append("\(entry.getProject()),\(entry.getTicket()),\(entry.getStart().formatted()),\(entry.getDuration()),\(entry.getComment())\n")
        }
        return csv
    }
}
