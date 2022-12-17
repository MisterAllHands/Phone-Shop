//
//  DataPersistantManager.swift
//  MultiSectionCompositionalLayout
//
//  Created by TTGMOTSF on 17/12/2022.
//

import Foundation
import UIKit
import CoreData

class DatapersistantManager{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    enum DataBaseError: Error{
        case failedSaving
        case failedFetching
    }
    
    static let shared = DatapersistantManager()
    
    func addItemToFavorites(model: Basket, completion: @escaping(Result<Void, Error>) -> Void){
        
        let basket = Baskets(context: context)
        
        basket.id = Int64(model.id)
        basket.title = model.title
        basket.images = model.images
        basket.price = Int64(model.price)
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DataBaseError.failedSaving))
        }
    }
    
    func fetchingDataToDataBase(completion: @escaping(Result<[Baskets], Error>) -> Void){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request: NSFetchRequest <Baskets>
            
        request = Baskets.fetchRequest()
        
        do{
            let fetchedItems = try context.fetch(request)
            completion(.success(fetchedItems))
        }catch{
            completion(.failure(DataBaseError.failedFetching))
        }
    }
    
    func deleteDataFromDatabase(model: Baskets, completion: @escaping(Result<Void, Error>) -> Void){
        
        
        context.delete(model)
        
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
}
