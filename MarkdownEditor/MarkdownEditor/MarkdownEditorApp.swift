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
    @State private var openBool = false
    @State private var showType = 0 // 0 : EditorOnly , 1 : editor & preview, 2: PreviewOnly
    @State private var document: ReadMeDocument?
    
    let fm = FileManager.default
    
    let fileVM = FileViewModel.shared
    
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
                Button("Save") {
                    document = ReadMeDocument(text: fileVM.textString)
                    saveBool.toggle()
                }
                //                .keyboardShortcut("s")
                .fileExporter(isPresented: $saveBool,
                              document: document,
                              contentType: .md,
                              defaultFilename: "*")
                { result in
                    switch result {
                    case .success(let url) :
                        print(url)
                    case .failure(let error) :
                        print(error)
                    }
                }
                .keyboardShortcut(KeyEquivalent("s"), modifiers: .command)
                
                Button("Open") {
                    openBool.toggle()
                }
                .fileImporter(isPresented: $openBool,
                              allowedContentTypes: [.plainText])
                { result in
                    switch result {
                    case .success(let file):
                        guard let url = URL(string: file.absoluteString) else {
                            print("there's no file")
                            return
                        }
                        loadFileContent(from: url)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                .keyboardShortcut(KeyEquivalent("o"), modifiers: .command)
                //                    .fileImporter(isPresented: $saveBool, allowedContentTypes: [.folder]) { result in
                //                        switch result {
                //                        case .success(let url) :
                ////                            let documentURL = fm.urls(for: .documentDirectory, in: .allDomainsMask)[0]
                //                            NSSavePanel()
                //
                //                        case .failure(let error) :
                //                            print("fail: ",error)
                //
                //                        }
                //                    }
                //                Button("Save As") { saveAsBool.toggle() }
                //                    .fileImporter(isPresented: $saveAsBool, allowedContentTypes: [.folder]) { result in
                //                        switch result {
                //                        case .success(let url) :
                //                            print("success: ",url)
                //                        case .failure(let error) :
                //                            print("fail: ",error)
                //
                //                        }
                //                    }
                //                    .keyboardShortcut(KeyEquivalent("s"), modifiers: .command.union(.shift))
            }
            
            CommandGroup(after: .sidebar) {
                Menu("Show Type") {
                    Button("Editor Only") {
                        
                    }
                    
                    Button("Editor & Preview") {
                        
                    }
                    Button("Preview Only") {
                        
                    }
                    
                }
                
            }
        }
        
    }
    
    func loadFileContent(from url: URL) {
        do {
            // 파일 URL에서 텍스트 읽기
            guard url.startAccessingSecurityScopedResource() else { return }
            let text = try String(contentsOf: url)
            fileVM.textString = text // 읽은 내용을 상태 변수에 저장
            print(fileVM.textString)
            url.stopAccessingSecurityScopedResource()
        } catch {
            print("파일 읽기 오류: \(error)")
            fileVM.textString = "파일을 읽을 수 없습니다."
        }
    }
    
}


