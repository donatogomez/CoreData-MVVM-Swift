import Foundation

struct Artist {
    let name: String
    let birthDate: Date
}

extension Artist: Identifiable {
    var id: String {
        name
    }
}

extension Artist {
    init(dto: ArtistDTO){
        self.name = dto.name
        self.birthDate = dto.birthDate
    }
}

extension Artist {
    func memberName() -> String {
        return name
    }
}
