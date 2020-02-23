//
//  ContentView.swift
//  enLIGHTen
//
//  Created by Dominick Lee on 2/6/20.
//  Copyright © 2020 Dominick Lee. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    
    //var rootRef = Database.database().reference()
    let rootRef = Database.database().reference(fromURL: "https://enlightenment-31974.firebaseio.com/")
    var messageRef: DatabaseReference!
    
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
                            VStack {
                                Button(action: {
                                    self.rootRef.child("Switch_1/Switch_status").setValue("On")
                                }) {
                                    Text("Switch 1 On")
                                }
                                Button(action: {
                                    self.rootRef.child("Switch_1/Switch_status").setValue("OFF")
                                }) {
                                    Text("Switch 1 off")
                                }
                            }
                            Image(systemName: "lightbulb")
                                .font(.system(size: 24, weight: .semibold))
                        }
                        .padding(20)
                        .background(Color("accent"))
                    }
                }
                .padding(.top, 44)
                .background(
                        VStack {
                            LinearGradient(gradient: Gradient(colors: [Color("background2"), Color("background3")]), startPoint: .top, endPoint: .bottom)
                                .frame(height: 200)
                            Spacer()
                        }
                        .background(Color("background3"))
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
