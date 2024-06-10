//
//  MainView.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/10/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }

            Worklog()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
    }
}

#Preview {
    MainView().modelContainer(for: Entry.self, inMemory: true)
}
