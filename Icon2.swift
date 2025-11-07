//
//  Icon2.swift
//  Toy
//
//  Created by Larry Atkin on 4/2/24.
//

import SwiftUI

// ---------------------------------------------------------------------------------------
// This is the code that defines the structure and function of the icons in the app.
// It is completely separate from the UI code.  More importantly, each struct is
// independent of all of the others.  Additional structs can be added without making any
// changes to existing structs.
//
// Also note that there are *no* enums in this file.
// ---------------------------------------------------------------------------------------

struct Pict2 {
	let name: String
}

struct Label2 {
	let label: String
}

struct Both2 {
	let name: String
	let label: String
}

// And some test data;

var one2 = Pict2(name: "sun.max")
var two2 = Label2(label: "Label")
var three2 = Both2(name: "moon.circle", label: "G'Nite")

// ---------------------------------------------------------------------------------------
// This is the code that implements the UI.  It adds a protocol that defines how to get
// from the value (struct) above to the SwiftUI code to present the UI.  This also
// includes each SwiftUI View in separate structs.
// ---------------------------------------------------------------------------------------

protocol Viewable2 {
	var view: any View { get }
}

struct Icon2View: View {
	var icon: any Viewable2

	@ViewBuilder
	var body: some View {
		AnyView(icon.view)
	}

}

extension Pict2: Viewable2 {
	var view: any View {
		Pict2View(pict: self)
	}
}

struct Pict2View: View {
	let pict: Pict2

	@ViewBuilder
	var body: some View {
		Image(systemName: pict.name)
			.imageScale(.large)
			.foregroundStyle(.tint)
	}
}


extension Label2: Viewable2 {
	var view: any View {
		Label2View(label: self)
	}
}

struct Label2View: View {
	var label: Label2

	@ViewBuilder
	var body: some View {
		Text(label.label)
	}
}

extension Both2: Viewable2 {
	var view: any View {
		Both2View(both: self)
	}
}

struct Both2View: View {
	let both: Both2

	@ViewBuilder
	var body: some View {
		VStack {
			Text(both.label)
			Image(systemName: both.name)
				.imageScale(.large)
				.foregroundStyle(.tint)
		}
		.padding()
	}
}
