//
//  File.swift
//  
//
//  Created by Augustinas Malinauskas on 01/09/2021.
//

import SwiftUI

extension TextField {
    func focusedLegacy<T: FocusStateCompliant>(_ focusedField: Binding<T>, equals: T) -> some View {
        modifier(FocusModifier(focusedField: focusedField, equals: equals))
    }
}
