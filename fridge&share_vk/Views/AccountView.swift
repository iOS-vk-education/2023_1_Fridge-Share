//
//  AccountView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI
import UIKit

struct ProfileView: View {
    @State private var showingListOfMyProducts = false
    @State private var showingFridge = false
    @State private var showingRequests = false
    @State private var showingLogin = false
    @EnvironmentObject var user: UserData
    @State var floorNumber = 0
    var database = FireBase.shared
    @State private var profileImage: UIImage?

    var body: some View {
        VStack {
            ProfileHeader(profileImage: $profileImage, userName: user.name, floorNumber: floorNumber, user: user)
            
            Spacer()
            
            ProfileActions(showingListOfMyProducts: $showingListOfMyProducts, showingFridge: $showingFridge, showingRequests: $showingRequests, showingLogin: $showingLogin, user: user)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .onAppear {
            database.uploadAvatar() { image in
                self.profileImage = image
            }
            database.getFloorById(floorId: user.floor) { floor in
                self.floorNumber = floor?.number ?? 0
            }
        }
    }
}

struct ProfileHeader: View {
    @Binding var profileImage: UIImage?
    var userName: String
    var floorNumber: Int
    
    @StateObject var user: UserData
    
    var body: some View {
        VStack {
            if let image = profileImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                    .clipShape(Circle())
                    .padding(.top, 30)
            } else {
                ProgressView()
            }
            
            Text(userName)
                .font(.title)
                .padding(.top, 10)
            
            Text("Этаж №\(floorNumber)")
                .font(.headline)
                .padding(.top, 5)
        }
    }
}

struct ProfileActions: View {
    private enum Constants {
        static let myProducts = "Мои продукты"
        static let myFridge = "Мой холодильник"
        static let notification = "Уведомления"
        static let padding: CGFloat = 40
    }
    
    @Binding var showingListOfMyProducts: Bool
    @Binding var showingFridge: Bool
    @Binding var showingRequests: Bool
    @Binding var showingLogin: Bool
    
    @StateObject var user: UserData
    
    var body: some View {
        VStack {
            Button(action: {
                self.showingListOfMyProducts = true
            }, label: {
                NavigationLink(destination: MyProducts(),
                               label: {
                    Text(Constants.myProducts)
                })
            })
            .buttonStyle(DefaultButtonStyle())
            
            Button(action: {
                self.showingFridge = true
            }, label: {
                NavigationLink(destination: MyFridge(user: user),
                               label: {
                    Text(Constants.myFridge)
                })
            })
            .buttonStyle(DefaultButtonStyle())
            NavigationButton(title: Constants.notification, action: { self.showingRequests = true })
            LogoutButton(showingLogin: $showingLogin)
                .padding(.top, Constants.padding)
        }
    }
}

struct NavigationButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(DefaultButtonStyle())
        .padding(.top, 20)
    }
}

struct LogoutButton: View {
    @Binding var showingLogin: Bool
    
    var body: some View {
        Button(action: { self.showingLogin = true }) {
            Text("Выйти")
                .foregroundColor(.white)
        }
        .buttonStyle(RedButtonStyle())
        .padding(.top, 40)
    }
}

// Button Styles

struct DefaultButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
    }
}

struct RedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
    }
}
