//
//  MapView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//


import SwiftUI
import MapKit

struct MapView: View {
    @State private var showingSearchBar = false
    @State private var searchText = ""
    @State private var searchResults = ["Result 1", "Result 2", "Result 3"]
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.7661195903608, longitude: 37.685031838259846), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))), interactionModes: .all)
                .ignoresSafeArea()
            
            if showingSearchBar {
                SearchMapView(showingSearchBar: $showingSearchBar, searchText: $searchText, searchResults: $searchResults)
            } else {
                SearchButton(showingSearchBar: $showingSearchBar)
            }
        }
    }
}

struct SearchMapView: View {
    @Binding var showingSearchBar: Bool
    @Binding var searchText: String
    @Binding var searchResults: [String]
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText, showingSearchBar: $showingSearchBar)
            SearchResultList(searchResults: $searchResults)
        }
        .transition(.move(edge: .bottom))
        .animation(.spring())
    }
}

struct SearchButton: View {
    @Binding var showingSearchBar: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: { self.showingSearchBar = true }) {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
                .padding()
                Spacer()
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding()
            .shadow(radius: 10)
        }
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var showingSearchBar: Bool
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(20)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            Spacer()
            Button(action: { self.showingSearchBar = false }) {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.large)
            }
            .padding()
        }
        .padding()
    }
}

struct SearchResultList: View {
    @Binding var searchResults: [String]
    
    var body: some View {
        List(searchResults, id: \.self) { result in
            Text(result)
        }
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
