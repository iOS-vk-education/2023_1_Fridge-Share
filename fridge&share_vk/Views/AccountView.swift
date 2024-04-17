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
            
            Text(user.name)
                .font(.title)
                .padding(.top, 10)
            
            Text("Этаж №\(floorNumber)")
                .font(.headline)
                .padding(.top, 5)
            
            Spacer()

            Button(action: {
                self.showingListOfMyProducts = true
            }, label: {
                NavigationLink(destination: MyProducts(),
                               label: {
                    Text("Мои продукты")
                })
            })
            .buttonStyle(DefaultButtonStyle())
            
            Button(action: {
                self.showingFridge = true
            }, label: {
                NavigationLink(destination: MyFridge(),
                               label: {
                    Text("Мой холодильник")
                })
            })
            .buttonStyle(DefaultButtonStyle())
            
            Button(action: {
                self.showingRequests = true
            }) {
                Text("Уведомления")
            }
            .buttonStyle(DefaultButtonStyle())
            
            Button(action: {
                self.showingLogin = true
            }) {
                Text("Выйти")
                    .foregroundColor(.white)
            }
            .buttonStyle(RedButtonStyle())
            .padding(.top, 40)
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

