import Foundation

protocol DeleteAllBandsUseCaseProtocol {
    func execute(completionHandler: @escaping (() -> Void))
}

struct DeleteAllBandsUseCase: DeleteAllBandsUseCaseProtocol {
    private let repository: ArtistRepositoryProtocol = ArtistRepository()

    func execute(completionHandler: @escaping (() -> Void)) {
        repository.deleteAllBands(completionHandler: completionHandler)
    }
}
