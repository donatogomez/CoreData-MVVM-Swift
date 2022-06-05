import Foundation

class ContentViewModel: ObservableObject {
    
    @Published var bands: [Band] = []
    
    private let getAllBands: GetAllBandsUseCaseProtocol = GetAllBandsUseCase()
    private let saveBand: SaveBandUseCaseProtocol = SaveBandUseCase()
    private let deleteAllBand: DeleteAllBandsUseCaseProtocol = DeleteAllBandsUseCase()
    private let deleteBand: DeleteBandUseCaseProtocol = DeleteBandUseCase()
    
    func getSavedArtists() {
        getAllBands.execute(completionHandler: { retrievedBand in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.bands = retrievedBand
            }
        })
    }
    
    func saveNewBand (band: Band) {
        saveBand.execute(band: band, completionHandler: { saveBandData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.bands.append(saveBandData)
            }
        })
    }
    
    func removeAllBands() {
        deleteAllBand.execute(completionHandler: {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.bands = []
            }
        })
    }
    
    func removeBand(bandId: [String]) {
        deleteBand.execute(bandId: bandId, completionHandler: { removedBandId in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.bands = self.bands.filter { !removedBandId.contains($0.id)}
            }
        })
    }
}
    
