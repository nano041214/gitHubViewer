import Foundation
import Himotoki

struct Activity {
    let name: String
    let descriptionString: String
}

extension Activity: Decodable {
    static func decode(extractor: Extractor) throws -> Activity {
        return try Activity(name: extractor <| "login",
                            descriptionString: extractor <| ["repository", "name"])
    }
}
