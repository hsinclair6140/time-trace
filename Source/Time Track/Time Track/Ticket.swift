//
//  Ticket.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/17/24.
//

import Foundation

class Ticket : Identifiable{
    
    private var project = ""
    private var ticket_num = 0
    public var ticket = ""
    public var shortDescription = ""
    
    init(){
        
    }
    
    init(project:String, ticket_num:Int, shortDescription:String){
        self.project = project
        self.ticket_num = ticket_num
        self.shortDescription = shortDescription
    }
    
    func setProject(project:String){
        self.project = project
    }
    
    func setTicketNum(ticket_num:Int){
        self.ticket_num = ticket_num
    }
    
    func setTicket(ticket:String){
        self.ticket = ticket
    }
    
    func setShortDescription(shortDescription:String){
        self.shortDescription = shortDescription
    }
    
    func getTicket() -> String {
        if (self.ticket != ""){
            return self.ticket
        }
        return self.project + "-" + String(self.ticket_num) + ": " + self.shortDescription
    }
}
