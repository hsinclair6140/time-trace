//
//  ContentView.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/1/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State var onTheJobEntry = Entry(onTheJob:true)
    @State var onTheJobDuration = 0.0
    var fm = FavoritesManager()
    @State private var favoritesSelection = ""
    @State private var project = ""
    @State private var ticketNum = ""
    @State private var start = Date()
    @State private var comment = ""
    @State private var shortDescription = ""
    
 
    var body: some View {
 
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            onTheJobEntry.end = Date()
            onTheJobDuration = onTheJobEntry.end.timeIntervalSince(onTheJobEntry.start)
            onTheJobDuration = onTheJobDuration / 3600.0
            onTheJobDuration = onTheJobDuration * 1000.0
            onTheJobDuration = onTheJobDuration.rounded()
            onTheJobDuration = onTheJobDuration/1000.0
        }
        
        NavigationView {
            Form {
                Section(header: Text("On the Job")){
                    GroupBox(label: Label("", systemImage: "none")) {
                        if onTheJobEntry.project != "" {
                            LabeledContent("Job", value: "\(onTheJobEntry.project)-\(String(onTheJobEntry.ticket_num))")
                            LabeledContent("Duration", value: "\(String(onTheJobDuration))")
                        } else {
                            LabeledContent("", value: "Not Clocked In")
                        }
                    }
                }
                Section(header: Text("Project")){
                    TextField("PTEAE", text: $project)
                }
                .onChange(of: project){
                    onTheJobEntry.setProject(project: project)
                }
                
                Section(header: Text("Ticket")){
                    TextField("1234", text: $ticketNum)
                }
                .keyboardType(UIKeyboardType.decimalPad)
                .onChange(of: ticketNum){
                    onTheJobEntry.setTicket(ticket: Int(ticketNum) ?? 0)
                }
                
                Section(header: Text("Short Description")){
                    TextField("Short Description", text: $shortDescription)
                }
                .onChange(of: shortDescription){
                    onTheJobEntry.setShortDescription(shortDescription: shortDescription)
                }
                
                Section(header: Text("Time")){
                    DatePicker("Start", selection: $start)
                }
                .onChange(of: start){
                    onTheJobEntry.setStart(date: start)
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
                Section(header: Text("Comment")){
                    TextEditor(text: $comment)
                }
                .onChange(of: comment){
                    onTheJobEntry.setComment(comment: comment)
                }
                
                NavigationLink(destination: EditEntryView(entryIn: onTheJobEntry)) {
                    Label("Clock Out", systemImage: "clock")
                }
            }
            .onAppear(){
                favoritesSelection = ""
                project = ""
                ticketNum = ""
                shortDescription = ""
                start = Date()
                comment = ""
                fm.updateTicketsList()
            }
        }
    }
    private func deleteFavorite(){
        fm.remove(favoritesSelection)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Entry.self, inMemory: true)
}
