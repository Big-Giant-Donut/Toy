//
//  Icon1.swift
//  Toy
//
//  Created by Larry Atkin on 4/2/24.
//

import SwiftUI

// ---------------------------------------------------------------------------------------
// This is the code that puts all of the structure and function into a single enum.  This
// is the "natural" way to do things when using SwiftUI, but it is wrong.  It doesn't show
// in this simple example, but each of the cases can and should have a lot of additional
// processing methods, and each of them will be implemented as a func with a switch
// statement with a case for each option in the enum.  This is difficult to use and
// maintain.
// ---------------------------------------------------------------------------------------

struct Icon1 {
	
	enum IconType {
		case pict(name: String)
		case label(label: String)
		case both(name: String, label: String)
	}

	let type: IconType
}

// And some test data;

var one1 = Icon1(type: .pict(name: "sun.max") )
var two1 = Icon1(type: .label(label: "Label"))
var three1 = Icon1(type: .both(name: "moon.circle", label: "G'Nite"))

// ---------------------------------------------------------------------------------------
// This is the code that implements the UI.  It uses a case statement to determine which
// View is used to render the information.  When we add an additional struct, we need to
// also add a case to this switch statement.
// ---------------------------------------------------------------------------------------

struct Icon1View: View {
	var icon: Icon1

	@ViewBuilder
	var body: some View {
		switch icon.type {
		case .pict(let name):
			Pict1View(name: name)
		case .label(let label):
			Label1View(label: label)
		case .both(let name, let label):
			Both1View(name: name, label: label)
		}
	}
}

struct Pict1View: View {
	let name: String

	@ViewBuilder
	var body: some View {
		Image(systemName: name)
			.imageScale(.large)
			.foregroundStyle(.tint)
	}
}

struct Label1View: View {
	let label: String

	@ViewBuilder
	var body: some View {
		Text(label)
	}
}

struct Both1View: View {
	let name: String
	let label: String

	@ViewBuilder
	var body: some View {
		VStack {
			Text(label)
			Image(systemName: name)
				.imageScale(.large)
				.foregroundStyle(.tint)
		}
		.padding()
	}
}

