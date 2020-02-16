//
//  ContentView.swift
//  enLIGHTen
//
//  Created by Dominick Lee on 2/6/20.
//  Copyright © 2020 Dominick Lee. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    private var user = ""
    private var pass = ""
    
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
            }
            .frame(width: screen.width, height: screen.height, alignment: .top)
            .frame(maxWidth: .infinity, maxHeight: screen.height)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
            .offset(y: -(screen.height / 2))
            
            
            VStack (spacing: 20) {
                
                Text("enLIGHTen")
                    .foregroundColor(.white)
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
                .background(Color.white)
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
                
                TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .frame(width: screen.width - 200)
                    .padding(15)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .cornerRadius(50)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                
                HStack {
                    Text("Password")
                    Spacer()
                }
                .padding(20)
                .padding(.horizontal, 20)
                
                
                TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .frame(width: screen.width - 200)
                    .padding(15)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .cornerRadius(50)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Sign in")
                        .font(.system(size: 20, weight: .regular, design: .default))
                }
                .foregroundColor(Color.white)
                .padding(10)
                .padding(.horizontal, 20)
                .background(Color.green)
                .cornerRadius(50)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                .padding(.top, 60)
                
                
                Spacer()
                
            }
            .frame(width: screen.width - 60, height: screen.height * 2 / 3)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            .offset(y: -30)
            
            // Bottom Button
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Create An Account")
                    .font(.system(size: 20, weight: .regular, design: .default))
            }
            .foregroundColor(Color.white)
            .padding(10)
            .padding(.horizontal, 20)
            .background(Color.green)
            .cornerRadius(50)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            .padding(.top, screen.height - 200)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let screen = UIScreen.main.bounds
