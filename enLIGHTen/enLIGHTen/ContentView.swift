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
    //var SwitchArray: Array = []
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {
   
        Group {
            if (session.session != nil) {
                ZStack {
                    
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
                    
                    
                    
                    ScrollView {
                        // Switch Component
                        ForEach (1 ..< 3) { item in
                            VStack {
                                // Name and Logo
                                HStack {
                                    Text("Switch 1")
                                        .font(.system(size: 30, weight: .bold, design: .default))
                                    Spacer()
                                    Image(systemName: "lightbulb")
                                        .font(.system(size: 35, weight: .regular, design: .default))
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.green)
                                }
                                .foregroundColor(Color.green)
                                .frame(width: 300)
                                
                                HStack {
                                    // On Off Button
                                    Button(action: {
                                        if (self.toggleSwitch) {
                                            self.rootRef.child("Switch_1/Switch_status").setValue("OFF")
                                            self.toggleSwitch = false
                                        } else {
                                            self.rootRef.child("Switch_1/Switch_status").setValue("On")
                                            self.toggleSwitch = true
                                        }
                                    })  {  // Inside button
                                        Text(self.toggleSwitch ? "On" : "Off")
                                            .padding(.horizontal, 40)
                                            .padding(.vertical, 20)
                                            .foregroundColor(self.toggleSwitch ? Color.white : Color.green)
                                            .background(self.toggleSwitch ? Color.green : Color.white)
                                            .animation(.easeInOut)
                                            .cornerRadius(20)
                                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                        //.shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
                                    }
                                    Spacer()
                                    // ML Button
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
                                            .foregroundColor(self.toggleML ? Color.white : Color.green)
                                            .background(self.toggleML ? Color.green : Color.white)
                                            .animation(.easeInOut)
                                            .cornerRadius(20)
                                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                                        //.shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
                                    }
                                }
                                .padding(.top, 30)
                                .padding(.bottom, 10)
                                .frame(width: 300)
                                .frame(maxWidth: .infinity)
                            }
                            .frame(width: 300)
                            .padding(20)
                            .background(Color.white)
                            .cornerRadius(20)
                        } // For Each
                        
                    } // ScrollView Modifier
                        .frame(maxWidth: .infinity)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
                        .offset(y: screen.height / 4)
                }
                .padding(.top, 44)
                .edgesIgnoringSafeArea(.all)
                
                
            } else {
                AuthView()
            }
        }.onAppear(perform: getUser)
        
    }
}

struct Switches {
    let Switch: String
    let ML_status: String
    let Switch_status: String

    // Standard init
    init(Switch: String, ML_status: String, Switch_status: String) {
        self.Switch = Switch
        self.ML_status = ML_status
        self.Switch_status = Switch_status
    }

    // Init for reading from Database snapshot
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        Switch = snapshotValue["Switch"] as! String
        ML_status = snapshotValue["ML_status"] as! String
        Switch_status = snapshotValue["Switch_status"] as! String
    }

    // Func converting model for easier writing to database
    func toAnyObject() -> Any {
        return [
            "Switch": Switch,
            "ML_status": ML_status,
            "Switch_status": Switch_status
        ]
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}

let screen = UIScreen.main.bounds
