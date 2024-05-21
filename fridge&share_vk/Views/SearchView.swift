import SwiftUI

struct SearchView: View {
    private enum Constants {
        static let navigationTitle = "Ищем продукт"
    }
    
    @State private var searchText = ""
    @State private var isShowingCategories = false
    @State var selectedCategory: String?
    
    @StateObject var database = FireBase.shared
    
    var body: some View {
        
        NavigationStack {
            VStack {
                SearchFilterBar(text: $searchText, isShowingCategories: $isShowingCategories)
                
                if isShowingCategories {
                    CategoriesFilterView(selectedCategory: $selectedCategory)
                }
                
                Spacer()
                
                List {
                    ForEach(searchResults, id: \.self) { product in
                        NavigationLink {
                            OneProductView(product: product)
                        } label: {
                            ProductRowView(product: product)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle(Constants.navigationTitle)
            .onAppear {
                database.getAllProducts()
            }
        }
        
        
    }
    
    var searchResults: [ProductData] {
        if searchText.isEmpty {
            if let selectedCategory = selectedCategory {
                if selectedCategory == "Сбросить фильтры" {
                    return database.products
                }
                return database.products.filter { $0.category == selectedCategory }
            } else {
                return database.products
            }
        } else {
            if let selectedCategory = selectedCategory {
                if selectedCategory == "Сбросить фильтры" {
                    return database.products.filter { $0.name.contains(searchText) }
                }
                return database.products.filter { $0.name.contains(searchText) && $0.category == selectedCategory }
            } else {
                return database.products.filter { $0.name.contains(searchText) }
            }
        }
    }


}

struct SearchFilterBar: View {
    @Binding var text: String
    @Binding var isShowingCategories: Bool

    var body: some View {
        HStack {
            TextField("что хотите найти?", text: $text) {
                UIApplication.shared.endEditing()
            }
                .dismissKeyboardOnTap()
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary, lineWidth: 1)
                )
                .onTapGesture {
                    if text == "что хотите найти?" {
                        text = ""
                    }
                }
            
            Button(action: {
                self.isShowingCategories.toggle()
            }) {
                Image(systemName: "slider.horizontal.3")
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct CategoriesFilterView: View {
    let categories = [
        "Молоко и яйца", "Сладкое", "Мясо и рыба",
        "Фрукты и овощи", "Соусы", "Готовая еда", "Напитки",
        "Сбросить фильтры"
    ]
    
    @Binding var selectedCategory: String?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Категории")
                .font(.headline)
                .padding(.horizontal)
                .padding(.top)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 5)], spacing: 10) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(selectedCategory == category ? Color.blue : Color(.systemGray6))
                            .foregroundColor(selectedCategory == category ? .white : .primary)
                            .cornerRadius(20)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


struct DismissKeyboardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                self.dismissKeyboard()
            }
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func dismissKeyboardOnTap() -> some View {
        self.modifier(DismissKeyboardModifier())
    }
}
