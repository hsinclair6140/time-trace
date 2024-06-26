//
//  AddEntryView.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/1/24.
//

import SwiftUI

struct EditEntryView: View {
    var fm = FavoritesManager()
    var entry:Entry = Entry()
    @State private var favoritesSelection = ""
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var project: String
    @State private var ticketNum: String
    @State private var start: Date
    @State private var end: Date
    @State private var comment: String
    
    init(entryIn:Entry) {
        project = entryIn.project
        ticketNum = String(entryIn.ticket_num)
        start = entryIn.start
        end = entryIn.end
        comment = entryIn.comment
        entry = entryIn
    }
    
    var body: some View {
        
        NavigationSplitView{
            Form {
                
                Section(header: Text("Project")){
                    TextField("PTEAE", text: $project)
                }
                
                Section(header: Text("Ticket")){
                    TextField("1234", text: $ticketNum)
                }
                .keyboardType(UIKeyboardType.decimalPad)
                

                Picker(selection: $favoritesSelection, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                    ForEach(fm.savedTicketData, id: \.self) { ticket in
                        Text(ticket)
                    }
                }
                .onChange(of: favoritesSelection) {
                    var tmpProject = ""
                    var tmpTicketNum = ""
                    if (favoritesSelection.contains("-")){
                        tmpProject = String(favoritesSelection.split(separator: "-")[0])
                        tmpTicketNum = String(favoritesSelection.split(separator: "-")[1])
                    }
                    project = tmpProject
                    ticketNum = tmpTicketNum
                }
                Button(action: deleteFavorite) {
                    Label("", systemImage: "trash").labelStyle(.iconOnly)
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
                let ticket = Ticket(project: project, ticket_num: Int(ticketNum) ?? 0)
                
                if !(fm.contains(ticket.getTicket())){
                    fm.add(ticket.getTicket())
                }
                    
                entry.setProject(project: project)
                entry.setTicket(ticket: Int(ticketNum) ?? 0)
                entry.setStart(date: start)
                entry.setEnd(date: end)
                entry.setComment(comment: comment)
                modelContext.insert(entry)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        detail: {
            Text("Select an item")
        }
        .onAppear(perform: {entry.project = project})
    }
    
    private func deleteFavorite(){
        fm.remove(favoritesSelection)
    }
}

#Preview {
    EditEntryView(entryIn:Entry()).modelContainer(for: Entry.self, inMemory: true)
}
