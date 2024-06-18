//
//  FavoritesManager.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/18/24.
//

import Foundation

@Observable
class FavoritesManager {
    private var savedTicketData: [String]
    private var tickets: [Ticket]

    private let key = "Favorites"
    
    let defaults = UserDefaults.standard
    
    init() {
        if defaults.array(forKey: key) != nil {
            savedTicketData = defaults.object(forKey: key) as! [String]
        } else {
            savedTicketData = []
        }
        tickets = []
    }

    func contains(_ ticket: String) -> Bool {
        return savedTicketData.contains(ticket)
    }

    func add(_ ticket: String) {
        savedTicketData.insert(ticket, at: 0)
        save()
    }

    func remove(_ ticket: String) {
        var index = savedTicketData.firstIndex(of: ticket) ?? -1
        if (index != -1){
            savedTicketData.remove(at: index)
        }
        save()
    }
    
    func getTickets() -> [Ticket]{
        for savedTicket in savedTicketData{
            let ticket = Ticket()
            ticket.setTicket(ticket: savedTicket)
            tickets.append(ticket)
        }
        return tickets
    }

    func save() {
        defaults.set(savedTicketData, forKey: key)
    }
}
