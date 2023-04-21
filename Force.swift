import SwiftUI
import Combine
import LaTeXSwiftUI

struct Force: View {
    //Initializes input string variables
    @State private var F: String = ""
    @State private var m: String = ""
    @State private var a: String = ""
    @State private var showPopover = false
    
    
    var body: some View {
        ScrollView {
            VStack {
                //Gives user directions on which box to enter
                Text("Enter known values. Leave unknown values empty. Calculation automatically populates! To copy your result, simply long-press. Click on i-button to learn more!")
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .padding(20.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                //Allows user to input the values
                TextField("Force (N)", text: $F.blockingNumbersAndPunctuation())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                

                    .keyboardType(.numbersAndPunctuation)

                TextField("Mass (kg)", text: $m.blockingNumbersAndPunctuation())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                

                    .keyboardType(.numbersAndPunctuation)

                TextField("Acceleration (m/s^2)", text: $a.blockingNumbersAndPunctuation())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                

                    .keyboardType(.numbersAndPunctuation)

            }
            
            //Converts the string values into numerical values
            let Force: Double = Double(F) ?? 0
            let mass: Double = Double(m) ?? 0
            let acceleration: Double = Double(a) ?? 0
            
            //Conditional statements based on which text boxes are full and empty
            VStack {
                if (F.isEmpty && !m.isEmpty && !a.isEmpty) {
                    let Force: Double = mass * acceleration
                    ScrollView(.horizontal) {
                        HStack (spacing: 0){
                            Text("Force: ")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                            Text(String(Force))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                                .textSelection(.enabled)
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = String(Force)
                                    }) {
                                        HStack {
                                            Image(systemName: "doc.on.doc")
                                            Text("Copy")
                                        }                                    }
                                }
                            Text(" N")
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                else if (!F.isEmpty && m.isEmpty && !a.isEmpty) {
                    let mass: Double = Force / acceleration
                    ScrollView(.horizontal) {
                        HStack (spacing: 0){
                            Text("Mass: ")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                            Text(String(mass))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                                .textSelection(.enabled)
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = String(mass)
                                    }) {
                                        HStack {
                                            Image(systemName: "doc.on.doc")
                                            Text("Copy")
                                        }                                    }
                                }
                            Text(" kg")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                else if (!F.isEmpty && !m.isEmpty && a.isEmpty) {
                    let acceleration: Double = Force / mass
                    ScrollView(.horizontal) {
                        HStack (spacing: 0){
                            Text("Acceleration: ")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                            Text(String(acceleration))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                                .textSelection(.enabled)
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = String(acceleration)
                                    }) {
                                        HStack {
                                            Image(systemName: "doc.on.doc")
                                            Text("Copy")
                                        }                                    }
                                }
                            SubSuperScriptText(inputString: " m/s^{2}", bodyFont: .callout, subScriptFont: .caption, baseLine
                                               : 6.0)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.medium)
                            .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            //Info-circle popup
            .toolbar {
                Button(action: {
                    showPopover = true
                }) {
                    Image(systemName: "info.circle")
                }
            }
            //Popover sheet view
            .sheet(isPresented: $showPopover) {
                NavigationView {
                    ScrollView {
                        VStack {
                            Spacer(minLength: 20)
                            // Description
                            Text("If you ever wondered how to calculate the force needed to push a stubborn donkey, you can use Newton's Second Law of motion. This law states that the acceleration of an object is directly proportional to the force applied on it, and inversely proportional to its mass. In other words, the more force you use, the faster the donkey will move, and the heavier the donkey is, the more force you need.")
                                .multilineTextAlignment(.center)
                                .font(.headline)
                                .padding(20)
                            Spacer(minLength: 20)
                            // Formula
                            HStack {
                                LaTeX("$$F = ma$$")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "arrow.right")
                                    .font(.title)
                                LaTeX("$$a = \\frac{F}{m}$$")
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                            Text("F = Force, m = Mass, a = Acceleration")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(7.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Spacer(minLength: 20)
                            // Example
                            VStack(spacing: 10) {
                                Text("Example")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Divider()
                                HStack(spacing: 30) {
                                    // Box representing the object
                                    Rectangle()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.blue)
                                    
                                    // Labels showing the object's properties
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("Mass: 50 kg")
                                        Text("Force: 100 N")
                                        Text("Acceleration: 2 m/s²")
                                    }.navigationTitle("Force: Newton's Second Law")
                                        .toolbar {
                                            ToolbarItem(placement: .navigationBarTrailing) {
                                                Button(action: {
                                                    showPopover = false
                                                }) {
                                                    Image(systemName: "xmark")
                                                }
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Force")
    }
}

struct Force_Previews: PreviewProvider {
    static var previews: some View {
        Force()
    }
}
