//
//  Content1View.swift
//  Toy
//
//  Created by Larry Atkin on 4/2/24.
//

import SwiftUI

struct Content1View: View {
	@State var focused: Icon1

	func focus(on icon: Icon1) {
		focused = icon
		NSLog("focused \(focused)")
	}

    var body: some View {
		HStack {
			VStack {
				Button(action: {focus(on: one1)}, label: {
					Text("One")
				})
				Button(action: {focus(on: two1)}, label: {
					Text("Two")
				})
				Button(action: {focus(on: three1)}, label: {
					Text("Three")
				})
			}
			Icon1View(icon: focused)
			.padding()
		}
    }
}

#Preview {
	Content1View(focused: one1)
}
