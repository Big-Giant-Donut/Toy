//
//  ToyApp.swift
//  Toy
//
//  Created by Larry Atkin on 4/2/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct ToyApp: App {
    var tcaStore = Store(
        initialState: TcaReducer.State(
            icon4: Icon4Reducer.State(child: AnyIcon4State(state: one4.makeInitialState())),
            icon5: Icon5Reducer.State(child: AnyIcon5State(state: one5.makeInitialState()))
        ),
        reducer: { TcaReducer()
        }
    )

    var body: some Scene {
        WindowGroup {
            ContentView(store: tcaStore.self)
        }
    }
}
