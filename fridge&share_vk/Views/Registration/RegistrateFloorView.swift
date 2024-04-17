//
//  RegistrateFloorView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI

struct FloorsView: View {
    private enum Constants {
        static let navigationTitle = "Список этажей"
    }
    
    @StateObject
    var database = FireBase.shared
    
    var dormitory: DormitoryData
    
    @EnvironmentObject var userData: UserData
    
    @State var floors: [FloorData] = []
    @State var isLoading = true
    
    @Binding var twoPreRootIsActive : Bool
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(floors, id: \.self) { floor in
                        NavigationLink(destination: FridgeView(floor: floor, shouldPopToRootView: self.$twoPreRootIsActive)) {
                            Text(String(floor.number))
                        }
                        .isDetailLink(false)
                        .buttonStyle(PlainButtonStyle())
                        .background(
                            Button(action: {
                                userData.floor = floor.id
                            }, label: {
                                EmptyView()
                            })
                        )
                    }
                }
                .navigationTitle(Constants.navigationTitle)
            }
        }
        
        .onAppear {
            if floors.isEmpty {
                database.getAllFloorsInDormitory(dormitoryFloors: dormitory.floors) { floors in
                    self.floors = floors
                    isLoading = false
                }
            }
        }
        
    }
}
