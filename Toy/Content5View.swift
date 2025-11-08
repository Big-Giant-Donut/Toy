//
//  Content5View.swift
//  Toy
//
//  Created by Larry Atkin on 11/8/25.
//

import ComposableArchitecture
import SwiftUI

struct Content5View: View {
    var store: StoreOf<Icon5Reducer>

    var body: some View {
        HStack {
            VStack {
                Button(action: {store.send(.iconClicked(one5))}, label: {
                    Text("One")
                })
                Button(action: {store.send(.iconClicked(two5))}, label: {
                    Text("Two")
                })
                Button(action: {store.send(.iconClicked(three5))}, label: {
                    Text("Three")
                })
            }
            Icon5View(store: store)
                .padding()
        }
    }
}

#if DEBUG
var store5 = Store(initialState: Icon5Reducer.State(child: AnyIcon5State(state: three5.makeInitialState()))) {
    Icon5Reducer()
}
#Preview {
    Content5View(store: store5)
        .frame(width: 300)
}
#endif

