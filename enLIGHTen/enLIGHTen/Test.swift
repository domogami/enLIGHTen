//
//  Test.swift
//  enLIGHTen
//
//  Created by Dominick Lee on 2/26/20.
//  Copyright © 2020 Dominick Lee. All rights reserved.
//

import SwiftUI

struct Test: View {
    @State var Ml1 = true
    @State var on1 = true
    var body: some View {
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
            
            VStack {
                HStack {
                    Text("Switch 1")
                        .font(.system(size: 30, weight: .bold, design: .default))
                    Spacer()
                    Image(systemName: "lightbulb")
                        .font(.system(size: 35, weight: .regular, design: .default))
                        .frame(width: 60, height: 60)
                        .background(Color.green)
                        .cornerRadius(30)
                        .foregroundColor(.white)
                }
                .foregroundColor(Color.green)
                .frame(width: 300)
                
                Toggle(isOn: $Ml1) {
                        Text("ML")
                            .fontWeight(.medium)
                            .foregroundColor(.green)
                    }
                
                    Toggle(isOn: $on1) {
                        Text("Turn On")
                            .fontWeight(.medium)
                            .foregroundColor(.green)
                    }
                
            }
            .frame(width: 300)
            .padding(20)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
            .offset(y: -150)
            
            VStack {
                HStack {
                    Text("Switch 1")
                        .font(.system(size: 30, weight: .bold, design: .default))
                    Spacer()
                    Image(systemName: "lightbulb")
                        .font(.system(size: 40, weight: .regular, design: .default))
                        .frame(width: 80, height: 80)
                }
                .foregroundColor(Color.green)
                .frame(width: 300)
                
                Toggle(isOn: $Ml1) {
                        Text("ML")
                            .fontWeight(.medium)
                            .foregroundColor(.green)
                    }
                
                    Toggle(isOn: $on1) {
                        Text("Turn On")
                            .fontWeight(.medium)
                            .foregroundColor(.green)
                    }
                
            }
            .frame(width: 300)
            .padding(20)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
            .offset(y: 100)
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
