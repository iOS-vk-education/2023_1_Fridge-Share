//
//  NotificationView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.05.2024.
//

import SwiftUI
import FirebaseFirestore
import UserNotifications

struct Notification: View {
    @State private var listOfRequests: [RequestItem] = []
    @State private var listOfAnswers: [AnswerItem] = []
    @State private var filteredListOfAnswers: [AnswerItem] = []
    @State private var products: [ProductData] = []
    private var db = Firestore.firestore()
    private let userId = UserDefaults.standard.string(forKey: "userId") ?? "defaultUserId"

    var body: some View {
        VStack {
            Text("Мои запросы")
                .font(.title)
                .padding(.top, 20)

            List {
                ForEach(listOfRequests, id: \.id) { request in
                    RequestRow(request: request)
                }
                .onDelete(perform: deleteRequest)
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal, 10)

            Divider()

            Text("Мои ответы")
                .font(.title)
                .padding(.top, 20)

            List {
                ForEach(filteredListOfAnswers, id: \.id) { answer in
                    AnswerRow(answer: answer)
                        .onTapGesture {
                            self.answerTapped(answer: answer)
                        }
                }
                .onDelete(perform: deleteAnswer)
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal, 10)
        }
        .onAppear {
        }
    }

    
    private func deleteRequest(at offsets: IndexSet) {
        // Your delete logic here
    }

    private func deleteAnswer(at offsets: IndexSet) {
        // Your delete logic here
    }

    private func answerTapped(answer: AnswerItem) {
        // Your answer tap logic here
    }
}

// Дополнительные структуры для представлений и моделей
struct RequestRow: View {
    let request: RequestItem

    var body: some View {
        HStack {
            Image(request.product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)

            Text(request.product.name)
                .font(.body)

            Text(DateFormatter.localizedString(from: request.product.dateExploration, dateStyle: .short, timeStyle: .none))
                .font(.subheadline)

            if request.result {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 10, height: 10)
            } else {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 10, height: 10)
            }
        }
    }
}

struct AnswerRow: View {
    let answer: AnswerItem

    var body: some View {
        HStack {
            Image(answer.product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)

            Text(answer.product.name)
                .font(.body)

            Text(DateFormatter.localizedString(from: answer.product.dateExploration, dateStyle: .short, timeStyle: .none))
                .font(.subheadline)
        }
    }
}

// Модели запросов и ответов
struct RequestItem: Identifiable {
    var id: String
    let product: ProductData
    let result: Bool

    init(product: ProductData, result: Bool) {
        self.id = UUID().uuidString
        self.product = product
        self.result = result
    }
}

struct AnswerItem: Identifiable {
    var id: String
    let product: ProductData
    var answer: AnswerCase

    init(id: String? = nil, product: ProductData, answer: AnswerCase = .noanswer) {
        self.id = id ?? UUID().uuidString
        self.product = product
        self.answer = answer
    }

    mutating func makeAnswerAgree() {
        answer = .agree
    }

    mutating func makeAnswerDisagree() {
        answer = .disagree
    }
}

enum AnswerCase: String, Codable {
    case agree = "agree"
    case disagree = "disagree"
    case noanswer = "noanswer"
}

func requestNotificationAuthorization() {
    
    let nc = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    
    nc.requestAuthorization(options: options) { granted, _ in
        print("\(#function) Permission granted: \(granted)")
        guard granted else { return }
    }
}
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("User granted permission for notifications")
                UNUserNotificationCenter.current().delegate = self
            } else {
                print("User denied permission for notifications")
            }
        }
        application.registerForRemoteNotifications()
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device token:", token)
        // Send this device token to your server
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications:", error.localizedDescription)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Handle notification when app is in foreground
        completionHandler([.banner, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle user's response to the notification
        completionHandler()
    }
}
