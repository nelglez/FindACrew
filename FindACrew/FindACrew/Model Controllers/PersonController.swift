//
//  PersonController.swift
//  FindACrew
//
//  Created by Nelson Gonzalez on 5/7/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class PersonController {
    
    let baseUrl = URL(string: "https://swapi.co/api/people/")!
    var people: [Person] = []
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func searchForPeople(with searchTerm: String, completion: @escaping() -> Void) {
        
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        
        urlComponents?.queryItems = [searchTermQueryItem]
        //https://swapi.co/api/people/?search=[searchTerm]
        
        guard let requestUrl = urlComponents?.url else {
            NSLog("RequestURL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
             //   completion()
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
              //  completion()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let personSearch = try jsonDecoder.decode(PersonSearch.self, from: data)
                self.people = personSearch.results
              //  completion()
                
            } catch {
                NSLog("Unable to decode data into object of type [Person]: \(error)")
                
            }
            
            completion()
            
        }.resume()
        
    }
    
    
}
