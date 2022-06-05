import Foundation

protocol SaveBandUseCaseProtocol {
    func execute(band: Band, completionHandler: @escaping ((Band) -> Void))
}

struct SaveBandUseCase: SaveBandUseCaseProtocol {
    private let repository: ArtistRepositoryProtocol = ArtistRepository()
    
    func execute(band: Band, completionHandler: @escaping ((Band) -> Void)) {
        repository.saveBand(band: band, completionHandler: completionHandler)
    }
}
