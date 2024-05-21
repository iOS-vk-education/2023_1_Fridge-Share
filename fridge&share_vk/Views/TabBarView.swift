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
        static let search = "Поиск"
        static let searchIcon = "magnifyingglass"
        static let profile = "Профиль"
        static let profileIcon = "person.fill"
    }
    
    @EnvironmentObject var userData: UserData
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label(Constants.search, systemImage: Constants.searchIcon)
                }
            
            ProfileView(userData: userData)
                .tabItem {
                    Label(Constants.profile, systemImage: Constants.profileIcon)
                }
        }
    }
}

