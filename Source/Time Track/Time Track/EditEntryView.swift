//
//  AddEntryView.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/1/24.
//

import SwiftUI

struct EditEntryView: View {
    
    var entry:Entry = Entry()
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var project: String
    @State private var ticket_num: String
    @State private var start: Date
    @State private var end: Date
    @State private var comment: String
    
    init(entryIn:Entry) {
        project = entryIn.project
        ticket_num = String(entryIn.ticket_num)
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
                    TextField("1234", text: $ticket_num)
                }
                .keyboardType(UIKeyboardType.decimalPad)
                
                Section(header: Text("Time")){
                    DatePicker("Start", selection: $start)
                    DatePicker("End", selection: $end)
                }
                
                Section(header: Text("Comment")){
                    TextEditor(text: $comment)
                }
            }
            Button("Save") {
                let fm = FavoritesManager()
                let ticket = Ticket(project: project, ticket_num: Int(ticket_num) ?? 0)
                
                if !(fm.contains(ticket.getTicket())){
                    fm.add(ticket.getTicket())
                }
                    
                entry.setProject(project: project)
                entry.setTicket(ticket: Int(ticket_num) ?? 0)
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
}

#Preview {
    EditEntryView(entryIn:Entry()).modelContainer(for: Entry.self, inMemory: true)
}
