import SwiftUI

struct DetalheMusicaView: View {
    var track: TrackItem
    
    var body: some View {
        VStack {
            Text(track.name)
                .font(.title)
                .foregroundColor(.white)
            Text("Artistas:")
                .font(.headline)
                .foregroundColor(.white)
            ForEach(track.artists, id: \.id) { artist in
                Text(artist.name)
                    .foregroundColor(.white)
            }
            
           
        }
        .padding()
        .navigationBarTitle(track.name, displayMode: .inline)
    }
}
