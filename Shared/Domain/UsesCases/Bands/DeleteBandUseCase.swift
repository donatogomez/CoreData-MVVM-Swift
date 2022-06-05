import Foundation

protocol DeleteBandUseCaseProtocol {
    func execute(bandId: [String], completionHandler: @escaping (([String]) -> Void))
}

struct DeleteBandUseCase: DeleteBandUseCaseProtocol {
    private let repository: ArtistRepositoryProtocol = ArtistRepository()
    
    func execute(bandId: [String], completionHandler: @escaping (([String]) -> Void)) {
        repository.deleteBand(bandId: bandId, completionHandler: completionHandler)
    }
}
