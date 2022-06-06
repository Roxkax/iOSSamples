//
//  PrimeAlert.swift
//  iOSSamples
//
//  Created by Diogo Gonçalves on 06/06/2022.
//

import Foundation

struct PrimeAlert: Identifiable {
    let prime: Int
    
    var id: Int { self.prime }
}
