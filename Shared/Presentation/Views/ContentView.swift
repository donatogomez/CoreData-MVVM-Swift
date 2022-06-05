import SwiftUI
import CoreData

struct ContentView: View {
    
    @ObservedObject private var viewModel = ContentViewModel()
    @State private var showAlert = false
    
    let bandNames: [String] = [
        "Queen",
        "Rolling Stones",
        "The Beatles",
        "AC/DC",
        "Led Zeppelin",
        "Gun N' Roses",
        "Metallica",
        "REM",
        "U2",
        "Nirvana"
    ]
    
    let memberNames: [String] = [
        "Mick Jagger",
        "Freddie Mercury",
        "Bono",
        "Pink Floyd",
        "John Lenon",
        "Paul McCartney",
        "Jimi Hendrix",
        "Kurt Kobain",
        "Bob Dylan",
        "Elvis Presley"
    ]
    
    let albumNames: [String] = [
        "Thriller",
        "Back in Black",
        "The Dark Side",
        "The Bodyguard",
        "Rumours",
        "Saturday Night Ferver",
        "El Fantasma de la Ópera",
        "Come On Over",
        "T.N.T.",
        "Space Oddity"
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.bands) { band in
                    NavigationLink("\(band.bandName())") {
                        List {
                            NavigationLink("Albums") {
                                List{
                                    ForEach(band.albums){ album in
                                        Text("\(album.name)")
                                    }
                                }
                            }
                            NavigationLink("Members") {
                                List{
                                    ForEach(band.members){ member in
                                        Text("\(member.name)")
                                    }
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Delete All"),
                              message: Text("Are you sure you want to delete all bands?"),
                              primaryButton: .destructive(Text("Delete")) {
                            viewModel.removeAllBands()
                        },
                              secondaryButton: .cancel())
                    }
                }
                
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
        .onAppear {
            viewModel.getSavedArtists()
        }
    }
    
    private func addItem() {
        withAnimation {
            let nameIndex = Int.random(in: 0..<4)
            let randName = Int.random(in: 0..<1_000)
            
            let memberOneIndex = Int.random(in: 0..<memberNames.count)
            let memberTwoIndex = Int.random(in: 0..<memberNames.count)
            
            let members = [
                Artist(name: memberNames[memberOneIndex], birthDate: Date()),
                Artist(name: memberNames[memberTwoIndex], birthDate: Date())
            ]
            
            let albumOneIndex = Int.random(in: 0..<albumNames.count)
            let albumTwoIndex = Int.random(in: 0..<albumNames.count)
        
            let albums = [
                Album(name: albumNames[albumOneIndex]),
                Album(name: albumNames[albumTwoIndex])
            ]
            
            let newBand = Band(name: "\(randName) - \(bandNames[nameIndex])", members: members, albums: albums)
            viewModel.saveNewBand(band: newBand)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            let bandsToRemove = offsets.map {
                viewModel.bands[$0].id
            }
            viewModel.removeBand(bandId: bandsToRemove)
        }
    }
}
