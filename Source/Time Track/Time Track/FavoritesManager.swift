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

    func contains(_ ticket: String) -> Bool {
        return savedTicketData.contains(ticket)
    }

    func add(_ ticket: String) {
        savedTicketData.insert(ticket, at: 0)
        save()
        updateTicketsList()
    }

    func remove(_ ticket: String) {
        let index = savedTicketData.firstIndex(of: ticket) ?? -1
        if (index != -1){
            savedTicketData.remove(at: index)
        }
        save()
        updateTicketsList()
    }
    
    func updateTicketsList(){
        tickets.removeAll()
        for savedTicket in savedTicketData{
            let ticket = Ticket()
            ticket.setTicket(ticket: savedTicket)
            tickets.append(ticket)
        }
    }

    func save() {
        defaults.set(savedTicketData, forKey: favTicketsKey)
    }
    
    func getFavoriteProject() -> String{
        return favoriteProject
    }
    
    func setFavoriteProject(favoriteProject:String) {
        self.favoriteProject = favoriteProject
        defaults.set(favoriteProject, forKey: favProjectKey)
    }
}
