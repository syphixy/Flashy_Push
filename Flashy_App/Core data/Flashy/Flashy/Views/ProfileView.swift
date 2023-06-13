//
//  ProfileView.swift
//  Flashy
//
//  Created by Artem on 2023-06-07.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct ProfileView: View {
    @State private var profileImage = Image(systemName: "person.circle.fill")
    @State private var showingImagePicker = false
    @State private var selectedUIImage: UIImage?
    @State var viewState = CGSize.zero
    @State var showProfile = false

    var body: some View {
        
        ZStack {
            Color("newgray")
                .edgesIgnoringSafeArea(.all)
                
            VStack {
                HStack {
                    Text("Profile")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                }

                VStack {
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        profileImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 170, height: 200)
                            .background(Circle())
                            .cornerRadius(20)
                            .aspectRatio(contentMode: .fit)
                    }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(selectedImage: $selectedUIImage)
                            .ignoresSafeArea()
                    }
                    .onChange(of: selectedUIImage) { newImage in
                        if let newImage = newImage {
                            profileImage = Image(uiImage: newImage)
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
