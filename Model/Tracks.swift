import Foundation

import Foundation

struct Track: Decodable {
    struct Album: Decodable {
        let images: [Image]
        let artists: [Artists]
    }
    
    struct Image: Decodable {
        let url: String
    }
    
    struct Artists: Decodable {
        let name: String
    }
    
    let name: String
    let album: Album
}

