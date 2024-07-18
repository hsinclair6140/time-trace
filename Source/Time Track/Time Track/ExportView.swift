//
//  ExportView.swift
//  Time Track
//
//  Created by Heath Sinclair on 7/15/24.
//

import SwiftUI
import MessageUI

struct ExportView: View {
    @ObservedObject var csv: WorklogCSV
    
    let defaults = UserDefaults.standard
    @State private var sendEmail = false
    @State private var emailAddress = ""
    
        
    var body: some View {
        Form {
            TextField("Email Address", text: $emailAddress)
                .onChange(of: emailAddress){
                    defaults.set(emailAddress, forKey: "EmailAddress")
                }
            VStack{
                if MFMailComposeViewController.canSendMail(){
                    Button {
                        sendEmail.toggle()
                    } label: {
                        Text("Send")
                    }
                } else {
                    Text("Email Services Not Available")
                        .multilineTextAlignment(.center)
                }
            }
            .sheet(isPresented: $sendEmail) {
                MailView(
                    content: csv.build(),
                    to: emailAddress,
                    subject: "Timecard Entries")
            }
        }
        .onAppear(perform: {
            emailAddress = defaults.string(forKey: "EmailAddress") ?? ""
        })
    }
}

#Preview {
    ExportView(csv: WorklogCSV())
}
