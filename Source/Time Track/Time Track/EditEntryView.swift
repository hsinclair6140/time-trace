//
//  AddEntryView.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/1/24.
//

import SwiftUI

struct EditEntryView: View {
    var fm = FavoritesManager()
    var entryIn:Entry
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var project: String
    @State private var ticketNum: String
    @State private var start = Date()
    @State private var end: Date
    @State private var comment: String
    @State private var shortDescription = ""
    
    init(entryIn:Entry) {
        self.project = entryIn.project
        self.ticketNum = String(entryIn.ticket_num)
        self.start = entryIn.start
        self.end = entryIn.end
        self.comment = entryIn.getComment()
        self.shortDescription = entryIn.getShortDescription()
        self.entryIn = entryIn
    }
    
    var body: some View {
        
        NavigationSplitView{
            Form {
                
                Section(header: Text("Project")){
                    TextField("PTEAE", text: $project)
                }
                .onChange(of: project){
                    fm.setFavoriteProject(favoriteProject: project)
                }
                
                Section(header: Text("Ticket")){
                    TextField("1234", text: $ticketNum)
                }
                .keyboardType(UIKeyboardType.decimalPad)
                
                Section(header: Text("Short Description")){
                    TextField("Short Description", text: $shortDescription)
                }
                                
                Section(header: Text("Time")){
                    DatePicker("Start", selection: $start)
                    DatePicker("End", selection: $end)
                }
                
                Section(header: Text("Comment")){
                    TextEditor(text: $comment)
                }
            }
            Button("Save") {
                
                // Add ticket to favorites
                let ticket = Ticket(project: project, ticket_num: Int(ticketNum) ?? 0, shortDescription: shortDescription)
                
                if !(fm.contains(ticket.getTicket())){
                    fm.add(ticket.getTicket())
                }
                    
                // Create a new copy of the entry object to store as a backup. The original will be cleared and used in 'ContentView' again.
                let entryToStore = Entry()
                entryToStore.setProject(project: project)
                entryToStore.setTicket(ticket: Int(ticketNum) ?? 0)
                entryToStore.setStart(date: start)
                entryToStore.setEnd(date: end)
                entryToStore.setComment(comment: comment)
                
                entryIn.clear()
                
                modelContext.insert(entryToStore)
                
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    EditEntryView(entryIn:Entry()).modelContainer(for: Entry.self, inMemory: true)
}
