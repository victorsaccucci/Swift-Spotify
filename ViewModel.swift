import Foundation

class ViewModel: ObservableObject {

    let spotifyAPIURL = URL(string: "https://api.spotify.com/v1/tracks?ids=7ouMYWpwJ422jRcDASZB7P%2C4VqPOruhp5EdPBeR92t6lQ%2C2takcwOaAZWiXQijPHIx7B")!

    let accessToken = "BQCpKbIay1Cm3eziKpZW0nT0O-cJ5EfhlJ_3J9N8AKNnPhnDbT8vlZmk_mrSGp37Ugh_nITwC3rbjNioNSULQ6btu5JR4GNbTtcVArdF-yTFrrm7ISA"

    func fetchData(completion: @escaping ([Track]?) -> Void) {
        var request = URLRequest(url: spotifyAPIURL)
        request.httpMethod = "GET"

        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Erro ao obter os dados: \(error?.localizedDescription ?? "Erro desconhecido")")
                completion(nil)
                return
            }

            do {
                let result = try JSONDecoder().decode([String: [Track]].self, from: data)
                if let tracks = result["tracks"] {
                    completion(tracks)
                } else {
                    print("Não foi possível encontrar as faixas no JSON")
                    completion(nil)
                }
            } catch {
                print("Erro ao decodificar JSON: \(error)")
                completion(nil)
            }
        }

        task.resume()
    }
}
