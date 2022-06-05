import CoreData

protocol PersistenceControllerProtocol {
    func getAllBands(completionHandler: @escaping (([BandDTO]) -> Void))
    func saveBand(band: BandDTO, completionHandler: @escaping ((BandDTO) -> Void))
    func deleteAllBands(completionHandler: @escaping (() -> Void))
    func deleteBand(bandId: [String], completionHandler: @escaping (([String]) -> Void))
}

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ArtistsZero")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension PersistenceController: PersistenceControllerProtocol {
    
    func getAllBands(completionHandler: @escaping (([BandDTO]) -> Void)) {
        container.performBackgroundTask { privateMOC in
            let request = CDBand.fetchRequest()
            request.predicate = nil
            
            var retrievedBands: [CDBand] = []
            
            do {
                retrievedBands = try privateMOC.fetch(request)
            } catch {
                print("F: \(error)")
                completionHandler([])
            }
            
            let transformsDtos = retrievedBands.map { currentCDBand in
                BandDTO(cd:  currentCDBand)
            }
            
            completionHandler(transformsDtos)
        }
    }
    
    func saveBand(band: BandDTO, completionHandler: @escaping ((BandDTO) -> Void)) {
        container.performBackgroundTask { privateMOC in
            let request = CDBand.fetchRequest()
            request.predicate = nil
            
            let newBand = CDBand(context: privateMOC)
            newBand.name = band.name
            newBand.id = band.id
            
            band.members.forEach { currentArtistDto in
                let newArtist = CDArtist(context: privateMOC)
                newArtist.name = currentArtistDto.name
                newArtist.birthDate = currentArtistDto.birthDate
                newArtist.addToBelongs(newBand)
            }
            band.albums.forEach { currentAlbumDto in
                let newAlbum = CDAlbum(context: privateMOC)
                newAlbum.name = currentAlbumDto.name
                newAlbum.addToBelongs(newBand)
            }
            
            do {
                try privateMOC.save()
            } catch {
                print("F: \(error)")
            }
            
            completionHandler(band)
        }
    }
    
    func deleteAllBands(completionHandler: @escaping (() -> Void)) {
        container.performBackgroundTask{ privateMOC in
            let request: NSFetchRequest<NSFetchRequestResult> = CDBand.fetchRequest()
            request.predicate = nil
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            
            do {
                try privateMOC.execute(deleteRequest)
            } catch {
                print("F: \(error)")
            }
            completionHandler()
        }
    }
    
    func deleteBand(bandId: [String], completionHandler: @escaping (([String]) -> Void)) {
        container.performBackgroundTask{ privateMOC in
            let request: NSFetchRequest<NSFetchRequestResult> = CDBand.fetchRequest()
            request.predicate = NSPredicate(format: "id IN %@", bandId)
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            deleteRequest.resultType = .resultTypeCount
            
            do {
                _ = try privateMOC.execute(deleteRequest) as? NSFetchRequestResult
            } catch {
                print("F: \(error)")
            }
            completionHandler(bandId)
        }
    }
}
