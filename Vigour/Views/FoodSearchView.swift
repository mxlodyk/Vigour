import SwiftUI
import Foundation

struct NutritionView: View {
    
    @State private var foodName: String = ""
    @State private var nutritionData: [Nutrition] = []
    
    var body: some View {
        VStack {
            TextField("Enter food name", text: $foodName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Search") {
                Task {
                    do {
                        nutritionData = try await getNutritionData(query: foodName)
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
            .padding()
            
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
                .padding(.vertical, 4)
            }
        }
        .padding()
    }
}

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

func getNutritionData(query: String) async throws -> [Nutrition] {
    let apiKey = "Xn/MQIMA2BR7blu1AatZAA==rnUm3JEJ1n7UhXzD"
    let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query=\(encodedQuery)")!
    
    var request = URLRequest(url: url)
    request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw NSError(domain: "InvalidResponse", code: 1, userInfo: nil)
    }
    
    let decoder = JSONDecoder()
    return try decoder.decode([Nutrition].self, from: data)
}

#Preview {
    NutritionView()
}
