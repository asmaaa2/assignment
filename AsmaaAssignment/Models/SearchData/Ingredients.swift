
import Foundation
struct Ingredients : Codable {
	let text : String?
	let quantity : Double?
	let measure : String?
	let food : String?
	let weight : Double?
	let foodCategory : String?
	let foodId : String?
	let image : String?

	enum CodingKeys: String, CodingKey {

		case text = "text"
		case quantity = "quantity"
		case measure = "measure"
		case food = "food"
		case weight = "weight"
		case foodCategory = "foodCategory"
		case foodId = "foodId"
		case image = "image"
	}


}
