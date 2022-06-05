import Foundation

protocol ArtistLocalDSProtocol {
    func getAllBands(completionHandler: @escaping (([BandDTO]) -> Void))
    func saveBand(band: BandDTO, completionHandler: @escaping ((BandDTO) -> Void))
    func deleteAllBands(completionHandler: @escaping (() -> Void))
    func deleteBand(bandId: [String], completionHandler: @escaping (([String]) -> Void))
}
    
struct ArtistLocalDS: ArtistLocalDSProtocol {

    private let pController: PersistenceControllerProtocol = PersistenceController.shared
    
    func getAllBands(completionHandler: @escaping (([BandDTO]) -> Void)) {
        pController.getAllBands(completionHandler: completionHandler)
    }
    
    func saveBand(band: BandDTO, completionHandler: @escaping ((BandDTO) -> Void)) {
        pController.saveBand(band: band, completionHandler: completionHandler)
    }
    
    func deleteAllBands(completionHandler: @escaping (() -> Void)) {
        pController.deleteAllBands(completionHandler: completionHandler)
    }
    
    func deleteBand(bandId: [String], completionHandler: @escaping (([String]) -> Void)) {
        pController.deleteBand(bandId: bandId, completionHandler: completionHandler)
    }
}
