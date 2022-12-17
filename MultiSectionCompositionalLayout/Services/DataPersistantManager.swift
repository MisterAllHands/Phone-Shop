//
//  DataPersistantManager.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 17/12/2022.
//


import UIKit
import CoreData

class DatapersistantManager{
    
    static let shared = DatapersistantManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    enum DataBaseError: Error{
        case failedSaving
        case failedFetching
        case failedDeletingData
    }
    
    
    
    //MARK: - Saving data
    
    func addItemToFavorites(model: BestSellerItem){
        
        let basket = Baskets(context: context)
        
        basket.id = Int64(model.id!)
        basket.title = model.title
        basket.images = model.picture
        basket.price = Int64(model.price_without_discount)
        
        do{
            try context.save()
            
        }catch{
            print("Error while adding the item \(DataBaseError.failedSaving)")
        }
    }
    
    //MARK: - Fetching Data
    
    func fetchingDataToDataBase(completion: @escaping(Result<[Baskets], Error>) -> Void){
        
        
        let request: NSFetchRequest <Baskets>
            
        request = Baskets.fetchRequest()
        
        do{
            let fetchedItems = try context.fetch(request)
            completion(.success(fetchedItems))
        }catch{
            completion(.failure(DataBaseError.failedFetching))
        }
    }
    
    //MARK: - Deleting Data
    
    func deleteDataFromDatabase(model: Baskets){
        
        context.delete(model)
        
        do{
            try context.save()
        }catch{
            print(DataBaseError.failedDeletingData)
        }
    }
}
