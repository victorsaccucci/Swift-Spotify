import SwiftUI

struct MusicasView: View {
    @StateObject var viewModel = ViewModel()
    @State private var tracks: [TrackItem] = []
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack {
                    Text("World Music")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.top)
                    HStack {
                        TextField("Digite o nome da música", text: $searchTerm)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {
                            viewModel.fetchData(searchTerm: searchTerm) { searchResponse in
                                if let searchResponse = searchResponse {
                                    self.tracks = searchResponse.tracks.items
                                } else {
                                    
                                }
                            }
                        }) {
                            Text("Buscar")
                                .padding(.horizontal)
                                .padding(.vertical, 7.5)
                                .background(Color.white.opacity(0.6))
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                    }
                    .padding(30)
                    Spacer()
                    if tracks.isEmpty {
                        Text("Carregando músicas...")
                            .foregroundColor(.white)
                    } else {
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 20) {
                                ForEach(tracks.prefix(20), id: \.name) { track in
                                    NavigationLink(destination: DetalheMusicaView(track: track)) {
                                        HStack(spacing: 20) {
                                            if let imageURL = URL(string: track.album.images.first?.url ?? "") {
                                                AsyncImage(url: imageURL) { phase in
                                                    if let image = phase.image {
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 80, height: 80)
                                                            .shadow(radius: 10)
                                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                                    } else if phase.error != nil {
                                                        Text("Erro ao carregar a imagem")
                                                            .foregroundColor(.white)
                                                    } else {
                                                        ProgressView()
                                                    }
                                                }
                                                .frame(width: 80, height: 80)
                                            }
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text(track.name)
                                                    .foregroundColor(.white)
                                                    .font(.headline)
                                                ForEach(track.artists, id: \.name) { artist in
                                                    Text(artist.name)
                                                        .foregroundColor(.white)
                                                        .font(.subheadline)
                                                }
                                            }
                                            
                                            Spacer()
                                        }
                                        .padding(.horizontal)
                                    }
                                    
                                }
                            }
                            .padding(.top, 20)
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    MusicasView()
}
