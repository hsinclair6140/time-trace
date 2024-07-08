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
        
    var name = ""
    var project = ""
    var ticket_num = 0
    var start = Date()
    var end = Date()
    var duration = 0.0
    var comment = ""
    var onTheJob = false
    
    init() {
    }
    
    init(onTheJob:Bool) {
        self.onTheJob = onTheJob
    }
    
    func setProject(project:String){
        self.project = project
    }
    
    func setTicket(ticket:Int){
        self.ticket_num = ticket
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
    
    func calcDuration(date1: Date, date2: Date) -> Double {
        var elapsed = date2.timeIntervalSince(date1)
        elapsed = elapsed / 3600.0
        elapsed = elapsed * 1000.0
        elapsed = elapsed.rounded()
        elapsed = elapsed/1000.0
        return elapsed
    }
    
    func clear() {
        name = ""
        project = ""
        ticket_num = 0
        start = Date()
        end = Date()
        duration = 0.0
        comment = ""
        onTheJob = false
    }
}
