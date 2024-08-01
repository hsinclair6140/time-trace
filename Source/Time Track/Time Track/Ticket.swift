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
    private var ticket = ""
    private var shortDescription = ""
    
    init(){
        
    }
    
    init(project:String, ticket_num:Int, shortDescription:String){
        self.project = project
        self.ticket_num = ticket_num
        self.shortDescription = shortDescription
    }
    
    func getProject() -> String{
        return self.project
    }
    
    func setProject(project:String){
        self.project = project
    }
    
    func getTicketNum() -> Int{
        return self.ticket_num
    }
    
    func setTicketNum(ticket_num:Int){
        self.ticket_num = ticket_num
    }
    
    func setTicket(ticket:String){
        self.ticket = ticket
    }
    
    func getShortDescription() -> String{
        return self.shortDescription
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
