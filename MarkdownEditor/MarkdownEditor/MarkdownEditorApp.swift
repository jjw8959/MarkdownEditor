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
    @State private var document: ReadMeDocument?
    @State private var isAlreadySaved = false
    @State private var fileURL: URL?
    @State private var title: String = "untitled"
    @State private var showType: ShowType = .editor

    let fm = FileManager.default
    
    let fileVM = FileViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView(showType: $showType)
                .navigationTitle(title)
        }
        .commands {
            CommandGroup(after: .newItem) {
                Button("Save") {
                    document = ReadMeDocument(text: fileVM.textString)
                    if isAlreadySaved { // 덮어쓰기
                        guard let url = fileURL else {
                            return
                        }
                        do {
                            try fileVM.textString.write(to: url, atomically: true, encoding: .utf8)
                            self.fileURL = url
                            title = url.lastPathComponent
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                    } else {    // 초기 저장
                        saveFile()
                    }
                }
                .keyboardShortcut(KeyEquivalent("s"), modifiers: .command)
                
                Button("Save As") { saveBool.toggle() }
                .fileExporter(isPresented: $saveBool,
                                  document: document,
                                  contentType: .md,
                                  defaultFilename: "*")
                    { result in
                        switch result {
                        case .success(let url) :
                            title = url.lastPathComponent
                            print(url)
                        case .failure(let error) :
                            print(error)
                        }
                }
                .keyboardShortcut(KeyEquivalent("s"), modifiers: .command.union(.shift))
                
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
                        title = url.lastPathComponent
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                .keyboardShortcut(KeyEquivalent("o"), modifiers: .command)
            }
            
            CommandGroup(after: .sidebar) {
                Menu("Show Type") {
                    Button("Editor Only") {
                        showType = .editor
                    }
                    .keyboardShortcut("0", modifiers: .command)
                    
                    Button("Editor & Preview") {
                        showType = .editPreview
                    }
                    .keyboardShortcut("-", modifiers: .command)
                    
                    Button("Preview Only") {
                        showType = .preview
                    }
                    .keyboardShortcut("=", modifiers: .command)
                }
                
            }
            
        }
    }
    
    private func loadFileContent(from url: URL) {
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
    
    private func saveFile(/*content: String, url: URL*/) {
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.md]
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = false
//                        savePanel.title = "저장 위치를 선택하세요." // 타이틀바 내용
//                        savePanel.message = "저장할 파일의 위치를 선택하세요."  // 타이틀바 바로 밑에 안에 창의 내용
        savePanel.nameFieldStringValue = "blank"
        
        savePanel.begin { result in
            if result == .OK {
                guard let url = savePanel.url else { return }
                isAlreadySaved.toggle()
                do {
                    try fileVM.textString.write(to: url, atomically: true, encoding: .utf8)
                    fileURL = url
                    title = url.lastPathComponent
                    print(title)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}


