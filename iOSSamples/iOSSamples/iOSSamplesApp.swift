//
//  iOSSamplesApp.swift
//  iOSSamples
//
//  Created by Diogo Gonçalves on 03/06/2022.
//

import SwiftUI

@main
struct iOSSamplesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

private struct ContentView : View {
    var body: some View {
        NavigationView {
            List{
                NavigationLink(destination: PrimeNumbersView(state: PrimeNumbersAppState())) {
                    Text("Prime numbers")
                }
            }.navigationBarTitle("iOS Samples")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
