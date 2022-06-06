//
//  PrimeNumbersAppState.swift
//  iOSSamples
//
//  Created by Diogo Gonçalves on 06/06/2022.
//

import Foundation

class PrimeNumbersAppState : ObservableObject {
    @Published var count = 0
    @Published var favoritePrimes: [Int] = []
}
