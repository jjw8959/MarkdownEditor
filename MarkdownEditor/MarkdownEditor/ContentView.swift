//
//  ContentView.swift
//  MarkdownEditor
//
//  Created by woong on 5/9/24.
//

import SwiftUI
import MarkdownUI

struct ContentView: View {
    @Binding var showType: ShowType
    
    var body: some View {
        Picker("", selection: $showType) {
            ForEach(ShowType.allCases, id: \.self) { type in
                Text(type.rawValue).tag(type)
            }
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
                        Markdown(fileVM.textString)
                            .frame(maxWidth: geometry.size.width / 2, maxHeight: .infinity,alignment: .topLeading)
                    }
                }
            }
        case .preview:
            ScrollView {
                Markdown(fileVM.textString)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
    
}

//#Preview {
//    ContentView()
//}
