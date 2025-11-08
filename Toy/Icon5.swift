//
//  Icon5.swift
//  Toy
//
//  Created by Larry Atkin on 11/8/25.
//

import ComposableArchitecture
import SwiftUI

// ---------------------------------------------------------------------------------------
// This is the code that defines the structure and function of the icons in the app.
// It is completely separate from the UI code.  More importantly, each struct is
// independent of all of the others.  Additional structs can be added without making any
// changes to existing structs.
//
// Also note that there are *no* enums in this file.
//
// This file attempts to use TCA to handle state transitions, and it succeeds.  It is
// using a modified TCA that allows scoping to a child state with a closure that can
// return a nil for the state when the type of the child state changes.  This allows
// TCA to supply a previously cached state and avoids a crash.
// ---------------------------------------------------------------------------------------

struct Icon5Type {
    let makeInitialState: (Icon5) -> any Icon5State
    let view: (StoreOf<Icon5Reducer>, @escaping (Icon5Reducer.State) -> Icon5State, @escaping (Icon5Action) -> Icon5Reducer.Action) -> AnyView
}

class Icon5 {

    // A class function to access the implementations of aspects required to procaess an
    // icon.  (This is a class func because Swift does not yet support a class var.)
    class func iconType() -> Icon5Type {
        return Self._iconType
    }

}

extension Icon5 {

    // A collection of closures to implement each of the aspects required to process an icon.
    // This must be defined for each icon.  Here (in the abstract super-class) all
    // closures simply abort.
    private static var _iconType = Icon5Type(
        makeInitialState: { _ in fatalError() },
        view: { _, _, _ in fatalError() }
    )

    // Convenience functions to access the closures in _iconType
    func makeInitialState() -> any Icon5State {
        Self.iconType().makeInitialState(self)
    }

    func view(store: StoreOf<Icon5Reducer>) -> AnyView {
        Self.iconType().view(
            store,
            { $0.child.state },
            { .child($0) }
        )
    }

}

class Icon5Pict: Icon5 {
    var name: String

    public override class func iconType() -> Icon5Type {
        return Self._iconType
    }

    init(name: String) {
        self.name = name
    }
}

extension Icon5Pict {

    private static var _iconType = Icon5Type(
        makeInitialState: { Pict5Reducer.State(icon: $0) },
        view: { store, childState, parentAction in
            return AnyView(
                Pict5View(
                    store: store.scope(
                        state: { state in childState(state) as? Pict5Reducer.State },
                        action: parentAction as (Pict5Reducer.Action) -> Icon5Reducer.Action
                    )
                )
            )
        }
    )
}

class Icon5Label: Icon5 {
    var label: String

    public override class func iconType() -> Icon5Type {
        return Self._iconType
    }

    init(label: String) {
        self.label = label
    }

}

extension Icon5Label {

    private static var _iconType = Icon5Type(
        makeInitialState: { Label5Reducer.State(icon: $0) },
        view: { store, childState, parentAction in
            AnyView(
                Label5View(
                    store: store.scope(
                        state: { state in childState(state) as? Label5Reducer.State },
                        action: parentAction as (Label5Reducer.Action) -> Icon5Reducer.Action
                    )
                )
            )
        }
    )
}

class Icon5Both: Icon5 {
    var name: String
    var label: String

    public override class func iconType() -> Icon5Type {
        return Self._iconType
    }

    init(name: String, label: String) {
        self.name = name
        self.label = label
    }
}

extension Icon5Both {

    private static var _iconType = Icon5Type(
        makeInitialState: { Both5Reducer.State(icon: $0) },
        view: { store, childState, parentAction in
            AnyView(
                Both5View(
                    store: store.scope(
                        state: { state in childState(state) as? Both5Reducer.State },
                        action: parentAction as (Both5Reducer.Action) -> Icon5Reducer.Action
                    )
                )
            )
        }
    )

}

// And some test data;

var one5 = Icon5Pict(name: "sun.max")
var two5 = Icon5Label(label: "Label")
var three5 = Icon5Both(name: "moon.circle", label: "G'Nite")

// ---------------------------------------------------------------------------------------
// This is the code that implements the UI.  It uses a protocol for the state.  Each
// icon type is free to create its own state, actions, reducer, and view.  For simplicity,
// here we work with a type-erased state.  This code can handle any number of additional
// icons that follow the protocol and override class func iconType().
// ---------------------------------------------------------------------------------------

protocol Icon5State {
    var icon: Icon5 { get }
}

protocol Icon5Action {

}

struct AnyIcon5State {
    var state: any Icon5State

    func view(store: StoreOf<Icon5Reducer>) -> AnyView {
        state.icon.view(store: store)
    }
}

//struct AnyIcon5Action {
//    var wrapped: any Icon5Action
//}

@Reducer
struct Icon5Reducer {

    @ObservableState
    struct State {
        var child: AnyIcon5State
    }

    @CasePathable
    enum Action {
        case iconClicked(Icon5)
        case child(any Icon5Action)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .iconClicked(let icon5):
                state.child = AnyIcon5State(state: icon5.makeInitialState())
                return .none
            case .child:
                // TODO: Invoke the child reducer with Icon5State and Icon5Action
                return .none
            }
        }
    }
}

@Reducer
struct Pict5Reducer {
    @ObservableState
    struct State: Icon5State {
        var icon: Icon5
        var pictIcon: Icon5Pict {
            icon as! Icon5Pict
        }
        var name: String {
            get {
                pictIcon.name
            }
            set {
                pictIcon.name = newValue
            }
        }
    }

    @CasePathable
    enum Action: Icon5Action {

    }

    var body: some ReducerOf<Self> {

    }
}

@Reducer
struct Label5Reducer {
    @ObservableState
    struct State: Icon5State {
        var icon: Icon5
        var labelIcon: Icon5Label {
            get {
                icon as! Icon5Label
            }
        }
        var label: String {
            get {
                labelIcon.label
            }
            set {
                labelIcon.label = newValue
            }
        }

    }

    @CasePathable
    enum Action: Icon5Action {

    }

    var body: some ReducerOf<Self> {

    }
}

@Reducer
struct Both5Reducer {
    @ObservableState
    struct State: Icon5State {
        var icon: Icon5
        var bothIcon: Icon5Both {
            get {
                icon as! Icon5Both
            }
        }
        var name: String {
            get {
                bothIcon.name
            }
            set {
                bothIcon.name = newValue
            }
        }
        var label: String {
            get {
                bothIcon.label
            }
            set {
                bothIcon.label = newValue
            }
        }
    }

    @CasePathable
    enum Action: Icon5Action {

    }

    var body: some ReducerOf<Self> {

    }
}


struct Icon5View: View {
    var store: StoreOf<Icon5Reducer>

    @ViewBuilder
    var body: some View {
        store.state.child.view(store: store)
    }
}

struct Pict5View: View {
    let store: StoreOf<Pict5Reducer>

    @ViewBuilder
    var body: some View {
        Image(systemName: store.name)
            .imageScale(.large)
            .foregroundStyle(.tint)
    }
}

struct Label5View: View {
    let store: StoreOf<Label5Reducer>

    @ViewBuilder
    var body: some View {
        Text(store.label)
    }
}

struct Both5View: View {
    let store: StoreOf<Both5Reducer>

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


