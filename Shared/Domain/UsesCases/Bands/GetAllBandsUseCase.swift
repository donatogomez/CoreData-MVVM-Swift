import Foundation

protocol GetAllBandsUseCaseProtocol {
    func execute(completionHandler: @escaping (([Band]) -> Void))
}

struct GetAllBandsUseCase: GetAllBandsUseCaseProtocol {
    private let repository: ArtistRepositoryProtocol = ArtistRepository()
    
    func execute(completionHandler: @escaping (([Band]) -> Void)) {
        repository.getAllBands(completionHandler: completionHandler)
    }
}
