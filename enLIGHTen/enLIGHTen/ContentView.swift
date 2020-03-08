import SwiftUI
import Firebase

struct ContentView: View {
  @EnvironmentObject var session: SessionStore
  
  let rootRef = Database.database().reference(fromURL: "https://enlightenment-31974.firebaseio.com/")
  var messageRef: DatabaseReference!
  @State var switchesArray = [`switch`]()
  let userID = Auth.auth().currentUser?.uid

  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  @State var Switch_1_ML = "ENABLED"
  @State var Switch_1_Stat = "ON"
  @State var Switch_2_ML = "ENABLED"
  @State var Switch_2_Stat = "ON"
  @State var Switch_3_ML = "ENABLED"
  @State var Switch_3_Stat = "ON"
  
  func getSwitches() {
    DispatchQueue.main.asyncAfter(deadline: .now()) {
      
      var count1 = 1
      self.rootRef.child("Switches/Switch_1/").observe(.childAdded) { (snapshot) in
        switch (count1) {
        case 1: self.Switch_1_ML = (snapshot.value! as! String)
        case 2: self.Switch_1_Stat = (snapshot.value! as! String)
        default:
          print("")
        }
        count1+=1
      }
      var count2 = 1
      self.rootRef.child("Switches/Switch_2/").observe(.childAdded) { (snapshot) in
        switch (count2) {
        case 1: self.Switch_2_ML = (snapshot.value! as! String)
        case 2: self.Switch_2_Stat = (snapshot.value! as! String)
        default:
          print("")
        }
        count2+=1
      }
      var count3 = 1
      self.rootRef.child("Switches/Switch_3/").observe(.childAdded) { (snapshot) in
        switch (count3) {
        case 1: self.Switch_3_ML = (snapshot.value! as! String)
        case 2: self.Switch_3_Stat = (snapshot.value! as! String)
        default:
          print("")
        }
        count3+=1
      }
    }
  }
  
  
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
          
    
          ScrollView (.vertical, showsIndicators: false){
            // Switch Component
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
                    if (self.Switch_1_Stat == "ON") {
                      self.rootRef.child("Switches/Switch_1/Switch_status").setValue("OFF")
                      self.rootRef.child("Switches/Switch_1/ML_status").setValue("DISABLED")
                      self.Switch_1_Stat = "OFF"
                    } else {
                      self.rootRef.child("Switches/Switch_1/Switch_status").setValue("ON")
                      self.rootRef.child("Switches/Switch_1/ML_status").setValue("DISABLED")
                      self.Switch_1_Stat = "ON"
                    }
                  })  {  // Inside button
                    Text((self.Switch_1_Stat == "ON") ? "On" : "Off")
                      .padding(.horizontal, 40)
                      .padding(.vertical, 20)
                      .foregroundColor((self.Switch_1_Stat == "ON") ? Color.white : Color.green)
                      .background((self.Switch_1_Stat == "ON") ? Color.green : Color.white)
                      .animation(.easeInOut)
                      .cornerRadius(20)
                      .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                      .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    // More intense shadow
                    //.shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
                  }
                  Spacer()
                  // ML Button
                  Button(action: {
                    if (self.Switch_1_ML == "ENABLED") {
                      self.rootRef.child("Switches/Switch_1/ML_status").setValue("DISABLED")
                      self.Switch_1_ML = "DISABLED"
                    } else {
                      self.rootRef.child("Switches/Switch_1/ML_status").setValue("ENABLED")
                      self.Switch_1_ML = "ENABLED"
                    }
                  }) {
                    Text("ML")
                      .padding(.horizontal, 40)
                      .padding(.vertical, 20)
                      .foregroundColor((self.Switch_1_ML == "ENABLED") ? Color.white : Color.green)
                      .background((self.Switch_1_ML == "ENABLED") ? Color.green : Color.white)
                      //switchesArray[index].toggleML
                      .animation(.easeInOut)
                      .cornerRadius(20)
                      .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                      .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    // More intense shadow
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
            // For Each
            VStack {
                // Name and Logo
                HStack {
                  Text("Switch 2")
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
                    if (self.Switch_2_Stat == "ON") {
                      self.rootRef.child("Switches/Switch_2/Switch_status").setValue("OFF")
                      self.rootRef.child("Switches/Switch_2/ML_status").setValue("DISABLED")
                      self.Switch_2_Stat = "OFF"
                    } else {
                      self.rootRef.child("Switches/Switch_2/Switch_status").setValue("ON")
                      self.rootRef.child("Switches/Switch_2/ML_status").setValue("DISABLED")
                      self.Switch_2_Stat = "ON"
                    }
                  })  {  // Inside button
                    Text((self.Switch_2_Stat == "ON") ? "On" : "Off")
                      .padding(.horizontal, 40)
                      .padding(.vertical, 20)
                      .foregroundColor((self.Switch_2_Stat == "ON") ? Color.white : Color.green)
                      .background((self.Switch_2_Stat == "ON") ? Color.green : Color.white)
                      .animation(.easeInOut)
                      .cornerRadius(20)
                      .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                      .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    // More intense shadow
                    //.shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
                  }
                  Spacer()
                  // ML Button
                  Button(action: {
                    if (self.Switch_2_ML == "ENABLED") {
                      self.rootRef.child("Switches/Switch_2/ML_status").setValue("DISABLED")
                      self.Switch_2_ML = "DISABLED"
                    } else {
                      self.rootRef.child("Switches/Switch_2/ML_status").setValue("ENABLED")
                      self.Switch_2_ML = "ENABLED"
                    }
                  }) {
                    Text("ML")
                      .padding(.horizontal, 40)
                      .padding(.vertical, 20)
                      .foregroundColor((self.Switch_2_ML == "ENABLED") ? Color.white : Color.green)
                      .background((self.Switch_2_ML == "ENABLED") ? Color.green : Color.white)
                      //switchesArray[index].toggleML
                      .animation(.easeInOut)
                      .cornerRadius(20)
                      .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                      .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    // More intense shadow
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
            // For Each
            VStack {
                // Name and Logo
                HStack {
                  Text("Switch 3")
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
                    if (self.Switch_3_Stat == "ON") {
                      self.rootRef.child("Switches/Switch_3/Switch_status").setValue("OFF")
                      self.rootRef.child("Switches/Switch_3/ML_status").setValue("DISABLED")
                      self.Switch_3_Stat = "OFF"
                    } else {
                      self.rootRef.child("Switches/Switch_3/Switch_status").setValue("ON")
                      self.rootRef.child("Switches/Switch_3/ML_status").setValue("DISABLED")
                      self.Switch_3_Stat = "ON"
                    }
                  })  {  // Inside button
                    Text((self.Switch_3_Stat == "ON") ? "On" : "Off")
                      .padding(.horizontal, 40)
                      .padding(.vertical, 20)
                      .foregroundColor((self.Switch_3_Stat == "ON") ? Color.white : Color.green)
                      .background((self.Switch_3_Stat == "ON") ? Color.green : Color.white)
                      .animation(.easeInOut)
                      .cornerRadius(20)
                      .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                      .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    // More intense shadow
                    //.shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
                  }
                  Spacer()
                  // ML Button
                  Button(action: {
                    if (self.Switch_3_ML == "ENABLED") {
                      self.rootRef.child("Switches/Switch_3/ML_status").setValue("DISABLED")
                      self.Switch_3_ML = "DISABLED"
                    } else {
                      self.rootRef.child("Switches/Switch_3/ML_status").setValue("ENABLED")
                      self.Switch_3_ML = "ENABLED"
                    }
                  }) {
                    Text("ML")
                      .padding(.horizontal, 40)
                      .padding(.vertical, 20)
                      .foregroundColor((self.Switch_3_ML == "ENABLED") ? Color.white : Color.green)
                      .background((self.Switch_3_ML == "ENABLED") ? Color.green : Color.white)
                      //switchesArray[index].toggleML
                      .animation(.easeInOut)
                      .cornerRadius(20)
                      .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                      .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                    // More intense shadow
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
            // For Each
            .onReceive(timer) { input in
                self.getSwitches()
            }
            
            
            
            
            
            
          } // ScrollView Modifier
            .frame(maxWidth: .infinity)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
            .offset(y: screen.height / 4)
            .onTapGesture {
              self.getSwitches()
            }
          
          //.onAppear{self.fetchSwitches()}
        }
        .onAppear{
          self.getSwitches()
        }
        
          
        .padding(.top, 44)
        .edgesIgnoringSafeArea(.all)
        
        
      } else {
        AuthView()
      }
    }.onAppear(perform: getUser)
    
  }
}

class `switch`:ObservableObject {
  
  var ML_status: String?
  var Switch_status: String?
  var number: Int?
}




struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(SessionStore())
  }
}

let screen = UIScreen.main.bounds
