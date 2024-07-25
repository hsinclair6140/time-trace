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
    var comment = Data()
    var shortDescription = Data()
    var onTheJob = false
    
    init() {
        
    }
    
    init(onTheJob:Bool) {
        self.onTheJob = onTheJob
    }
    
    func setProject(project:String){
        self.project = project
    }
    
    func getProject() -> String {
        return self.project
    }
    
    func setTicket(ticket:Int){
        self.ticket_num = ticket
    }
    
    func getTicket() -> String {
        return String(self.ticket_num)
    }
    
    func setComment(comment:String){
        let cu = CryptoUtility()
        
        do {
            self.comment = try cu.encrypt(str: comment)
        } catch {
            print("Unable to encrypt the comment.")
        }
    }
    
    func getComment() -> String {
        
        var comment = ""
        
        do {
            let cu = CryptoUtility()
            comment = try cu.decrypt(data: self.comment)
        } catch {
            print("Unable to decrypt the comment.")
        }
        
        return comment
    }
    
    func setStart(date:Date) {
        self.start = date
        self.duration = calcDuration(date1: self.start, date2: self.end)
    }
    
    func getStart() -> Date {
        return self.start
    }
    
    func setEnd(date:Date) {
        self.end = date
        self.duration = calcDuration(date1: self.start, date2: self.end)
    }
    
    func getEnd() -> Date {
        return self.end
    }
    
    func getDuration() -> Double {
        return self.duration
    }
    
    func setShortDescription(shortDescription:String){
        let cu = CryptoUtility()
        
        do {
            self.shortDescription = try cu.encrypt(str: shortDescription)
        } catch {
            print("Unable to encrypt the shortDescription.")
        }
    }
    
    func getShortDescription() -> String {
        
        var shortDescription = ""
        
        do {
            let cu = CryptoUtility()
            shortDescription = try cu.decrypt(data: self.shortDescription)
        } catch {
            print("Unable to decrypt the shortDescription.")
        }
        
        return shortDescription
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
        comment = Data()
        shortDescription = Data()
        onTheJob = false
    }
}
