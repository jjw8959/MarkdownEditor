//
//  ContentView.swift
//  MarkdownEditor
//
//  Created by woong on 5/9/24.
//

import SwiftUI

struct ContentView: View {
//    @State private var document: ReadMeDocument = ReadMeDocument(text: "")
//    @Binding var showType: ShowType
    @State var showType: ShowType = .editPreview
    
    var body: some View {
        Picker("", selection: $showType) {
            ForEach(ShowType.allCases, id: \.self) { type in
                Text(type.rawValue).tag(type)
            }
//            Text(ShowType.rawValue).tag(ShowType.editor)
//            Text("P").tag(ShowType.preview)
//            Text("blue").tag(ShowType.editPreview)
        }
        .pickerStyle(.segmented)
        .padding()
        
        MainContentView(showType: $showType)
    }
}

struct MainContentView: View {
    @ObservedObject var fileVM = FileViewModel.shared
    
    @Binding var showType: ShowType
    
    var body: some View {
        switch showType {
        case .editor:
            TextEditor(text: $fileVM.textString)
        case .editPreview:
            GeometryReader { geometry in
                HStack {
                    
                    TextEditor(text: $fileVM.textString)
                        .frame(width: geometry.size.width / 2)
                    ScrollView {
                        Text(fileVM.textString)
                            .frame(maxWidth: geometry.size.width / 2, maxHeight: .infinity,alignment: .topLeading)
                    }
                }
            }
        case .preview:
            ScrollView {
                Text(fileVM.textString)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}

#Preview {
    ContentView()
}
