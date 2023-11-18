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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(destinations) { destination in
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.date.formatted(date: .long,
                                                        time: .shortened))
                    }
                }
            }
            .navigationTitle("iTour")
            .toolbar {
                Button("Add Samples", action: addSamples)
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
}

#Preview {
    ContentView()
}
