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
                ZStack {
                    VStack {
                        Spacer()
                    }
                    
                        
                    VStack {
                        HStack {
                            Text("Active Switches")
                                .font(.system(size: 28, weight: .bold))
                            
                            Spacer()
                            
                            Button(action: session.signOut) {
                                Text("Sign Out")
                            }
                            
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 30)
                        
                        Spacer()
                    }
                    VStack {
                        HStack {
                            Text("Switch 1")
                            Image(systemName: "lightbulb")
                                .font(.system(size: 24, weight: .semibold))
                        }
                        .padding(20)
                        .background(Color.green)
                    }
                }
                .padding(.top, 44)
                .background(
                        VStack {
                            LinearGradient(gradient: Gradient(colors: [Color("background2"), Color.white]), startPoint: .top, endPoint: .bottom)
                                .frame(height: 200)
                            Spacer()
                        }
                        .background(Color.white)
                    )
                    .edgesIgnoringSafeArea(.all)
                
     
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
