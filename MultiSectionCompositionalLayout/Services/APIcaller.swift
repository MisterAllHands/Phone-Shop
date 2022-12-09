//
//  APIcaller.swift
//  PhoneShop
//
//  Created by TTGMOTSF on 05/12/2022.
//

import Foundation

struct APICaller {
    
    static let shared = APICaller()
        
    let baseUrl = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
  
    //MARK - Requesting data
    
    func getPhones( completion: @escaping (Result<APIresponse, Error>) -> Void) {
        
        if let url = URL(string: "\(baseUrl)") {
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                //MARK - Parsing JSON
                
                if error != nil {
                    completion(.failure(error!))
                }else if let safeData = data {
                    
                    do{
                        let decodedData = try JSONDecoder().decode(APIresponse.self, from: safeData)
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
