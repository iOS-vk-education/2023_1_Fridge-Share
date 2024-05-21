import SwiftUI

struct SearchView: View {
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
            .navigationTitle("Ищем продукт")
            .onAppear {
                database.getAllProducts()
            }
        }
    }
    
    var searchResults: [ProductData] {
        let lowercasedSearchText = searchText.lowercased()
        
        if searchText.isEmpty {
            if let selectedCategory = selectedCategory {
                return database.products.filter { $0.category == selectedCategory }
            } else {
                return database.products
            }
        } else {
            if let selectedCategory = selectedCategory {
                return database.products.filter { $0.name.lowercased().contains(lowercasedSearchText) && $0.category == selectedCategory }
            } else {
                return database.products.filter { $0.name.lowercased().contains(lowercasedSearchText) }
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
        "Фрукты и овощи", "Готовая еда", "Соусы", "Напитки"
    ]
    
    @Binding var selectedCategory: String?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Категории")
                .font(.headline)
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom)
            
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 145), spacing: 5)], spacing: 10) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(selectedCategory == category ? Color.blue : Color(.systemGray6))
                            .foregroundColor(selectedCategory == category ? .white : .primary)
                            .cornerRadius(20)
                            .onTapGesture {
                                if selectedCategory == category {
                                    selectedCategory = nil // Сбрасываем фильтр при повторном нажатии на выбранную категорию
                                } else {
                                    selectedCategory = category
                                }
                            }
                    }
                }
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
