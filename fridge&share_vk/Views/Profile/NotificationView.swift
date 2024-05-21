import SwiftUI
import FirebaseFirestore
import UserNotifications

struct Notification: View {
    @State private var products: [ProductData] = []
    private let userId = UserDefaults.standard.string(forKey: "userId") ?? "defaultUserId"

    @StateObject private var database = FireBase.shared
    
    init() {
            loadProducts()
        }
    
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
            loadProducts()

        }
    }
    
    private func loadProducts() {
                self.scheduleNotificationsForProducts()
        }
        
        private func scheduleNotificationsForProducts() {
            for product in products {
                scheduleNotification(for: product)
            }
        }
        
        private func scheduleNotification(for product: ProductData) {
            print("Scheduling notification for product: \(product.name)")

            let content = UNMutableNotificationContent()
            content.title = "Срок годности истекает"
            content.body = "Срок годности продукта \(product.name) истекает через 2 дня."
            content.sound = UNNotificationSound.default

            let calendar = Calendar.current
            let triggerDate = calendar.date(byAdding: .day, value: -2, to: product.dateExploration) ?? Date()
            let triggerComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: triggerDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)

            let request = UNNotificationRequest(identifier: product.id, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error adding notification: \(error.localizedDescription)")
                }
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

