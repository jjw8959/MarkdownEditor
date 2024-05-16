//
//  FileViewModel.swift
//  MarkdownEditor
//
//  Created by woong on 5/10/24.
//

import Foundation

final class FileViewModel: ObservableObject {
    static let shared = FileViewModel()
    @Published var textString = ""
}
