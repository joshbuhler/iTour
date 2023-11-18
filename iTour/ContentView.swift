//
//  ContentView.swift
//  iTour
//
//  Created by Joshua Buhler on 11/18/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Destination]()
    
    @State private var sortOrder = SortDescriptor(\Destination.name)
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder)
                .navigationTitle("iTour")
                .navigationDestination(for: Destination.self,
                                       destination: EditDestinationView.init)
                .toolbar {
                    Button("Add Samples", action: addSamples)
                    Button("Add Destination", action: addDestination)
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Destination.name))
                            Text("Priority")
                                .tag(SortDescriptor(\Destination.priority, order: .reverse))
                            Text("Date")
                                .tag(SortDescriptor(\Destination.date))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addSamples () {
        let mustafar = Destination(name: "Mustafar")
        let scarif = Destination(name: "Scarif")
        let naboo = Destination(name: "Naboo")
        
        modelContext.insert(mustafar)
        modelContext.insert(scarif)
        modelContext.insert(naboo)
    }
    
    
    
    func addDestination () {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}
