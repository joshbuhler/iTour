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
    
    @Query var destinations:[Destination]
    
    @State private var path = [Destination]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(destinations) { destination in
                    NavigationLink(value: destination) {
                        VStack(alignment: .leading) {
                            Text(destination.name)
                                .font(.headline)
                            Text(destination.date.formatted(date: .long,
                                                            time: .shortened))
                        }
                    }
                }
                .onDelete(perform: deleteDestinations)
            }
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self,
                                   destination: EditDestinationView.init)
            .toolbar {
                Button("Add Samples", action: addSamples)
                Button("Add Destination", action: addDestination)
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
    
    func deleteDestinations (_ indexSet:IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
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
