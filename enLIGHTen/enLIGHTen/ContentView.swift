import SwiftUI
import Firebase

struct ContentView: View {
  @EnvironmentObject var session: SessionStore
  
  let rootRef = Database.database().reference(fromURL: "https://enlightenment-31974.firebaseio.com/")
  var messageRef: DatabaseReference!
  @State var switchesArray = [`switch`]()
  let userID = Auth.auth().currentUser?.uid
  @State var MLButtonAnimation:[Bool] = []
  @State var switchButtonAnimation:[Bool] = []
  

  
  
  func getSwitches() {
    DispatchQueue.main.asyncAfter(deadline: .now()) {
      for i in 1...3 {
        var count = 1
        let switches = `switch`()
        self.rootRef.child("Switches/Switch_\(i)/").observe(.childAdded) { (snapshot) in
          //print(snapshot.value! as! String)
          
          switch (count) {
          case 1: switches.ML_status = (snapshot.value! as! String)
          case 2: switches.Switch_status = (snapshot.value! as! String)
          case 3: switches.number = (snapshot.value! as! Int)
          default:
            print("")
          }
          
          count+=1
          
        }
        if (self.switchesArray.count < 3) {
          self.switchesArray.append(switches)
          self.switchButtonAnimation.append((switches.Switch_status == "ON") ? true : false)
          self.MLButtonAnimation.append((switches.ML_status == "ENABLED") ? true : false)
        } else {
          self.switchesArray[i] = switches
          self.switchButtonAnimation[i] = ((switches.Switch_status == "ON") ? true : false)
          self.MLButtonAnimation[i] = ((switches.ML_status == "ENABLED") ? true : false)
        }
        
      }
      
      print("Getswtiches was called")
      print(self.switchButtonAnimation)
      print(self.MLButtonAnimation)
    }
  }
  
  
  func fetchSwitches() {
    
    rootRef.child("Switches").observe(.childAdded) { (snapshot) in
        if let dictionary = snapshot.value as? [String : AnyObject] {
          let switches = `switch`()

          switches.ML_status = (dictionary["ML_status"] as! String)
          switches.Switch_status = (dictionary["Switch_status"] as! String)
          self.switchButtonAnimation.append((switches.Switch_status == "ON") ? true : false)
          self.MLButtonAnimation.append((switches.ML_status == "ON") ? true : false)

          //print(switches.ML_status! , switches.Switch_status!)
          self.switchesArray.append(switches)
        }
      }
    print("fetchswitches was called")
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
            
            ForEach (self.switchesArray.indices, id: \.self) { index in
                VStack {
                  // Name and Logo
                  HStack {
                    Text("Switch \(index + 1)")
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
                      if (self.switchesArray[index].Switch_status == "ON") {
                        self.rootRef.child("Switches/Switch_\(index + 1)/Switch_status").setValue("OFF")
                        self.rootRef.child("Switches/Switch_\(index + 1)/ML_status").setValue("DISABLED")
                        //self.switchesArray[index].toggleSwitch = false
                        self.switchesArray[index].Switch_status = "OFF"
                        self.MLButtonAnimation[index] = false
                        self.switchButtonAnimation[index] = false
                      } else {
                        self.rootRef.child("Switches/Switch_\(index + 1)/Switch_status").setValue("ON")
                        self.rootRef.child("Switches/Switch_\(index + 1)/ML_status").setValue("DISABLED")
                        //self.switchesArray[index].toggleSwitch = true
                        self.switchesArray[index].Switch_status = "ON"
                        self.MLButtonAnimation[index] = false
                        self.switchButtonAnimation[index] = true
                      }
                    })  {  // Inside button
                      Text(self.switchButtonAnimation[index] ? "On" : "Off")
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                        .foregroundColor(self.switchButtonAnimation[index] ? Color.white : Color.green)
                        .background(self.switchButtonAnimation[index] ? Color.green : Color.white)
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
                      if (self.switchesArray[index].ML_status == "ENABLED") {
                        self.rootRef.child("Switches/Switch_\(index + 1)/ML_status").setValue("DISABLED")
                        //self.switchesArray[index].toggleML = false
                        self.switchesArray[index].ML_status = "DISABLED"
                        //TODO
                        
                        self.MLButtonAnimation[index] = false
                      } else {
                        self.rootRef.child("Switches/Switch_\(index + 1)/ML_status").setValue("ENABLED")
                        //self.switchesArray[index].toggleML = true
                        self.switchesArray[index].ML_status = "ENABLED"
                        
                        //TODO
                        self.MLButtonAnimation[index] = true
                      }
                    }) {
                      Text("ML")
                        .padding(.horizontal, 40)
                        .padding(.vertical, 20)
                        .foregroundColor(self.MLButtonAnimation[index] ? Color.white : Color.green)
                        .background(self.MLButtonAnimation[index] ? Color.green : Color.white)
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
            } // For Each
            
            
          } // ScrollView Modifier
            .frame(maxWidth: .infinity)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: -1)
            .offset(y: screen.height / 4)
            //.onAppear{self.fetchSwitches()}
        }
        .onAppear{
          self.getSwitches()
          //self.fetchSwitches()
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
