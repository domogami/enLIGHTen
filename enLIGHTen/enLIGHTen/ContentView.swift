//
//  ContentView.swift
//  enLIGHTen
//
//  Created by Dominick Lee on 2/6/20.
//  Copyright © 2020 Dominick Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {
   
        Group {
            if (session.session != nil) {
                Text("Welcome back user!")
                Button(action: session.signOut) {
                    Text("Sign Out")
                }
            } else {
                AuthView()
            }
        }.onAppear(perform: getUser)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}

let screen = UIScreen.main.bounds