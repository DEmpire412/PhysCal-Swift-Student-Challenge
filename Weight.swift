import SwiftUI
import Combine
import LaTeXSwiftUI

struct Weight: View {
    //Initializes input string variables
    @State private var M: String = ""
    @State private var W: String = ""
    @State private var showPopover = false
    
    var body: some View {
        ScrollView {
            VStack {
                //Gives user directions on which box to enter
                Text("Enter known value. Leave unknown value empty. Calculation automatically populates! To copy your result, simply long-press. Click on i-button to learn more!")
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .padding(20.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                //Allows user to input the values
                TextField("Mass (kg)", text: $M.blockingNumbersAndPunctuation())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                

                    .keyboardType(.numbersAndPunctuation)

                TextField("Weight (N)", text: $W.blockingNumbersAndPunctuation())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                

                    .keyboardType(.numbersAndPunctuation)

            }
            //Converts the string values into numerical values
            let mass: Double = Double(M) ?? 0
            let weight: Double = Double(W) ?? 0
            
            //Conditional statements based on which text boxes are full and empty
            VStack {
                if(W.isEmpty && !M.isEmpty) {
                    let weight: Double = mass * 9.80665
                    ScrollView(.horizontal) {
                        HStack (spacing: 0){
                            Text("Weight: ")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                            Text(String(weight))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = String(weight)
                                    }) {
                                        HStack {
                                            Image(systemName: "doc.on.doc")
                                            Text("Copy")
                                        }                                        }
                                }
                                .frame(alignment: .leading)
                                .textSelection(.enabled)
                            Text(" N")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                
                else if(!W.isEmpty && M.isEmpty) {
                    let mass: Double = weight / 9.80665
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
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = String(mass)
                                    }) {
                                        HStack {
                                            Image(systemName: "doc.on.doc")
                                            Text("Copy")
                                        }                                        }
                                }
                                .frame(alignment: .leading)
                                .textSelection(.enabled)
                            Text(" kg")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
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
                            Text("Weight is often confused with mass, but they are not the same. Mass is the amount of matter in an object while weight is the gravity exerted on that object. Weight can be calculated by multiplying the mass by the gravitational acceleration constant, which on Earth, is 9.80665. This means that if you go to a different planet with a different gravity, your weight will change but your mass will stay the same. For example, if you weigh 150 pounds on Earth, you will weigh only 25 pounds on the Moon, but you will still have the same amount of matter in your body. So don't get too excited about losing weight on the Moon, because you will still be as fat as you were on Earth. Right now, however, this calculator can only calculate weight on Earth.")
                                .multilineTextAlignment(.center)
                                .font(.headline)
                                .padding(20)
                            Spacer(minLength: 20)
                            // Formula
                            HStack {
                                LaTeX("$$W = mg$$")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "arrow.right")
                                    .font(.title)
                                LaTeX("$$m = \\frac{W}{g}$$")
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                            Text("W = Weight, m = Mass, g = Gravitational Acceleration Constant")
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
                                        Text("Weight: 98.0665 N")
                                        Text("Mass: 10 kg")
                                    }.navigationTitle("Weight")
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
        .navigationTitle("Weight")
    }
    
    
    struct Weight_Previews: PreviewProvider {
        static var previews: some View {
            Weight()
        }
    }
}

