import Foundation

struct Band {
    let name: String
    let members: [Artist]
    let albums: [Album]
}

extension Band: Identifiable {
    var id: String {
        name
    }
}

extension Band {
    init(dto: BandDTO){
        self.name = dto.name
        
        var memberList: [Artist] = []
        
        for member in dto.members {
            let newArtist = Artist(dto: member)
            memberList.append(newArtist)
        }
        self.members = memberList
        
        var albumList: [Album] = []
        
        for album in dto.albums {
            let newAlbum = Album(dto: album)
            albumList.append(newAlbum)
        }
        self.albums = albumList
    }
}

extension Band {
    func bandName() -> String {
        return name
    }
    
    func bandMembers() -> String{
        let memberNames = members.map { currentMember in
            currentMember.name
        }
        
        let formattedMembersNames = memberNames.joined(separator: ", ")
        return formattedMembersNames
    }
    
    func bandAlbums() -> String{
        let albumsNames = albums.map { currentAlbum in
            currentAlbum.name
        }
        
        let formattedAlbumNames = albumsNames.joined(separator: ", ")
        return formattedAlbumNames
    }
}
