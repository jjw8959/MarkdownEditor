//
//  MarkdownEditorApp.swift
//  MarkdownEditor
//
//  Created by woong on 5/9/24.
//

import SwiftUI

@main
struct MarkdownEditorApp: App {
    @State private var saveBool = false
    @State private var saveAsBool = false
    @State private var showType = 0 // 0 : EditorOnly , 1 : editor & preview, 2: PreviewOnly
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            // 아래와 같이 새로운 CommandMenu를 만들 수 있다.
//            CommandMenu("My Top Menu") {
//                Button("Sub Menu Item") { print("You pressed sub menu.") }
//                    .keyboardShortcut("S")
//            }
            
            //혹은 아래처럼 CommandGroup을 Button들로 만든다음 before, after, replacing 파라미터에 맞춰서 마음대로 위치를 지정할 수 있다.
            CommandGroup(after: .newItem) {
                Button("Save") { saveBool.toggle() }
                    .fileImporter(isPresented: $saveBool, allowedContentTypes: [.folder]) { result in
                        switch result {
                        case .success(let url) :
                            print("success: ",url)
                        case .failure(let error) :
                            print("fail: ",error)
                            
                        }
                    }
                    .keyboardShortcut(KeyEquivalent("s"), modifiers: .command)
                
                Button("Save As") { saveAsBool.toggle() }
                    .fileImporter(isPresented: $saveAsBool, allowedContentTypes: [.folder]) { result in
                        switch result {
                        case .success(let url) :
                            print("success: ",url)
                        case .failure(let error) :
                            print("fail: ",error)
                            
                        }
                    }
                    .keyboardShortcut(KeyEquivalent("s"), modifiers: .command.union(.shift))
            }
            
            CommandGroup(after: .sidebar) {
                Menu("Show Type") {
                    Button("Editor Only") {
                        
                    }
                    
                    Button("Editor & Preview") {
                        
                    }
                    .keyboardShortcut(KeyEquivalent("s"), modifiers: .command)
                    Button("Preview Only") {
                        
                    }
                    
                }
                
            }
        }
        
    }
}
