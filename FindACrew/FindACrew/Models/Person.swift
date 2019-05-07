//
//  Person.swift
//  FindACrew
//
//  Created by Nelson Gonzalez on 5/7/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Person: Decodable {
    let name: String
    let gender: String
    let birthYear: String
    
//    enum CodingKeys: String, CodingKey {
//        case name
//        case gender
//        case birthYear = "birth_year"
//    }
}

//an object that represents the whole thing b/c root level is a dict.
struct PersonSearch: Decodable {
    //results is a key with value of an array of person objects
    let results: [Person]
}
