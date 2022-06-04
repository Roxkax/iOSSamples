//
//  PrimeNumbersView.swift
//  iOSSamples
//
//  Created by Diogo Gonçalves on 04/06/2022.
//

import SwiftUI
import iOSCore

struct PrimeNumbersView: View {
    @ObservedObject var state : AppState
    
    var body: some View {
        List{
            NavigationLink(destination: CounterView(state: self.state)) {
                Text("Counter demo")
            }
            NavigationLink(destination: FavouritePrimesView()) {
                Text("Favorite primes")
            }
        }.navigationBarTitle("State managment")
        
    }
}

struct CounterView : View {
    @ObservedObject var state : AppState
    
    var body: some View{
        VStack {
            HStack {
                Button(action: { self.state.count -= 1 }) {
                    Text("-")
                }
                Text("\(self.state.count)")
                Button(action: { self.state.count += 1 }) {
                    Text("+")
                }
            }
            Button(action: {}) {
                Text("Is this prime?")
            }
            Button(action: {}) {
                Text("What is the \(NumbersUtils.ordinal(self.state.count)) prime?")
            }
        }
        .font(.title)
        .navigationBarTitle("Counter Demo")
    }
}

struct FavouritePrimesView : View{
    var body: some View{
        EmptyView()
    }
}
