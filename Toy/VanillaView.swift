//
//  VanillaView.swift
//  Toy
//
//  Created by Larry Atkin on 11/1/25.
//

import SwiftUI

struct VanillaView: View {
    @State var toggled = false

    var body: some View {
        VStack {
            Toggle(isOn: $toggled, label: { Text("Use Protocol") })
            if toggled {
                Text("Icon2")
                Content2View(focused: one2)
            } else {
                Text("Icon1")
                Content1View(focused: one1)
            }
        }
    }
}

#Preview {
    @Previewable @State var toggled = true
    VanillaView(toggled: toggled)
        .frame(width: 300, height: 150)
}
