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
        var icon4: Icon4Reducer.State
        var icon5: Icon5Reducer.State
    }

    @CasePathable
    enum Action {
        case icon4(Icon4Reducer.Action)
        case icon5(Icon5Reducer.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.icon4, action: \.icon4) {
            Icon4Reducer()
        }
        Scope(state: \.icon5, action: \.icon5) {
            Icon5Reducer()
        }
        Reduce { state, action in
            switch action {

            case .icon4:
                return .none
            case .icon5:
                return .none
            }
        }
    }
}

struct TcaView: View {
    var store: StoreOf<TcaReducer>

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack {
                Text("Icon4 crashes")
                Content4View(store: store.scope(state: \.icon4, action: \.icon4))
            }
            .frame(width: 300, height: 200)
            VStack {
                Text("Icon5")
                Content5View(store: store.scope(state: \.icon5, action: \.icon5))
            }
            .frame(width: 300, height: 200)
        }
    }
}

