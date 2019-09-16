import UIKit
import PlaygroundSupport
// Part one: HTTP, URLs, and URL Session

PlaygroundPage.current.needsIndefiniteExecution = true

// Json
// {
//      "appName": "facebook",
//      "downloads": "25",
//      ...
//}

// swiftObject
struct StoreItems: Codable {
    var results: [StoreItem]
}

struct StoreItem: Codable {
    var name: String
    var artist: String
    var kind: String
    var artworkUrl: String
    
    enum CodingKeys:String, CodingKey {
        case name = "trackName"
        case artist = "artistName"
        case kind = "kind"
        case artworkUrl = "artworkUrl100"
    }
    
    init(from decoder: Decoder) throws {
        let values =  try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: CodingKeys.name)
        self.artworkUrl = try values.decode(String.self, forKey: CodingKeys.artworkUrl)
        self.kind = try values.decode(String.self, forKey: CodingKeys.kind)
        self.artist = try values.decode(String.self, forKey: CodingKeys.artist)
    }
}

// url: https://itunes.apple.com/serch?<query-parameters>
// <query-parameters>: key=taylor&count=23
extension URL {
    func withQuerys(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map{URLQueryItem(name: $0.0, value: $0.1)}
        return components?.url
    }
}

func fetchItems(matching query: [String: String], completion: @escaping ([StoreItem]?) -> Void) {
    let baseUrl = URL(string: "https://itunes.apple.com/search?")!
    guard let serchURL = baseUrl.withQuerys(query) else {
        completion(nil)
        print("unable to build URL with supplied queries")
        return
    }
    
    let task = URLSession.shared.dataTask(with: serchURL) { (data, response, error) in
        let decoder = JSONDecoder()
        if let data = data {
            if let storeItems = try? decoder.decode(StoreItems.self, from: data){
                completion(storeItems.results)
            } else {
                print("Either no data was returned, or data was not serialized.")
            }
        }
    }
    task.resume()
}

let query: [String: String] = [
    "term": "seven samurai",
    "media": "movie",
    "lang": "ja_jp",
    "limit": "10",
]

fetchItems(matching: query) { (storeItems) in
    if let items = storeItems {
        print(items)
    }
}
