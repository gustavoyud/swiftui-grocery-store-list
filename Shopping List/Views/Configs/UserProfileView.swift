//
//  UserProfileView.swift
//  Shopping List
//
//  Created by Gustavo Yud on 09/04/25.
//

import PhotosUI
import SwiftUI
import SwiftData
import UIKit

enum FocusedField {
    case firstName, lastName, email
}

struct UserProfileView: View {
    /**
        Name of the user.
     */
    @State private var name: String = ""
    
    /**
        Nickname of the user.
     */
    @State private var nickname: String = ""
    
    /**
        Email of the user.
     */
    @State private var email: String = ""

    /**
        The image of the user.
     */
    @State private var bgImage: UIImage? = nil

    /**
        The image of the user.
     */
    @State var selectedItems: [PhotosPickerItem] = []
    
    /**
        Data of image of the user.
     */
    @State var data: Data? = nil
    
    /**
        Provided user.
     */
    var user: User?
    
    /**
        The view model that will be used to create the products.
     */
    var vw = UserProfileViewModel()

    /**
        The context of the model.
     */
    @Environment(\.dismiss) var dismiss
    
    /**
        The context of the model.
     */
    @Environment(\.modelContext) private var context
    
    /**
        Focus state for the text fields.
     */
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        ScrollView {
            HStack {                
                Image(uiImage: bgImage ?? UIImage(resource: .user1))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(alignment: .bottomTrailing) {
                        PhotosPicker(selection: $selectedItems,
                                     maxSelectionCount: 1,
                                     matching: .images,
                                     photoLibrary: .shared())
                        {
                            Image(systemName: "pencil.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 30))
                                .foregroundColor(.accentColor)
                        }
                        .onChange(of: selectedItems) { newItems in
                            guard let item = newItems.first else { return }
                            Task {
                                if let imageData = try? await item.loadTransferable(type: Data.self) {
                                    data = imageData
                                    if let image = UIImage(data: imageData) {
                                     bgImage = image
                                 }
                                }
                            }
                        }
                        .buttonStyle(.borderless)
                    }

                VStack {
                    VStack {
                        TextField("", text: $name, prompt: Text("Nome")
                            .foregroundColor(.gray))
                            .padding(.vertical, 5)
                            .focused($focusedField, equals: .firstName)
                            .onSubmit {
                                focusedField = .lastName
                            }
                        Rectangle()
                            .frame(height: 0.5, alignment: .bottom)
                            .foregroundColor(Color.gray)
                    }
                    VStack {
                        TextField("", text: $nickname, prompt: Text("Sobrenome")
                            .foregroundColor(.gray))
                            .padding(.vertical, 5)
                            .focused($focusedField, equals: .lastName)
                            .onSubmit {
                                focusedField = .email
                            }
                        Rectangle()
                            .frame(height: 0.5, alignment: .bottom)
                            .foregroundColor(Color.gray)
                    }
                }
            }

            VStack {
                TextField("", text: $email, prompt: Text("E-mail")
                    .foregroundColor(.gray))
                    .padding(.vertical, 5)
                    .keyboardType(.emailAddress)
                    .focused($focusedField, equals: .email)
                    .onSubmit {
                        vw.save(user: user, name: name, nickname: nickname, email: email, data: data, context: context)
                        dismiss()
                    }
                Rectangle()
                    .frame(height: 0.5, alignment: .bottom)
                    .foregroundColor(Color.gray)
            }
        }
        .padding(.horizontal)
        .navigationTitle(user?.nameToString() ?? "Criar perfil")
        .onAppear {
            if let user = user {
                name = user.name
                nickname = user.nickname
                email = user.email
                if let data = user.photo {
                    bgImage = UIImage(data: data)
                }
            }
            focusedField = .firstName
        }
        .toolbar {
            Button(user != nil ? "Atualizar" : "Salvar") {
                vw.save(user: user, name: name, nickname: nickname, email: email, data: data, context: context)
                dismiss()
            }
        }
    }
}

#Preview {
    NavigationStack {
        UserProfileView()
    }
}
