import Foundation
struct Recipe : Codable {
	let label : String?
	let image : String?
	let source : String?
	let url : String?
	let shareAs : String?
	let dietLabels : [String]?
	let healthLabels : [String]?
	let ingredientLines : [String]?
	let ingredients : [Ingredients]?

	enum CodingKeys: String, CodingKey {

		case label = "label"
		case image = "image"
		case source = "source"
		case url = "url"
		case shareAs = "shareAs"
		case dietLabels = "dietLabels"
		case healthLabels = "healthLabels"
		case ingredientLines = "ingredientLines"
		case ingredients = "ingredients"
		
	}


}
