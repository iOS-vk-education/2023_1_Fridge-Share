//
//  TabBarView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI

struct TabBar: View {
    private enum Constants {
        static let maps = "Maps"
        static let mapIcon = "map.fill"
        static let search = "Search"
        static let searchIcon = "magnifyingglass"
        static let profile = "Profile"
        static let profileIcon = "person.fill"
    }
    
    @EnvironmentObject var user: UserData
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Label(Constants.maps, systemImage: Constants.mapIcon)
                }
            
            SearchView()
                .tabItem {
                    Label(Constants.search, systemImage: Constants.searchIcon)
                }
            
            ProfileView(user: _user)
                .tabItem {
                    Label(Constants.profile, systemImage: Constants.profileIcon)
                }
        }
    }
}

#Preview {
    TabBar()
        .environmentObject(UserData())
}

