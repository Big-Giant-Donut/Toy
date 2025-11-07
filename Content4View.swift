//
//  Content4View.swift
//  Toy
//
//  Created by Larry Atkin on 11/4/25.
//

import ComposableArchitecture
import SwiftUI

struct Content4View: View {
    var store: StoreOf<Icon4Reducer>

    var body: some View {
        HStack {
            VStack {
                Button(action: {store.send(.iconClicked(one4))}, label: {
                    Text("One")
                })
                Button(action: {store.send(.iconClicked(two4))}, label: {
                    Text("Two")
                })
                Button(action: {store.send(.iconClicked(three4))}, label: {
                    Text("Three")
                })
            }
            Icon4View(store: store)
                .padding()
        }
    }
}

#if DEBUG
var store4 = Store(initialState: Icon4Reducer.State(child: AnyIcon4State(state: three4.makeInitialState()))) {
    Icon4Reducer()
}
#Preview {
    Content4View(store: store4)
        .frame(width: 300)
}
#endif
