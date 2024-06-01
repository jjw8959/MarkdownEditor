//
//  ContentView.swift
//  MarkdownEditor
//
//  Created by woong on 5/9/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var fileVM = FileViewModel.shared
    @State private var document: ReadMeDocument = ReadMeDocument(text: "")
    
    var body: some View {
        TextEditor(text: $fileVM.textString)
    }
}

#Preview {
    ContentView()
}
