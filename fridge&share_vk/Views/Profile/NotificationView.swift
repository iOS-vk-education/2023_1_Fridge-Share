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
        }
        .onAppear {
            database.getAllRequests()
            scheduleRegularNotifications()
        }
    }
    
    var myRequests: [RequestData] {
        return database.requests.filter({ $0.customerId == userId })
    }
    
    var myAnswers: [RequestData] {
        return database.requests.filter({ $0.ownerId == userId && $0.status == statusOfRequest.waiting.rawValue })
    }
    
    private func loadRequests() {
        guard database.requests.isEmpty else { return }
        
        database.getAllRequests()
    }
    
    private func scheduleRegularNotifications() {
            let content = UNMutableNotificationContent()
            content.title = "Напоминание"
            content.body = "Проверьте сроки годности продуктов."
            content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60 * 3, repeats: true)

            let request = UNNotificationRequest(identifier: "regularCheck", content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error adding regular notification: \(error.localizedDescription)")
                }
            }
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

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("User granted permission for notifications")
                UNUserNotificationCenter.current().delegate = self
            } else {
                print("User denied permission for notifications")
            }
            UNUserNotificationCenter.current().delegate = self
        }
        application.registerForRemoteNotifications()
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
