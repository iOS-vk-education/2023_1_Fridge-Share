import SwiftUI
import FirebaseFirestore
import UserNotifications

struct Notification: View {
    @State private var products: [ProductData] = []
    private let userId = UserDefaults.standard.string(forKey: "userId") ?? "defaultUserId"

    @StateObject private var database = FireBase.shared
    
    var body: some View {
        VStack {
            Text("Мои запросы")
                .font(.title)
                .padding(.top, 20)

            List {
                ForEach(myRequests, id: \.id) { request in
                    MyRequestRowView(request: request)
                }
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal, 10)
//            .onAppear {
//                database.getMyRequests(userId: userId)
//            }

            Divider()

            Text("Мои ответы")
                .font(.title)
                .padding(.top, 20)

            List {
                ForEach(myAnswers, id: \.id) { answer in
                    MyAnswersRowView(request: answer)
                }
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal, 10)
//            .onAppear {
//                database.getMyAnswers(userId: userId)
//            }
        }
        .onAppear {
            database.getAllRequests()
        }
    }

    var myRequests: [RequestData] {
        return database.requests.filter({ $0.customerId == userId })
//        return database.myRequests
    }
    
    var myAnswers: [RequestData] {
        return database.requests.filter({ $0.ownerId == userId && $0.status == statusOfRequest.waiting.rawValue })
//        return database.myAnswers
    }
    
    private func deleteRequest(at offsets: IndexSet) {
        // Your delete logic here
    }

    private func deleteAnswer(at offsets: IndexSet) {
        // Your delete logic here
    }

//    private func answerTapped(answer: AnswerItem) {
//        // Your answer tap logic here
//    }
    
    private func loadRequests() {
        guard database.requests.isEmpty else { return }
        
        database.getAllRequests()
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

