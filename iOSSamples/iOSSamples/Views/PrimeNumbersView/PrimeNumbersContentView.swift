//
//  PrimeNumbersView.swift
//  iOSSamples
//
//  Created by Diogo Gonçalves on 04/06/2022.
//

import SwiftUI
import iOSCore

struct PrimeNumbersView: View {
    @ObservedObject var state : PrimeNumbersAppState
    
    var body: some View {
        List{
            NavigationLink(destination: CounterView(state: self.state)) {
                Text("Counter demo")
            }
            NavigationLink(destination: FavouritePrimesView(state: self.state)) {
                Text("Favorite primes")
            }
        }.navigationBarTitle("State managment")
        
    }
}

struct CounterView : View {
    @ObservedObject var state : PrimeNumbersAppState
    @State var isPrimeModalShown: Bool = false
    @State var alertNthPrime: PrimeAlert?
    @State var isNthPrimeButtonDisabled = false
    
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
            Button(action: { self.isPrimeModalShown = true }) {
                Text("Is this prime?")
            }
            Button(action: self.nthPrimeButtonAction) {
                Text("What is the \(ordinal(self.state.count)) prime?")
            }
            .disabled(self.isNthPrimeButtonDisabled)
        }
        .font(.title)
        .navigationBarTitle("Counter Demo")
        .sheet(isPresented: self.$isPrimeModalShown){
            IsPrimeModalView(state: self.state)
        }.alert(item: self.$alertNthPrime) { alert in
            Alert(
                title: Text("The \(self.state.count.ordinal) prime is \(alert.prime)"),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
    
    func nthPrimeButtonAction() {
        self.isNthPrimeButtonDisabled = true
        nthPrime(self.state.count) { prime in
            self.alertNthPrime = prime.map(PrimeAlert.init(prime:))
            self.isNthPrimeButtonDisabled = false
        }
    }
}

struct IsPrimeModalView: View {
    @ObservedObject var state: PrimeNumbersAppState
    
    var body: some View {
        VStack {
            if self.state.count.isPrime {
                Text("\(self.state.count) is prime 🎉")
                if self.state.favoritePrimes.contains(self.state.count) {
                    Button(action: {
                        self.state.favoritePrimes.removeAll(where: { $0 == self.state.count })
                    }) {
                        Text("Remove from favorite primes")
                    }
                } else {
                    Button(action: {
                        self.state.favoritePrimes.append(self.state.count)
                    }) {
                        Text("Save to favorite primes")
                    }
                }
                
            } else {
                Text("\(self.state.count) is not prime :(")
            }
            
        }
    }
}

struct FavouritePrimesView : View{
    @ObservedObject var state: PrimeNumbersAppState
    
    var body: some View {
        List {
            ForEach(self.state.favoritePrimes, id: \.self) { prime in
                Text("\(prime)")
            }
            .onDelete { indexSet in
                for index in indexSet {
                    self.state.favoritePrimes.remove(at: index)
                }
            }
        }
        .navigationBarTitle(Text("Favorite Primes"))
    }
}

func nthPrime(_ n: Int, callback: @escaping (Int?) -> Void) -> Void {
    wolframAlpha(query: "prime \(n)") { result in
        callback(
            result
                .flatMap {
                    $0.queryresult
                        .pods
                        .first(where: { $0.primary == .some(true) })?
                        .subpods
                        .first?
                        .plaintext
                }
                .flatMap(Int.init)
        )
    }
}

func wolframAlpha(query: String, callback: @escaping (WolframAlphaResult?) -> Void) -> Void {
    var components = URLComponents(string: "https://api.wolframalpha.com/v2/query")!
    components.queryItems = [
        URLQueryItem(name: "input", value: query),
        URLQueryItem(name: "format", value: "plaintext"),
        URLQueryItem(name: "output", value: "JSON"),
        URLQueryItem(name: "appid", value: "6H69Q3-828TKQJ4EP"),
    ]
    
    URLSession.shared.dataTask(with: components.url(relativeTo: nil)!) { data, response, error in
        callback(
            data.flatMap { try? JSONDecoder().decode(WolframAlphaResult.self, from: $0) }
        )
    }
    .resume()
}
