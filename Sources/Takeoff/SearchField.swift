#if os(iOS)

import SwiftUI
import UIKit

@available(iOS 14.0, *)
public struct SearchField: View {
    
    /// The text to be displayed and edited.
    @Binding public var text: String
    
    @State private var isEditing: Bool = false
    
    /// Creates a new `SearchField`.
    /// - parameter text: The text to be displayed and edited.
    public init(text: Binding<String>) {
        self._text = text
    }
    
    public var body: some View {
        HStack {
            TextField("", text: self.$text)
                .padding(.leading, 24)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                        if self.text.isEmpty {
                            Text("Search")
                        }
                        Spacer()
                        if !self.text.isEmpty {
                            Button(action: self.clearText) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .foregroundColor(.gray)
                )
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.horizontal)
                .onTapGesture(perform: self.beginEditing)
            if self.isEditing {
                Button("Cancel", action: self.endEditing)
                    .padding(.trailing)
            }
        }
    }
    
    private func clearText() {
        self.text = ""
    }
    
    private func beginEditing() {
        withAnimation { self.isEditing = true }
    }
    
    private func endEditing() {
        withAnimation {
            self.isEditing = false
            let action = #selector(UIResponder.resignFirstResponder)
            UIApplication.shared.sendAction(action, to: nil, from: nil, for: nil)
        }
    }
}

public struct SearchField_Previews: PreviewProvider {
    
    public static var previews: some View {
        Group {
            SearchField(text: .constant(""))
            SearchField(text: .constant("With text"))
        }
    }
}

#endif
