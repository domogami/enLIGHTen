//
//  AuthView.swift
//  enLIGHTen
//
//  Created by Dominick Lee on 2/16/20.
//  Copyright © 2020 Dominick Lee. All rights reserved.
//

import SwiftUI


struct SignInView : View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signIn () {
        
        session.signIn(email: email, password: password) { (result, error) in
            
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            // Fancy Green Background
            VStack {
                Spacer()
            }
            .frame(width: screen.width, height: screen.height, alignment: .top)
            .frame(maxWidth: .infinity, maxHeight: screen.height)
            .background(Color("accent"))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color("accent").opacity(0.3), radius: 20, x: 0, y: 20)
            .offset(y: -(screen.height / 2))
            
            VStack (spacing: 20) {
                Text("enLIGHTen")
                    .foregroundColor(Color("background3"))
                    .font(.system(size: 40, weight: .medium, design: .default))
                    .padding(.horizontal, 40)
                    .padding(.top, 16)
                
                Spacer()
            }
            .padding(.top, 30)
            
            VStack {
                HStack {
                    Image(systemName: "lightbulb")
                        .font(.system(size: 40, weight: .regular, design: .default))
                        .frame(width: 90, height: 90)
                    
                }
                .background(Color("background3"))
                .cornerRadius(50)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                .padding(.top, 40)
                .padding(.bottom, 10)
                
                HStack {
                    Text("Login")
                    Spacer()
                }
                .padding(20)
                .padding(.horizontal, 20)
                
                TextField("email address", text: $email)
                    .frame(width: screen.width - 200)
                    .padding(15)
                    .padding(.horizontal, 20)
                    .background(Color("background3"))
                    .cornerRadius(50)
                    
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                
                HStack {
                    Text("Password")
                    Spacer()
                }
                .padding(20)
                .padding(.horizontal, 20)
                
                
                SecureField("Password", text: $password)
                    .frame(width: screen.width - 200)
                    .padding(15)
                    .padding(.horizontal, 20)
                    .background(Color("background3"))
                    .cornerRadius(50)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                
                
                Button(action: signIn) {
                    Text("Sign in")
                        .font(.system(size: 20, weight: .regular, design: .default))
                        
                        .foregroundColor(Color("background3"))
                        .padding(10)
                        .padding(.horizontal, 20)
                        .background(Color("accent"))
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    
                }
                .offset(y: 50)
                if (error != "") {
                    Text("ahhh crap")
                        .offset(y: -30)
                }
                
                
                Spacer()
            }
            .frame(width: screen.width - 60, height: screen.height * 2 / 3)
            .background(Color("background3"))
            .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            .offset(y: -30)
            
            // Bottom Button
            NavigationLink(
            destination: SignUpView()) {
                Text("Create An Account")
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .foregroundColor(Color("background3"))
                    .padding(10)
                    .padding(.horizontal, 20)
                    .background(Color("accent"))
                    .cornerRadius(50)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                // HARD CODE
                
            }
            .offset(y: 330)
            .animation(.easeInOut)
            
        }
        
    }
}

struct SignUpView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signUp() {
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            }
            else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            // Fancy Green Background
            VStack {
                Spacer()
            }
            .frame(width: screen.width, height: screen.height, alignment: .top)
            .frame(maxWidth: .infinity, maxHeight: screen.height)
            .background(Color("accent"))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color("accent").opacity(0.3), radius: 20, x: 0, y: 20)
            .offset(y: -(screen.height / 2))
            
            VStack {
                Text("Sign Up")
                    .foregroundColor(Color("background3"))
                    .font(.system(size: 40, weight: .medium, design: .default))
                    .padding(.horizontal, 40)
                    .padding(.top, 5)
                
                Spacer()
            }
            
            VStack {
                HStack {
                    Image(systemName: "lightbulb")
                        .font(.system(size: 40, weight: .regular, design: .default))
                        .frame(width: 90, height: 90)
                    
                }
                .background(Color("background3"))
                .cornerRadius(50)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                .padding(.top, 40)
                .padding(.bottom, 10)
                
                HStack {
                    Text("Email Address")
                    Spacer()
                }
                .padding(20)
                .padding(.horizontal, 20)
                
                TextField("example@gmail.com", text: $email)
                    .frame(width: screen.width - 200)
                    .padding(15)
                    .padding(.horizontal, 20)
                    .background(Color("background3"))
                    .cornerRadius(50)
                    
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                
                HStack {
                    Text("Password")
                    Spacer()
                }
                .padding(20)
                .padding(.horizontal, 20)
                
                
                SecureField("Password", text: $password)
                    .frame(width: screen.width - 200)
                    .padding(15)
                    .padding(.horizontal, 20)
                    .background(Color("background3"))
                    .cornerRadius(50)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                
                
                Button(action: signUp) {
                    Text("Create Account")
                        .font(.system(size: 20, weight: .regular, design: .default))
                        
                        .foregroundColor(Color("background3"))
                        .padding(10)
                        .padding(.horizontal, 20)
                        .background(Color("accent"))
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    
                }
                .offset(y: 50)
                if (error != "") {
                    Text(error)
                        .offset(y: -30)
                }
                
                
                Spacer()
            }
            .frame(width: screen.width - 60, height: screen.height * 2 / 3)
            .background(Color("background3"))
            .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            .offset(y: -30)
            
        }
    }
}

struct AuthView: View {
    var body: some View {
        NavigationView {
            SignInView()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(SessionStore())
    }
}
