//
//  TcaView.swift
//  Toy
//
//  Created by Larry Atkin on 11/1/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct TcaReducer {

    @ObservableState
    struct State {
        var protocolTca: Bool
        var icon3: Icon3Reducer.State
        var icon4: Icon4Reducer.State
    }

    @CasePathable
    enum Action {
        case icon3(Icon3Reducer.Action)
        case icon4(Icon4Reducer.Action)
        case toggleProtocolClicked(Bool)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.icon3, action: \.icon3) {
            Icon3Reducer()
        }
        Scope(state: \.icon4, action: \.icon4) {
            Icon4Reducer()
        }
        Reduce { state, action in
            switch action {

            case .icon3(_):
                return .none
            case .icon4(_):
                return .none
            case .toggleProtocolClicked(let value):
                state.protocolTca = value
                return .none
            }
        }
    }
}

struct TcaView: View {
    var store: StoreOf<TcaReducer>

    var body: some View {
        VStack {
            Toggle(
                isOn: Binding(
                    get: { store.protocolTca },
                    set: { store.send(.toggleProtocolClicked($0)) }
                )
            ){ Text("Use Protocol") }
            if store.protocolTca {
                Text("Icon4")
                Content4View(store: store.scope(state: \.icon4, action: \.icon4))
            } else {
                Text("Icon3")
                Content3View(store: store.scope(state: \.icon3, action: \.icon3))
            }
        }
    }
}

