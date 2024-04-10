import Foundation

class ViewModel: ObservableObject {
    
    let accessToken = "BQDB3Aa8NjQIpm2xB7F0-XVVeVKa3P_dLVpEIaF63MeKrFg2ZVuFLD-5zIc5tDIAED_7fnwgLxIpZ3BlQZQ7xMwokytH4n4ZN8i15RYC24tndHW3R-U"

    func fetchData(searchTerm: String, completion: @escaping (SearchResponse?) -> Void) {
        guard let encodedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Erro ao codificar o termo de pesquisa")
            completion(nil)
            return
        }
        
        let urlString = "https://api.spotify.com/v1/search?q=\(encodedSearchTerm)&type=track&offset=0"
        guard let spotifyAPIURL = URL(string: urlString) else {
            print("Erro ao construir a URL da API")
            completion(nil)
            return
        }

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
                let result = try JSONDecoder().decode(SearchResponse.self, from: data)
                completion(result)
            } catch {
                print("Erro ao decodificar JSON: \(error)")
                completion(nil)
            }
        }

        task.resume()
    }
}
