//
//  SaveAndShare.swift
//  Spark
//
//  Created by Robin Bettinghausen on 15.11.24.
//

import SwiftUI
import UIKit

struct SaveAndShare: UIViewControllerRepresentable {
    var image: UIImage
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        return controller
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
