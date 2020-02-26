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
    
    let rootRef = Database.database().reference(fromURL: "https://enlightenment-31974.firebaseio.com/")
    var messageRef: DatabaseReference!
    @State private var toggleSwitch: Bool = false
    @State private var toggleML: Bool = false
    
    func getUser () {
        session.listen()
    }
    
    
//    let ref = Database.database().reference().child("Switch").child("Switch_status")
//
//    ref.observeSingleEvent(of: .childAdded, with: { (snapshot) in
//         if let userDict = snapshot.value as? [String:Any]
//    }
    
    var body: some View {
   
        Group {
            if (session.session != nil) {
                ZStack {
                    
//                    if self.Ml1 {
//                        //TODO
//                    }
                    
                    Color.green
                        .edgesIgnoringSafeArea(.all)
                    
                    // Fancy Green Background
                    VStack {
                        Spacer()
                    }
                    .frame(width: screen.width, height: screen.height, alignment: .top)
                    .frame(maxWidth: .infinity, maxHeight: screen.height)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color("accent").opacity(0.3), radius: 20, x: 0, y: 20)
                    .offset(y: (screen.height / 7))
                    
                    // Page Header and Sign Out
                    VStack {
                        HStack {
                            Text("Active Switches")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)

                            Spacer()

                            Button(action: session.signOut) {
                                VStack {
                                    Image(systemName: "person.crop.circle.badge.minus")
                                        .font(.system(size: 30, weight: .semibold, design: .default))
                                    Text("Sign Out")
                                        .font(.system(size: 15, weight: .semibold, design: .default))
                                }
                                .foregroundColor(.white)
                            }

                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 30)

                        Spacer()
                    }
                    .padding(.top, 70)
                    
                    
                    // Switch Component
                    
                    VStack {
                        HStack {
                            Text("Switch 1")
                                .font(.system(size: 30, weight: .bold, design: .default))
                            Spacer()
                            Image(systemName: "lightbulb")
                                .font(.system(size: 35, weight: .regular, design: .default))
                                .frame(width: 60, height: 60)
//                                .background(Color.green)
//                                .cornerRadius(30)
                                .foregroundColor(.green)
                        }
                        .foregroundColor(Color.green)
                        .frame(width: 300)
                        
                        HStack {
                            Button(action: {
                                if (self.toggleSwitch) {
                                    self.rootRef.child("Switch_1/Switch_status").setValue("OFF")
                                    self.toggleSwitch = false
                                } else {
                                    self.rootRef.child("Switch_1/Switch_status").setValue("On")
                                    self.toggleSwitch = true
                                }
                            })  {  // Inside button
                                Text(toggleSwitch ? "On" : "Off")
                                    .padding(.horizontal, 40)
                                    .padding(.vertical, 20)
                                    .foregroundColor(toggleSwitch ? Color.white : Color.green)
                                    .background(toggleSwitch ? Color.green : Color.white)
                                    .animation(.easeInOut)
                                    .cornerRadius(20)
                                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                    //.shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                if (self.toggleML) {
                                    self.rootRef.child("Switch_1/ML_status").setValue("DISABLED")
                                    self.toggleML = false
                                } else {
                                    self.rootRef.child("Switch_1/ML_status").setValue("enabled")
                                    self.toggleML = true
                                }
                            }) {
                                Text("ML")
                                    .padding(.horizontal, 40)
                                    .padding(.vertical, 20)
                                    .foregroundColor(toggleML ? Color.white : Color.green)
                                    .background(toggleML ? Color.green : Color.white)
                                    .animation(.easeInOut)
                                    .cornerRadius(20)
                                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                    //.shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
                            }
                        }
                        .padding(.top, 30)
                        .frame(width: 300)
                        
                        
                    }
                    .frame(width: 300)
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
                    .offset(y: -150)
                    
                    
                }
                .padding(.top, 44)
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
