//
//  ContentView.swift
//  MarkdownEditor
//
//  Created by woong on 5/9/24.
//

import SwiftUI

struct ContentView: View {
    @State var filename = "Filename"
    @State var showFileChooser = false
    
    var body: some View {
        HStack {
            Text(filename)
            Button("select File") {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = false
                if panel.runModal() == .OK {
                    self.filename = panel.url?.lastPathComponent ?? "<none>"
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
