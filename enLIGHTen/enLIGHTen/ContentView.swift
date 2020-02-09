//
//  ContentView.swift
//  enLIGHTen
//
//  Created by Dominick Lee on 2/6/20.
//  Copyright © 2020 Dominick Lee. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    @State var user = ""
    @State var pass = ""
    
    var body: some View {
        
        VStack {
            Text("enLIGHTen")
                .font(.title)
                .padding(20)
            
            Text("A new take on sustainability")
            
            Spacer()
            
            HStack {
     
                Text("Login")
                    .padding(20)
                Spacer()
            }
            TextField("Email", text: $user)
                .padding(20)
            
            HStack {

                Text("Password")
                    .padding(20)
                Spacer()
            }
            TextField("⋅⋅⋅⋅⋅⋅⋅", text: $pass)
                .padding(20)
            
            Spacer()
            
            Button(action: {}) {
                HStack {
                    Spacer()
                    Text("Sign in")
                    Spacer()
                }
                Spacer()
            }
            Spacer()
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
