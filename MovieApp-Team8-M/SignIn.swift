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
                    Spacer()
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
                .padding(18)
                VStack{
                    Text("Email")
                        .fontWeight(.light)
                        .foregroundStyle(Color.white)
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .top))
                        .padding(.horizontal, 20)
                    TextField("", text: $textInput, prompt: Text("Enter  your email")
                    .foregroundColor(Color.white))
                    .glassInput()
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
                        .padding(.horizontal, 17)
                    SecureField("", text: $textInput2, prompt: Text("Enter your password")
                    .foregroundColor(Color.white))
                    .glassInput()
                    .padding(.vertical, 13)
                    .padding(.bottom, 11)
                    .focused($focus, equals: .password)
                }
                .onAppear {
                    focus = .emailAddress
                }
                Button(action: {
                    print("HelloWorld")
                }) {
                VStack{
                    Text("Sign In")
                        .foregroundColor(Color.black)
                        .fontWeight(.semibold)
                        .font(.title2)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(Color("SignInGrey"))
                .cornerRadius(8)
                .padding(.bottom, 66)
                }
            }

        }
    }
}
enum FieldFocus: Hashable {
    case emailAddress
    case password
}
struct TextInputStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0), lineWidth: 2))
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 11)
    }
}
extension View {
    func glassInput() -> some View {
        self.modifier(TextInputStyle())
    }
}
#Preview {
    SignIn()
}
