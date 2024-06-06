//
//  AddEntryView.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/1/24.
//

import SwiftUI

struct EditEntryView: View {
    
    var entry:Item = Item()
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var project: String
    @State private var ticket: String
    @State private var start: Date
    @State private var end: Date
    @State private var comment: String
    
    init(entryIn:Item) {
        project = entryIn.project
        ticket = String(entryIn.ticket)
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
//                .keyboardType(UIKeyboardType.default)
                
                Section(header: Text("Ticket")){
                    TextField("1234", text: $ticket)
                }
                
                Section(header: Text("Time")){
                    DatePicker("Start", selection: $start)
                    DatePicker("End", selection: $end)
                }
                
                Section(header: Text("Comment")){
                    TextEditor(text: $comment)
                }
                .onSubmit {
                    entry.comment = comment
                }
//                .keyboardType(UIKeyboardType.default)
                
            }
            Button("Save") {
                entry.project = project
                entry.ticket = Int(ticket) ?? 0
                entry.setStart(start: start)
                entry.setEnd(end: end)
                print(entry.project)
                print(entry.ticket)
                print(entry.start)
                print(entry.end)
                print(entry.duration)
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
    EditEntryView(entryIn:Item())
}
