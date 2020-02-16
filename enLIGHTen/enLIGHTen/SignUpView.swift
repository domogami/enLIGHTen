//
//  SignUpView.swift
//  enLIGHTen
//
//  Created by Dominick Lee on 2/15/20.
//  Copyright © 2020 Dominick Lee. All rights reserved.
//

import SwiftUI

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
        
        VStack {
            VStack {
                Text("Create Account")
                
                Text("Sign up to get Started")

                
                SecureField("Password", text: $password)
                
                
                if(error != "") {
                    Text(error)
                       
                }
                
            }
            
            Button (action: signUp) {
                Text("Create Account")
                    
            }
        }
    }
}

struct AuthView: View {
    var body: some View {
        NavigationView {
            SignUpView()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionStore())
    }
}
