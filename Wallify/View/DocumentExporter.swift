//
//  DocumentExporter.swift
//  Wallify
//
//  Created by Mahmut Özkan on 5.06.2025.
//

import SwiftUI
import UniformTypeIdentifiers

struct DocumentExporter: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forExporting: [url])
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}
