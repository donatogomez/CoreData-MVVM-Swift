import Foundation

protocol ArtistRepositoryProtocol {
    
    func getAllBands(completionHandler: @escaping (([Band]) -> Void))
    func saveBand(band: Band, completionHandler: @escaping ((Band) -> Void))
    func deleteAllBands(completionHandler: @escaping (() -> Void))
    func deleteBand(bandId: [String], completionHandler: @escaping (([String]) -> Void))
}

struct ArtistRepository: ArtistRepositoryProtocol {
    
    private let localDataSource: ArtistLocalDSProtocol = ArtistLocalDS()
    
    func getAllBands(completionHandler: @escaping (([Band]) -> Void)){
        localDataSource.getAllBands(completionHandler: { bandsDtos in
            let domainBands = bandsDtos.map { currentBandDto in
                Band(dto: currentBandDto)
            }
            completionHandler(domainBands)
        })
    }
    
    func saveBand(band: Band, completionHandler: @escaping ((Band) -> Void)) {
        localDataSource.saveBand(band: BandDTO(domain: band),
                             completionHandler: { bandDto in
            completionHandler(Band(dto: bandDto))
        })
    }
    
    func deleteAllBands(completionHandler: @escaping (() -> Void)) {
        localDataSource.deleteAllBands(completionHandler:completionHandler)
    }
    
    func deleteBand(bandId: [String], completionHandler: @escaping (([String]) -> Void)) {
        localDataSource.deleteBand(bandId: bandId, completionHandler: completionHandler)
    }
}
