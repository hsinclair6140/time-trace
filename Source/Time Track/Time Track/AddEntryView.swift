//
//  AddEntryView.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/1/24.
//

import SwiftUI

struct AddEntryView: View {
    var fm = FavoritesManager()
    var entry = Entry()
    @State private var favoritesSelection = ""
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var project = ""
    @State private var ticketNum = ""
    @State private var shortDescription = ""
    @State private var start:Date
    @State private var end:Date
    @State private var comment = ""
    

    
    init(date:Date) {
        start = date
        end = date
    }
    
    var body: some View {
    
        NavigationSplitView{
            Form {
                
                Section(header: Text("Project")){
                    TextField("PTEAE", text: $project)
                }
                .onAppear(perform: {
                    project = fm.getFavoriteProject()
                })
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
                
                Picker(selection: $favoritesSelection, label: Text("Recents:")) {
                    ForEach(fm.savedTicketData, id: \.self) { ticket in
                        Text(ticket)
                    }
                }
                .onChange(of: favoritesSelection) {
                    var tmpProject = ""
                    var tmpTicketNum = ""
                    var tmpShortDescription = ""
                    if (favoritesSelection.contains("-")){
                        tmpProject = String(favoritesSelection.split(separator: "-")[0])
                        tmpTicketNum = String(favoritesSelection.split(separator: "-")[1])
                        if (tmpTicketNum.contains(": ")){
                            tmpShortDescription = String(tmpTicketNum.split(separator: ": ")[1])
                            tmpTicketNum = String(tmpTicketNum.split(separator: ": ")[0])
                        }
                    }
                    project = tmpProject
                    ticketNum = tmpTicketNum
                    shortDescription = tmpShortDescription
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
                
                let ticket = Ticket(project: project, ticket_num: Int(ticketNum) ?? 0, shortDescription: shortDescription)
                
                if !(fm.contains(ticket.getTicket())){
                    fm.add(ticket.getTicket())
                }
                    
                entry.setProject(project: project)
                entry.setTicket(ticket: Int(ticketNum) ?? 0)
                entry.setShortDescription(shortDescription: shortDescription)
                entry.setStart(date: DateTimeUtility.removeSeconds(date: start))
                entry.setEnd(date: DateTimeUtility.removeSeconds(date: end))
                entry.setComment(comment: comment)
                modelContext.insert(entry)
                
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        detail: {
            Text("Select an item")
        }
    }
    
    private func deleteFavorite(){
        fm.remove(favoritesSelection)
    }
    
}

#Preview {
    AddEntryView(date:Date()).modelContainer(for: Entry.self, inMemory: true)
}
