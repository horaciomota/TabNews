//
//  FloatingButtonView.swift
//  TabNews
//
//  Created by Horacio Mota on 23/11/23.
//

import SwiftUI
import FloatingButton

struct FloatingButtonView: View {
    @Binding var isOpen: Bool

    var body: some View {
        let mainButton = AnyView(
            Button(action: {
                self.isOpen.toggle()
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
        )

        let buttons = [
            AnyView(Button(action: { print("Action 1") }) {
                Image(systemName: "pencil")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .clipShape(Circle())
            }),
            AnyView(Button(action: { print("Action 2") }) {
                Image(systemName: "trash")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .clipShape(Circle())
            }),
            AnyView(Button(action: { print("Action 3") }) {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .clipShape(Circle())
            })
        ]

        return FloatingButton(mainButtonView: mainButton, buttons: buttons, isOpen: $isOpen)
            .straight()
            .direction(.top)
            .alignment(.right)
            .spacing(20)
            .initialOffset(x: 1000)
            .animation(.spring())
            .padding(.trailing, 20) // Adiciona um espaçamento à direita
            .padding(.bottom, 20) // Adiciona um espaçamento na parte inferior
    }
}

#Preview {
    FloatingButtonView(isOpen: .constant(false))
}
