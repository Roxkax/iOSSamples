//
//  iOSSamplesApp.swift
//  iOSSamples
//
//  Created by Diogo Gonçalves on 03/06/2022.
//

import SwiftUI

class AppState : ObservableObject {
    @Published var count = 0
}

@main
struct iOSSamplesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(state: AppState())
        }
    }
}

private func ordinal(_ n:Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .ordinal
    return formatter.string(for: n) ?? ""
}

struct ContentView : View {
    @ObservedObject var state : AppState
    
    var body: some View {
        NavigationView {
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
                Text("What is the \(ordinal(self.state.count)) prime?")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(state: AppState())
    }
}
