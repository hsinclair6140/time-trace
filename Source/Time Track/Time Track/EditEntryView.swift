//
//  AddEntryView.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/1/24.
//

import SwiftUI

struct EditEntryView: View {
    var fm = FavoritesManager()
    var entryIn = Entry()
    @State private var favoritesSelection = ""
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var project:String
    @State private var ticketNum:String
    @State private var start:Date
    @State private var end:Date
    @State private var comment:String
    @State private var shortDescription:String
    
    init(date:Date) {
        start = DateTimeUtility.removeSeconds(date: date)
        end = DateTimeUtility.removeSeconds(date: date)
        project = ""
        ticketNum = ""
        comment = ""
        shortDescription = ""
    }
    
    init(entryIn:Entry) {
        self.project = entryIn.getProject()
        self.ticketNum = String(entryIn.getTicket())
        self.start = entryIn.getStart()
        self.end = entryIn.getEnd()
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
                
                Picker(selection: $favoritesSelection, label: Text("Recents:")) {
                    ForEach(fm.savedTicketData, id: \.self) { ticket in
                        Text(ticket)
                    }
                }
                .onChange(of: favoritesSelection) {
                    var tmpProject = ""
                    var tmpTicketNum = ""
                    var tmpShortDescription = ""
                    var splitFavSelection = favoritesSelection.split(separator: "-")
                    if (splitFavSelection.count > 1){
                        tmpProject = String(splitFavSelection[0])
                        tmpTicketNum = String(splitFavSelection[1])
                        var splitTicketNum = tmpTicketNum.split(separator: ": ")
                        if (splitTicketNum.count > 1){
                            tmpTicketNum = String(splitTicketNum[0])
                            tmpShortDescription = String(splitTicketNum[1])
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
                    HStack{
                        Text("Start")
                        Button("Now") {
                            self.start = Date()
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        DatePicker("", selection: $start)
                    }
                    HStack{
                        Text("End")
                        Button("Now") {
                            self.end = Date()
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        DatePicker("", selection: $end)
                    }
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
                    
                entryIn.setProject(project: project)
                entryIn.setTicket(ticket: Int(ticketNum) ?? 0)
                entryIn.setStart(date: start)
                entryIn.setEnd(date: end)
                entryIn.setShortDescription(shortDescription: shortDescription)
                entryIn.setComment(comment: comment)
                
                modelContext.insert(entryIn)
                
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
    EditEntryView(entryIn:Entry()).modelContainer(for: Entry.self, inMemory: true)
}
