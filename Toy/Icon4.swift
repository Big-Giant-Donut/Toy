//
//  Icon4.swift
//  Toy
//
//  Created by Larry Atkin on 11/4/25.
//

import ComposableArchitecture
import SwiftUI

// ---------------------------------------------------------------------------------------
// This is the code that puts all of the structure and function into a single enum.  This
// is the "natural" way to do things when using SwiftUI, but it is wrong.  It doesn't show
// in this simple example, but each of the cases can and should have a lot of additional
// processing methods, and each of them will be implemented as a func with a switch
// statement with a case for each option in the enum.  This is difficult to use and
// maintain.
// ---------------------------------------------------------------------------------------

struct Icon4Type {
    let makeInitialState: (Icon4) -> any Icon4State
    let view: (StoreOf<Icon4Reducer>, @escaping (Icon4Reducer.State) -> Icon4State, @escaping (Icon4Action) -> Icon4Reducer.Action) -> AnyView
}

class Icon4 {
    private static var _iconType = Icon4Type(
        makeInitialState: { _ in fatalError() },
        view: { _, _, _ in fatalError() }
    )

    class func iconType() -> Icon4Type {
        return Self._iconType
    }

    func makeInitialState() -> any Icon4State {
        Self.iconType().makeInitialState(self)
    }

    func view(store: StoreOf<Icon4Reducer>) -> AnyView {
        Self.iconType().view(
            store,
            { $0.child.state },
            { .child($0) }
        )
    }

    init() {
    }
}

class Icon4Pict: Icon4 {
    var name: String

    public override class func iconType() -> Icon4Type {
        return Self._iconType
    }

    private static var _iconType = Icon4Type(
        makeInitialState: { Pict4Reducer.State(icon: $0) },
        view: { store, childState, parentAction in
            return AnyView(
                Pict4View(
                    store: store.scope(
                        state: { state in childState(state) as? Pict4Reducer.State },
                        action: parentAction as (Pict4Reducer.Action) -> Icon4Reducer.Action
                    )
                )
            )
        }
    )

    init(name: String) {
        self.name = name
    }
}

class Icon4Label: Icon4 {
    var label: String

    public override class func iconType() -> Icon4Type {
        return Self._iconType
    }

    private static var _iconType = Icon4Type(
        makeInitialState: { Label4Reducer.State(icon: $0) },
        view: { store, childState, parentAction in
            AnyView(
                Label4View(
                    store: store.scope(
                        state: { state in childState(state) as? Label4Reducer.State },
                        action: parentAction as (Label4Reducer.Action) -> Icon4Reducer.Action
                    )
                )
            )
        }
    )

    init(label: String) {
        self.label = label
    }
}

class Icon4Both: Icon4 {
    var name: String
    var label: String

    public override class func iconType() -> Icon4Type {
        return Self._iconType
    }

    private static var _iconType = Icon4Type(
        makeInitialState: { Both4Reducer.State(icon: $0) },
        view: { store, childState, parentAction in
            AnyView(
                Both4View(
                    store: store.scope(
                        state: { state in childState(state) as? Both4Reducer.State },
                        action: parentAction as (Both4Reducer.Action) -> Icon4Reducer.Action
                    )
                )
            )
        }
    )

    init(name: String, label: String) {
        self.name = name
        self.label = label
    }
}

// And some test data;

var one4 = Icon4Pict(name: "sun.max")
var two4 = Icon4Label(label: "Label")
var three4 = Icon4Both(name: "moon.circle", label: "G'Nite")

// ---------------------------------------------------------------------------------------
// This is the code that implements the UI.  It uses a case statement to determine which
// View is used to render the information.  When we add an additional struct, we need to
// also add a case to this switch statement.  Actually, it uses multiple case statements,
// and every one of them needs to be modified when adding a new case.
// ---------------------------------------------------------------------------------------

protocol Icon4State {
    var icon: Icon4 { get }
}

protocol Icon4Action {

}

struct AnyIcon4State {
    var state: any Icon4State

    func view(store: StoreOf<Icon4Reducer>) -> AnyView {
        state.icon.view(store: store)
    }
}

//struct AnyIcon4Action {
//    var wrapped: any Icon4Action
//}

@Reducer
struct Icon4Reducer {

    @ObservableState
    struct State {
        var child: AnyIcon4State
    }

    @CasePathable
    enum Action {
        case iconClicked(Icon4)
        case child(any Icon4Action)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .iconClicked(let icon4):
                state.child = AnyIcon4State(state: icon4.makeInitialState())
                return .none
            case .child:
                return .none
            }
        }
    }
}

@Reducer
struct Pict4Reducer {
    @ObservableState
    struct State: Icon4State {
        var icon: Icon4
        var pictIcon: Icon4Pict {
            icon as! Icon4Pict
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
    enum Action: Icon4Action {

    }

    var body: some ReducerOf<Self> {

    }
}

@Reducer
struct Label4Reducer {
    @ObservableState
    struct State: Icon4State {
        var icon: Icon4
        var labelIcon: Icon4Label {
            get {
                icon as! Icon4Label
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
    enum Action: Icon4Action {

    }

    var body: some ReducerOf<Self> {

    }
}

@Reducer
struct Both4Reducer {
    @ObservableState
    struct State: Icon4State {
        var icon: Icon4
        var bothIcon: Icon4Both {
            get {
                icon as! Icon4Both
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
    enum Action: Icon4Action {

    }

    var body: some ReducerOf<Self> {

    }
}


struct Icon4View: View {
    var store: StoreOf<Icon4Reducer>

    @ViewBuilder
    var body: some View {
        store.state.child.view(store: store)
    }
}

struct Pict4View: View {
    let store: StoreOf<Pict4Reducer>

    @ViewBuilder
    var body: some View {
        Image(systemName: store.name)
            .imageScale(.large)
            .foregroundStyle(.tint)
    }
}

struct Label4View: View {
    let store: StoreOf<Label4Reducer>

    @ViewBuilder
    var body: some View {
        Text(store.label)
    }
}

struct Both4View: View {
    let store: StoreOf<Both4Reducer>

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

