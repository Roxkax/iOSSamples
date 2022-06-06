//
//  WolframAlphaResult.swift
//  iOSSamples
//
//  Created by Diogo Gonçalves on 06/06/2022.
//

import Foundation

struct WolframAlphaResult: Decodable {
    let queryresult: QueryResult
    
    struct QueryResult: Decodable {
        let pods: [Pod]
        
        struct Pod: Decodable {
            let primary: Bool?
            let subpods: [SubPod]
            
            struct SubPod: Decodable {
                let plaintext: String
            }
        }
    }
}
