//
//  MarkdownEditorApp.swift
//  MarkdownEditor
//
//  Created by woong on 5/9/24.
//

import SwiftUI

@main
struct MarkdownEditorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandMenu("My Top Menu") {
                Button("Sub Menu Item") { print("You pressed sub menu.") }
                    .keyboardShortcut("S")
            }
            CommandGroup(after: .newItem) {
                Button("Cut") { print("Cutting something...") }
                    .keyboardShortcut(KeyEquivalent("c"), modifiers: .command)
                Button("Paste") { print("Cutting something...") }
                    .keyboardShortcut(KeyEquivalent("v"), modifiers: .command)
            }
            
        }
        
    }
}
