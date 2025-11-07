//
//  Content3View.swift
//  Toy
//
//  Created by Larry Atkin on 11/2/25.
//

import ComposableArchitecture
import SwiftUI

struct Content3View: View {
    var store: StoreOf<Icon3Reducer>

    var body: some View {
		HStack {
			VStack {
                Button(action: {store.send(.oneClicked)}, label: {
					Text("One")
				})
                Button(action: {store.send(.twoClicked)}, label: {
					Text("Two")
				})
                Button(action: {store.send(.threeClicked)}, label: {
					Text("Three")
				})
			}
            Icon3View(store: store)
			.padding()
		}
    }
}

#if DEBUG
var store3 = Store(initialState: Icon3Reducer.State(child: one3.icon3State)) {
    Icon3Reducer()
}
#Preview {
    Content3View(store: store3)
		.frame(width: 300)
}
#endif
