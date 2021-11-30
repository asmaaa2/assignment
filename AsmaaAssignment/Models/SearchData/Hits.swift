
import Foundation
struct Hits : Codable {
    let recipe : Recipe?

	enum CodingKeys: String, CodingKey {

		case recipe = "recipe"
	}


}
