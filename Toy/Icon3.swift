//
//  Icon3.swift
//  Toy
//
//  Created by Larry Atkin on 11/2/25.
//

import ComposableArchitecture
import SwiftUI

// ---------------------------------------------------------------------------------------
// This is the code that puts all of the structure and function into a single enum.  This
// is the "natural" way to do things when using SwiftUI and TCA, but it is wrong.  It
// doesn't show in this simple example, but each of the cases can and should have a lot
// of additional processing methods, and each of them will be implemented as a func with
// a switch statement with a case for each option in the enum.  This is difficult to use
// and maintain.
// There may be better ways to implement the TCA code, but this still demostrates how the
// code to maintain a single Icon is distributed through multiple enum statements.
// ---------------------------------------------------------------------------------------

struct Icon3 {

    enum IconType {
        case pict(name: String)
        case label(label: String)
        case both(name: String, label: String)
    }

    let type: IconType

    var icon3State: Icon3State {
        switch type {
        case let .pict(name):
            Icon3State.pict(Pict3Reducer.State(name: name))
        case let .label(label):
            Icon3State.label(Label3Reducer.State(label: label))
        case let .both(name, label):
            Icon3State.both(Both3Reducer.State(name: name, label: label))
        }
    }
}

// And some test data;

var one3 = Icon3(type: .pict(name: "sun.max"))
var two3 = Icon3(type: .label(label: "Label"))
var three3 = Icon3(type: .both(name: "moon.circle", label: "G'Nite"))

// ---------------------------------------------------------------------------------------
// This is the code that implements the UI.  It uses a case statement to determine which
// View is used to render the information.  When we add an additional struct, we need to
// also add a case to this switch statement.  Actually, it uses multiple case statements,
// and every one of them needs to be modified when adding a new case.
// ---------------------------------------------------------------------------------------

@ObservableState
@CasePathable
enum Icon3State {
    case pict(Pict3Reducer.State)
    case label(Label3Reducer.State)
    case both(Both3Reducer.State)
}

@CasePathable
enum Icon3Action {
    case pict(Pict3Reducer.Action)
    case label(Label3Reducer.Action)
    case both(Both3Reducer.Action)

}


@Reducer
struct Icon3Reducer {

    @ObservableState
    struct State {
        var child: Icon3State
    }

    @CasePathable
    enum Action {
        case child(Icon3Action)
        case oneClicked
        case twoClicked
        case threeClicked
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .child:
                return .none
            case .oneClicked:
                state.child = one3.icon3State
                return .none
            case .twoClicked:
                state.child = two3.icon3State
                return .none
            case .threeClicked:
                state.child = three3.icon3State
            }
            return .none
        }
    }
}

@Reducer
struct Pict3Reducer {
    @ObservableState
    struct State {
        var name: String
    }

    @CasePathable
    enum Action {

    }

    var body: some ReducerOf<Self> {

    }
}

@Reducer
struct Label3Reducer {
    @ObservableState
    struct State {
        var label: String
    }

    @CasePathable
    enum Action {

    }

    var body: some ReducerOf<Self> {

    }
}

@Reducer
struct Both3Reducer {
    @ObservableState
    struct State {
        var name: String
        var label: String
    }

    @CasePathable
    enum Action {

    }

    var body: some ReducerOf<Self> {

    }
}


struct Icon3View: View {
    var store: StoreOf<Icon3Reducer>

    @ViewBuilder
    var body: some View {
        switch store.state.child {
        case .pict(let state):
            Pict3View(store: store.scope(state: { _ in state }, action: { $0 } ))
        case .label(let state):
            Label3View(store: store.scope(state: { _ in state }, action: { $0 } ))
        case .both(let state):
            Both3View(store: store.scope(state: { _ in state }, action: { $0 } ))
        }
    }
}

struct Pict3View: View {
    let store: StoreOf<Pict3Reducer>

    @ViewBuilder
    var body: some View {
        Image(systemName: store.name)
            .imageScale(.large)
            .foregroundStyle(.tint)
    }
}

struct Label3View: View {
    let store: StoreOf<Label3Reducer>

    @ViewBuilder
    var body: some View {
        Text(store.label)
    }
}

struct Both3View: View {
    let store: StoreOf<Both3Reducer>

    @ViewBuilder
    var body: some View {
        VStack {
            Text(store.label)
            Image(systemName: store.name)
                .imageScale(.large)
                .foregroundStyle(.tint)
        }
        .padding()
    }
}

