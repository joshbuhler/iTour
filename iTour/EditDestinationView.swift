//
//  EditDestinationView.swift
//  iTour
//
//  Created by Joshua Buhler on 11/18/23.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    
    @Bindable var destination:Destination
    
    @State private var newSightName = ""
        
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details)
            DatePicker("Date", selection: $destination.date)
            
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Sights") {
                HStack{
                    TextField("Add a new sight in \(destination.name)",
                              text: $newSightName)
                    Button("Add", action: addSight)
                }
                List {
                    ForEach(destination.sights) { sight in
                        Text(sight.name)
                    }
                    .onDelete(perform: deleteSight)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    func addSight () {
        guard !newSightName.isEmpty else {
            return
        }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
    
    func deleteSight (_ indexSet:IndexSet) {
        for index in indexSet {
            destination.sights.remove(at: index)
        }        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self,
                                           configurations: config)
        
        let example = Destination(name: "Example Destination",
                                  details: "Example details go here and will automatically expand vertically as they are edited.")
        return EditDestinationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
