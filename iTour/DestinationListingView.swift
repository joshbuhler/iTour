//
//  DestinationListingView.swift
//  iTour
//
//  Created by Joshua Buhler on 11/18/23.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse),
                  SortDescriptor(\Destination.name)]) var destinations:[Destination]
    
    init(sort: SortDescriptor<Destination>, searchString:String) {
//        _destinations = Query(sort: [sort])
        
        // High priority only
//        _destinations = Query(filter: #Predicate{
//            $0.priority >= 2
//        }, sort: [sort])
        
        // Only upcoming trips
//        let now = Date.now
//        _destinations = Query(filter: #Predicate{
//            $0.date >= now
//        }, sort: [sort])
        
        // Accept a search string
        _destinations = Query(filter: #Predicate{
            if (searchString.isEmpty) {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    var body: some View {
        // TODO: forgot, but how do I animate list changes on sort?
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
    }
    
    func deleteDestinations (_ indexSet:IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
