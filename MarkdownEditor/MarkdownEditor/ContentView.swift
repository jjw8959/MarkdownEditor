//
//  ContentView.swift
//  MarkdownEditor
//
//  Created by woong on 5/9/24.
//

import SwiftUI

struct ContentView: View {
    let fileVM = FileViewModel.shared
    @State private var textString: String = ""
    
    var body: some View {
        TextEditor(text: $textString)
            .onChange(of: textString) {
                fileVM.textString = self.textString
            }
    }
}

#Preview {
    ContentView()
}
