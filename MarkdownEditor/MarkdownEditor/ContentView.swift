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
        Picker("View Type", selection: $showType) {
            ForEach(ShowType.allCases, id: \.self) { type in
                Text(type.rawValue).tag(type)
            }
        }
        .pickerStyle(.segmented)
        .padding([.top, .leading, .trailing], 8)
        .padding(.bottom, 1)
        
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
                .font(.title2)
            
        case .editPreview:
            GeometryReader { geometry in
                HStack {
                    TextEditor(text: $fileVM.textString)
                        .font(.title2)
                        .frame(width: geometry.size.width / 2)
                    ScrollView {
                        Markdown(fileVM.textString)
                            .frame(maxWidth: geometry.size.width / 2, maxHeight: .infinity,alignment: .topLeading)
                            .padding([.leading, .trailing], 3)
                    }
                }
            }
        case .preview:
            ScrollView {
                Markdown(fileVM.textString)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding([.leading, .trailing], 5)
            }
        }
    }
    
}

//#Preview {
//    ContentView()
//}
