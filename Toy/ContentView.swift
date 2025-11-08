//
//  ContentView.swift
//  Toy
//
//  Created by Larry Atkin on 4/3/24.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    var store: StoreOf<TcaReducer>

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
//            VStack {
//                Text("VanillaView")
//                VanillaView()
//            }
            VStack {
//                Text("TCA View")
                TcaView(store: store)
            }
        }
	}
}

//var tcaStore: StoreOf<TcaReducer> = Store(
//    initialState: TcaReducer.State(protocolTca: false, icon3: Icon3Reducer.State(child: one3.icon3State)),
//    reducer: { TcaReducer() }
//)
//#Preview {
//    ContentView(store: Binding(tcaStore))
//        .frame(width: 300, height: 150)
//}
