### State and Observable Class:
Class can reference as @State with the @Observable wrapper. We instantiate the class in State declaration and share the same instance to get/set data easily with other areas.

The code is from 100 days of swiftUI's project 7, iExpense (<a href="./Apps/./iExpense-7/">iExpense7</a>)

We're using AddView as .sheet view inside ContentView and Passed Expenses Instance to AddView from ContentView, which is used to append new item from the `AddView` Struct. Also `didSet` `property observer` defined in Expenses Class is used to to store the updated values in `User Defaults` Storage after the append operation inside AddView. Which we read back when the app first load (instantiation in @State definition of Expenses() in ContentView will call the init block of Expense Class).

```swift
/* ContentView.swift */
let EXPENSES_USER_DEFAULT_KEY = "EXPENSES_USER_DEFAULT_KEY"

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
//                    Text(item.name)
                    HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                        
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        // also possible with @Environment(\.locale)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    //                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    //                    expenses.items.append(expense)
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    // empty array can also possible like -> items = [ExpenseItem](), type will be infered automatically
    var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: EXPENSES_USER_DEFAULT_KEY)
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: EXPENSES_USER_DEFAULT_KEY) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
            
            items = []
        }
    }
}
```

```swift
// AddView.swift
struct AddView: View {
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    // expense instance will be injected through the ContentView, so appending will reflect there as well
    
    let types = ["Business", "Personal"]
    
    @Environment(\.locale) private var local
    @Environment(\.dismiss) private var dismissThisView
    
    var body: some View {
        NavigationStack {
            Form {
                
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: local.currency?.identifier ?? "USD")) // user's local currency code
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item) // expense instance is injected through the ContentView, so appending will reflect there
                    dismissThisView()
                    
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
```

### Property Getter/Setter and Observers:
```swift
var backingProperty = "Hello World" // a stored property to use as backingField

// Note: Custom getter/setter is for working with backing property
var propGetSet: String {
    get {
        return "Swift \(backingProperty)"
        // return can be ommited as
        // If the entire body of the function is a single expression, the function implicitly returns that expression
    }
    
    set { // or set (newValue), newValue is available in both case
        backingProperty = "\(backingProperty + newValue)"
    }
}

var propObserver = "SomeValue" {
    willSet {
        print("Will call before setting and propObserver = \(propObserver)")
    }
    didSet {
        print("will call after setting and propObserver = \(propObserver)")
    }
}
```