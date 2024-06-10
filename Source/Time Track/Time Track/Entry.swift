//
//  Item.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/1/24.
//

import Foundation
import SwiftData

@Model
final class Entry {
    var project = ""
    var ticket = 0
    var start = Date()
    var end = Date()
    var duration = 0.0
    var comment = ""
    
    init() {
    }
    
    func setProject(project:String){
        self.project = project
    }
    
    func setTicket(ticket:Int){
        self.ticket = ticket
    }
    
    func setComment(comment:String){
        self.comment = comment
    }
    
    func setStart(date:Date) {
        self.start = date
        self.duration = calcDuration(date1: self.start, date2: self.end)
    }
    
    func setEnd(date:Date) {
        self.end = date
        self.duration = calcDuration(date1: self.start, date2: self.end)
    }
    
    private func calcDuration(date1: Date, date2: Date) -> Double {
        let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: date1, to: date2)
        let hours = Double(diffComponents.hour ?? 0)
        let min = Double(diffComponents.minute ?? 0)/60.0
        let duration = (hours + min) * 100.0
        return duration.rounded() / 100.0
    }
    
}
