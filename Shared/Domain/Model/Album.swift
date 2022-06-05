import Foundation

struct Album {
    let name: String
}

extension Album: Identifiable {
    var id: String {
        name
    }
}

extension Album {
    init(dto: AlbumDTO){
        self.name = dto.name
    }
}

extension Album {
    func albumName() -> String {
        return name
    }
}
