//
//  Content2View.swift
//  Toy
//
//  Created by Larry Atkin on 4/2/24.
//

import SwiftUI
import Foundation

struct Content2View: View {
	@State var focused: any Viewable2

	func focus(on icon: any Viewable2) {
		focused = icon
		NSLog("focused \(focused)")
	}

    var body: some View {
		HStack {
			VStack {
				Button(action: {focus(on: one2)}, label: {
					Text("One")
				})
				Button(action: {focus(on: two2)}, label: {
					Text("Two")
				})
				Button(action: {focus(on: three2)}, label: {
					Text("Three")
				})
			}
			Icon2View(icon: focused)
			.padding()
		}
    }
}

#Preview {
	Content2View(focused: one2)
		.frame(width: 200)
}
