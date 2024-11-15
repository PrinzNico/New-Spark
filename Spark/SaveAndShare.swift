//
//  SaveAndShare.swift
//  Spark
//
//  Created by Robin Bettinghausen on 15.11.24.
//
//MARK: - Diese View - Funktionen sind wichtig für das Feature für das abspeichern unserer Zitate die im nachhinnein versendet werden können. WICHTIG !! import UIKit !!
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
