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
    @StateObject var userData: UserData
    @State var floorNumber = 0
    var database = FireBase.shared
    @State private var profileImage: UIImage?
    
    @State private var showingHelloView = false
    @State private var isDarkMode = false // Переменная для хранения текущей темы

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ProfileHeader(profileImage: $profileImage, userName: $userData.name, floorNumber: floorNumber, user: userData)
                    
                    Spacer()
                    
                    ProfileActions(showingListOfMyProducts: $showingListOfMyProducts, showingFridge: $showingFridge, showingRequests: $showingRequests, showingLogin: $showingLogin, showingHelloView: $showingHelloView, isDarkMode: $isDarkMode, user: userData)
                }
                .background(Color(UIColor.systemBackground))
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .navigationBarItems(trailing:
                Button(action: {
                    isDarkMode.toggle() // Переключение темы
                }) {
                    Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                        .foregroundColor(isDarkMode ? .white : .black) // Цвет иконки
                        .font(.title)
                }
            )
            .fullScreenCover(isPresented: $showingHelloView, content: {
                HelloView()
                    .environmentObject(UserData())
            })
            .onAppear {
                fetchUserProfile()
                if let cachedImage = ImageCache.shared.getImage(for: userData.avatar) {
                    self.profileImage = cachedImage
                } else {
                    database.uploadAvatar(avatarFileName: userData.avatar) { image in
                        self.profileImage = image
                    }
                }
                database.getFloorById(floorId: userData.floor) { floor in
                    self.floorNumber = floor?.number ?? 0
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light) // Применение текущей темы
        }
    }


    
    private func fetchUserProfile() {
        if let userId = UserDefaults.standard.string(forKey: "userId") {
            FireBase.shared.getUserById(userId: userId) { user in
                if let user = user {
                    userData.name = user.name
                    userData.email = user.email
                    userData.password = user.password
                    userData.dormitory = user.dormitory
                    userData.floor = user.floor
                    userData.fridge = user.fridge
                    userData.id = userId
                    userData.avatar = user.avatar
                }
            }
        }
    }
}


struct ProfileHeader: View {
    @Binding var profileImage: UIImage?
    @Binding var userName: String
    var floorNumber: Int
    var database = FireBase.shared
    @StateObject var user: UserData
    
    @State private var isShowingImagePicker = false

    var body: some View {
        VStack {
            if let image = profileImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                    .clipShape(Circle())
                    .padding(.top, 30)
                
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                    .padding(.top, 30)
                    .foregroundColor(.secondary)
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
    @Binding var showingHelloView: Bool
    @Binding var isDarkMode: Bool

    
    var database = FireBase.shared
    @StateObject var user: UserData
    
    var body: some View {
        VStack {
            Button(action: {
                self.showingListOfMyProducts = true
            }, label: {
                NavigationLink(destination: MyProducts(user: user),
                               label: {
                    Text(Constants.myProducts)
                        .foregroundColor(isDarkMode ? .white : .black) // Цвет текста в зависимости от темы
                })
            })
            .buttonStyle(DefaultButtonStyle())
            
            Button(action: {
                self.showingFridge = true
            }, label: {
                NavigationLink(destination: MyFridge(user: user),
                               label: {
                    Text(Constants.myFridge)
                        .foregroundColor(isDarkMode ? .white : .black) // Цвет текста в зависимости от темы
                })
            })
            .buttonStyle(DefaultButtonStyle())

            Button(action: {
                self.showingListOfMyProducts = true
            }, label: {
                NavigationLink(destination: Notification(),
                               label: {
                    Text(Constants.notification)
                        .foregroundColor(isDarkMode ? .white : .black) // Цвет текста в зависимости от темы
                })
            })
            .buttonStyle(DefaultButtonStyle())
            .foregroundColor(isDarkMode ? .white : .black) // Цвет текста в зависимости от темы
            
            LogoutButton(showingLogin: $showingLogin, showingHelloView: $showingHelloView)
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
    @Binding var showingHelloView: Bool
    var body: some View {
        Button(action: {
            UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
            showingLogin = true
            showingHelloView = true
        }) {
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

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
    }
}

struct BlueDisabledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.secondary)
            .cornerRadius(10)
    }
}


class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    init(image: UIImage?) {
        self.image = image
    }
}


