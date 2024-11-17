import SwiftUI
import Foundation

// MARK: Food Search View
struct FoodSearchView: View {
    
    @EnvironmentObject var edp: ExerciseDataProvider
    @State private var measurementSystem: MeasurementSystem?
    @State private var foodName: String = ""
    @State private var nutritionData: [Nutrition] = []
    @State private var foodList: [String] = []
    @State private var suggestions: [String] = []
    @State private var showSuggestions: Bool = false
    @State private var quantityText: String = ""
    @State private var quantity: Double = 0
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    TextField("Food", text: $foodName)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: foodName) {
                            if foodName.count > 0 {
                                suggestions = foodList.filter { $0.lowercased().hasPrefix(foodName.lowercased()) }
                                showSuggestions = !suggestions.isEmpty
                            } else {
                                showSuggestions = false
                            }
                        }
                    Spacer()
                    TextField("Quantity", text: $quantityText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 30)
                        .padding(.trailing, 20)
                    Text(measurementSystem?.rawValue == "Metric" ? "grams" : "pounds")
                        .withTextFormatting()
                }
                // MARK: Dropdown Menu: Food Suggestions.
                if showSuggestions {
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(suggestions, id: \.self) { suggestion in
                                Text(suggestion)
                                    .withTextFormatting()
                                    .onTapGesture {
                                        foodName = suggestion
                                        showSuggestions = false
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxHeight: 100)
                }
                
                // MARK: Search Button.
                Button("Search") {
                    Task {
                        let quantity = Double(quantityText) ?? 0.0
                        do {
                            nutritionData = try await getNutritionData(foodQuery: foodName, quantityQuery: quantity, measurementSystem: measurementSystem!)
                        } catch {
                            print("Error: \(error)")
                        }
                    }
                }
                .padding()
                
                // MARK: Nutrition Data.
                List(nutritionData, id: \.name) { item in
                    VStack(alignment: .leading) {
                        Text("Name: \(item.name)")
                            .font(.headline)
                        if let fatTotalG = item.fatTotalG {
                            Text("Total Fat: \(fatTotalG) g")
                        }
                        if let fatSaturatedG = item.fatSaturatedG {
                            Text("Saturated Fat: \(fatSaturatedG) g")
                        }
                        if let sodiumMg = item.sodiumMg {
                            Text("Sodium: \(sodiumMg) mg")
                        }
                        if let potassiumMg = item.potassiumMg {
                            Text("Potassium: \(potassiumMg) mg")
                        }
                        if let cholesterolMg = item.cholesterolMg {
                            Text("Cholesterol: \(cholesterolMg) mg")
                        }
                        if let carbohydratesTotalG = item.carbohydratesTotalG {
                            Text("Total Carbohydrates: \(carbohydratesTotalG) g")
                        }
                        if let fiberG = item.fiberG {
                            Text("Fiber: \(fiberG) g")
                        }
                        if let sugarG = item.sugarG {
                            Text("Sugar: \(sugarG) g")
                        }
                    }
                }
                if !nutritionData.isEmpty {
                    Button(action: {
                        addButtonPressed()
                    }) {
                        Text("Add Food")
                            .withButtonFormatting()
                    }
                }
            }
            .padding()
        }
        .onAppear {
            measurementSystem = edp.getMeasurementSystem()
            loadFoodList()
        }
    } // End of ZStack
    // MARK: Load Food List (food.txt)
    private func loadFoodList() {
        if let fileURL = Bundle.main.url(forResource: "food", withExtension: "txt") {
            do {
                let contents = try String(contentsOf: fileURL)
                foodList = contents.components(separatedBy: .newlines).filter { !$0.isEmpty }
            } catch {
                print("Error loading food list: \(error)")
            }
        }
    }
    private func addButtonPressed() {
        print("add food")
    }
}


// Nutrition
struct Nutrition: Codable {
    let name: String
    let fatTotalG: Double?
    let fatSaturatedG: Double?
    let sodiumMg: Double?
    let potassiumMg: Double?
    let cholesterolMg: Double?
    let carbohydratesTotalG: Double?
    let fiberG: Double?
    let sugarG: Double?
    
    enum CodingKeys: String, CodingKey {
            case name
            case fatTotalG = "fat_total_g"
            case fatSaturatedG = "fat_saturated_g"
            case sodiumMg = "sodium_mg"
            case potassiumMg = "potassium_mg"
            case cholesterolMg = "cholesterol_mg"
            case carbohydratesTotalG = "carbohydrates_total_g"
            case fiberG = "fiber_g"
            case sugarG = "sugar_g"
        }
}

// Get Nutrition Data
func getNutritionData(foodQuery: String, quantityQuery: Double, measurementSystem: MeasurementSystem) async throws -> [Nutrition] {
    
    let apiKey = "Xn/MQIMA2BR7blu1AatZAA==rnUm3JEJ1n7UhXzD"
    let encodedFoodQuery = foodQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let unit = measurementSystem.rawValue.lowercased() == "metric" ? "g" : "lb"
    let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query=\(quantityQuery)\(unit) \(encodedFoodQuery)")! // ADD TEHM TO QUERY
    
    var request = URLRequest(url: url)
    request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw NSError(domain: "InvalidResponse", code: 1, userInfo: nil)
    }
    
    let decoder = JSONDecoder()
    return try decoder.decode([Nutrition].self, from: data)
}
