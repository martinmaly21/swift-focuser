//
//  SwiftUIView.swift
//  
//
//  Created by Augustinas Malinauskas on 13/09/2021.
//

import SwiftUI
import Introspect

class TextEditorObserver: NSObject, UITextViewDelegate {
    var onReturnTap: () -> () = {}
    var onDismiss: () -> () = {}
    weak var forwardToDelegate: UITextViewDelegate?
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        forwardToDelegate?.textViewShouldBeginEditing?(textView) ?? true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        forwardToDelegate?.textViewDidBeginEditing?(textView) 
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return forwardToDelegate?.textViewShouldEndEditing?(textView) ?? true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        onDismiss()
        forwardToDelegate?.textViewDidEndEditing?(textView)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        forwardToDelegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text) ?? true
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
        forwardToDelegate?.textViewDidChangeSelection?(textView)
    }
}

@available(iOS 13.0, *)
public struct FocusModifierTextEditor<Value: FocusStateCompliant & Hashable>: ViewModifier {
    @Binding var focusedField: Value?
    var equals: Value
    @State var observer = TextEditorObserver()
    
    public func body(content: Content) -> some View {
        content
            .introspectTextView { textView in
                if !(textView.delegate is TextEditorObserver) {
                    observer.forwardToDelegate = textView.delegate
                    textView.delegate = observer
                }
                
                /// when user taps return we navigate to next responder
                observer.onReturnTap = {
                    focusedField = focusedField?.next ?? Value.last
                }
                
                observer.onDismiss = {
                     focusedField = nil
                }
                
                /// to show kayboard with `next` or `return`
                if equals.hashValue == Value.last.hashValue {
                    textView.returnKeyType = .done
                } else {
                    textView.returnKeyType = .next
                }
                
                if focusedField == equals {
                    textView.becomeFirstResponder()
                }
            }
            .simultaneousGesture(TapGesture().onEnded {
                focusedField = equals
            })
    }
}
