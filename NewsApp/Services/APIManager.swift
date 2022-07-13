//
//  APIManager.swift
//  NewsApp
//
//  Created by Aakash Decosta on 13/07/22.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    func getData<T: Codable>(url: String,parameters:[String: String], completion: @escaping ( Result<APIResponse<T>, Error>) -> Void) {
        var urlComponent = URLComponents(string: url)!
        urlComponent.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        print( urlComponent.url!)
        var request = URLRequest(url:  urlComponent.url!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response , error in
            
            do {
                let model =  try JSONDecoder().decode(APIResponse<T>.self, from: data!)
                completion(.success(model))
            } catch {
                print(error)
                completion(.failure(error))
            }
        })
        task.resume()
    }
    
}
