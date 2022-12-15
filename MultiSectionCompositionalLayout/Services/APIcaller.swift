//
//  APIcaller.swift
//  PhoneShop
//
//  Created by TTGMOTSF on 05/12/2022.
//

import Foundation

struct APICaller {
    
    static let shared = APICaller()
        
    let mainUrl = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
    let productUrl = "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5"
    let cartUrl = "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149"
  
//MARK: - Requesting Data for the Main screen
    
    func getPhones( completion: @escaping (Result<APIresponse, Error>) -> Void) {
        
        //Home Store
        if let url = URL(string: "\(mainUrl)") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                //MARK - Parsing JSON
                
                if error != nil {
                    completion(.failure(error!))
                }else if let safeData = data {
                    
                    do{
                        let decodedData = try JSONDecoder().decode(APIresponse.self, from: safeData)
                        completion(.success(decodedData))
                    }catch{
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Requesting data for Product Details
    
    func getProductDetails( completion: @escaping (Result<ProductDetails, Error>) -> Void) {
        
        if let url = URL(string: "\(productUrl)") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                //MARK - Parsing JSON
                
                if error != nil {
                    completion(.failure(error!))
                }else if let safeData = data {

                    do{
                        let decodedData = try JSONDecoder().decode(ProductDetails.self, from: safeData)
                        print(decodedData)
                        completion(.success(decodedData))
                    }catch{
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
}
