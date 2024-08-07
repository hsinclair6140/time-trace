//
//  FavoritesManager.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/18/24.
//

import Foundation

@Observable
class FavoritesManager {
    public var savedTicketData: [String]
    public var tickets: [Ticket]
    private var favoriteProject: String

    private let favTicketsKey = "Favorites"
    private let favProjectKey = "FavoriteProject"
    
    let defaults = UserDefaults.standard
    
    init() {
        
        // Load favorite project
        if defaults.string(forKey: favProjectKey) != nil {
            favoriteProject = defaults.string(forKey: favProjectKey)!
        } else {
            favoriteProject = "PTEAE"
        }
        
        // Load favorite tickets
        if defaults.array(forKey: favTicketsKey) != nil {
            savedTicketData = defaults.object(forKey: favTicketsKey) as! [String]
        } else {
            savedTicketData = []
        }
        tickets = []
        updateTicketsList()
    }

    func contains(_ ticket: Ticket) -> Bool {
        let dataString = createStringFromTicket(ticket: ticket)
        return savedTicketData.contains(dataString)
    }

    func add(_ ticket: Ticket) {
        let dataString = createStringFromTicket(ticket: ticket)
        savedTicketData.insert(dataString, at: 0)
        save()
        updateTicketsList()
    }

    func remove(_ ticket: Ticket) {
        let dataString = createStringFromTicket(ticket: ticket)
        let index = savedTicketData.firstIndex(of: dataString) ?? -1
        if (index != -1){
            savedTicketData.remove(at: index)
        }
        save()
        updateTicketsList()
    }
    
    func updateTicketsList(){
        tickets.removeAll()
        savedTicketData.sort()
        for savedTicketDataString in savedTicketData{
            let ticket = createTicketFromString(ticketDateString: savedTicketDataString)
            tickets.append(ticket)
        }
        
    }

    private func save() {
        defaults.set(savedTicketData, forKey: favTicketsKey)
    }
    
    func getFavoriteProject() -> String{
        return favoriteProject
    }
    
    func setFavoriteProject(favoriteProject:String) {
        self.favoriteProject = favoriteProject
        defaults.set(favoriteProject, forKey: favProjectKey)
    }
    
    func createStringFromTicket(ticket:Ticket) -> String{
        return ticket.getProject()+"-"+String(ticket.getTicketNum())+":"+ticket.getShortDescription()
    }
    
    func createTicketFromString(ticketDateString:String) -> Ticket{
        let id = String(ticketDateString.split(separator: ":")[0])
        let project = String(id.split(separator: "-")[0])
        let number = Int(id.split(separator: "-")[1]) ?? 0
        let summary = String(ticketDateString.split(separator: ":")[1])
        let ticket = Ticket(project: project, ticket_num: number, shortDescription: summary)
        return ticket
    }
}
