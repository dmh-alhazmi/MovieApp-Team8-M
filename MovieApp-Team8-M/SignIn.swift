//
//  SignIn.swift
//  MovieApp-Team8-M
//
//  Created by Teif May on 04/07/1447 AH.
//


import SwiftUI

struct SignIn: View {
    
    @State private var textInput = ""
    @State private var textInput2 = ""
    @FocusState private var focus: FieldFocus?
    var body: some View {
        ZStack{
            Image("Sign in screen")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                VStack{
                    Text("Sign in")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .top))
                    Text("You'll find what you're looking for in the ocean of movies")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .top))
                }
                .padding(20)
                VStack{
                    Text("Email")
                        .fontWeight(.light)
                        .foregroundStyle(Color.white)
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .top))
                        .padding(.horizontal, 20)
                    TextField("Enter your email...", text: $textInput)
                        .textFieldStyle(.roundedBorder)
                        .padding(10)
                        .onSubmit {
                            print(textInput)
                            focus = .password
                        }
                        .focused($focus, equals: .emailAddress)
                    Text("Password")
                        .fontWeight(.light)
                        .foregroundStyle(Color.white)
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .top))
                        .padding(.horizontal, 20)
                    SecureField("Password", text:
                                $textInput2)
                    .textFieldStyle(.roundedBorder)
                    .padding(10)
                    .focused($focus, equals: .password)
                }
                .onAppear {
                    focus = .emailAddress
                }
            }
        }
    }
}
enum FieldFocus: Hashable {
    case emailAddress
    case password
}
#Preview {
    SignIn()
}
