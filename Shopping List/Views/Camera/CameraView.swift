//
//  CameraView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 28/03/25.
//
import SwiftUI
import UIKit

struct Camera: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        // MARK: Lifecycle

        init(parent: Camera) {
            self.parent = parent
        }

        // MARK: Internal

        var parent: Camera

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct CameraView: View {
    // MARK: Internal

    @Environment(\.dismiss) var dismiss

    var viewModel = CameraViewModel()
    var listModel: ListModel

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }

            if let image = image {
                HStack(spacing: 10) {
                    Button {
                        Task {
                            do {
                                loading = true
                                try await viewModel.importList(from: image, to: listModel)
                                loading = false
                                dismiss()
                            } catch {
                                loading = false
                                print(error.localizedDescription)
                            }
                        }
                    } label: {
                        if (loading) {
                            ProgressView()
                        } else {
                            Label("Usar essa", systemImage: "sparkles")
                        }
                    }.disabled(loading)
                    
                    
                    Button {
                        isPresented.toggle()
                    } label: {
                        Label("Tirar outra foto", systemImage: "arrow.counterclockwise.circle")
                    }
                }
            } else {
                Button {
                    isPresented.toggle()
                } label: {
                    Label("Tirar foto", systemImage: "camera")
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            Camera(image: $image)
        }
    }

    // MARK: Private

    @State private var image: UIImage?

    @State private var isPresented = false
    @State private var loading = false
}

#Preview {
    CameraView(listModel: ListModel(title: "Compras do mês", icon: "paperplane.fill", color: 3))
}
