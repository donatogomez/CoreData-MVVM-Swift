import Foundation

struct BandDTO {
    let id: String
    let name: String
    let members: [ArtistDTO]
    let albums: [AlbumDTO]
}

extension BandDTO {
    init(domain: Band) {
        self.id = domain.id
        self.name = domain.name
        self.members = domain.members.map { currentArtist in
            ArtistDTO(domain: currentArtist)
        }
        self.albums = domain.albums.map { currentArtist in
            AlbumDTO(domain: currentArtist)
        }
    }
}

extension BandDTO {
    init(cd: CDBand) {
        
        self.id = cd.id ?? ""
        self.name = cd.name ?? ""
        
        let retrievedArtist = cd.members?.allObjects ?? []

        let cdArtistArray = retrievedArtist
            .compactMap { currentAny in
                currentAny as? CDArtist
        }
        self.members = cdArtistArray.map { currentCDArtist in
            ArtistDTO(cd: currentCDArtist)
        }
        
        let retrievedAlbum = cd.albums?.allObjects ?? []
        
        let cdAlbumsArray = retrievedAlbum
            .compactMap { currentAny in
                currentAny as? CDAlbum
        }
        self.albums = cdAlbumsArray.map { currentCDAlbum in
            AlbumDTO(cd: currentCDAlbum)
        }
    }
}
