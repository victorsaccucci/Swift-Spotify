import SwiftUI

struct MusicasView: View {
    @StateObject var viewModel = ViewModel()
    @State private var tracks: [Track] = []
    @State private var searchTerm: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
                Text("World Muisc")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top)
                HStack {
                    TextField("Digite o nome da música", text: $searchTerm)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        // Ação de busca
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
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(tracks.prefix(3), id: \.name) { track in
                                VStack {
                                    if let imageURL = URL(string: track.album.images.first?.url ?? "") {
                                        GeometryReader { geometry in
                                            AsyncImage(url: imageURL) { phase in
                                                if let image = phase.image {
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: geometry.size.width, height: geometry.size.width)
                                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                                } else if phase.error != nil {
                                                    Text("Erro ao carregar a imagem")
                                                        .foregroundColor(.white)
                                                } else {
                                                    ProgressView()
                                                }
                                            }
                                        }
                                        .frame(width: 200, height: 300)
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(track.name)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            ForEach(track.album.artists, id: \.name) { artist in
                                                Text(artist.name)
                                                    .foregroundColor(.white)
                                                    .font(.subheadline)
                                            }
                                        }
                                        .padding()
                                    }
                                }
                                .padding()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchData { loadedTracks in
                if let loadedTracks = loadedTracks {
                    self.tracks = loadedTracks
                } else {
                }
            }
        }
    }
}
#Preview {
    MusicasView()
}
