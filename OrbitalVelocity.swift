import SwiftUI
import LaTeXSwiftUI
import Combine

struct OrbitalVelocity: View {
    //Initializes input string variables
    @State private var v: String = ""
    @State private var m: String = ""
    @State private var r: String = ""
    @State private var showPopover = false
    
    
    var body: some View {
        ScrollView {
            VStack {
                //Gives user directions on which boxes to enter
                Text("Enter known values. Leave unknown values empty. Calculation automatically populates! To copy your result, simply long-press. Click on i-button to learn more!")
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .padding(20.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                //Allows user to input the values
                TextField("Velocity (m/s)", text: $v.blockingNumbersAndPunctuation())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                

                    .keyboardType(.numbersAndPunctuation)

                TextField("Mass (kg)", text: $m.blockingNumbersAndPunctuation())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                

                    .keyboardType(.numbersAndPunctuation)

                TextField("Radius (m) ", text: $r.blockingNumbersAndPunctuation())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                

                    .keyboardType(.numbersAndPunctuation)

            }
            //Converts the string values into numerical values
            let velocity: Double = Double(v) ?? 0
            let mass: Double = Double(m) ?? 0
            let radius: Double = Double(r) ?? 0
            let G = 6.67e-11
            
            //Conditional statements based on which text boxes are full and empty
            VStack {
                if (v.isEmpty && !m.isEmpty && !r.isEmpty) {
                    let velocity: Double = sqrt((G * mass)/radius)
                    ScrollView(.horizontal) {
                        HStack (spacing: 0){
                            Text("Velocity: ")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                            Text(String(velocity))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = String(mass)
                                    }) {
                                        HStack {
                                            Image(systemName: "doc.on.doc")
                                            Text("Copy")
                                        }                                    }
                                }
                                .textSelection(.enabled)
                            Text(" m/s")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                else if (!v.isEmpty && m.isEmpty && !r.isEmpty) {
                    let mass: Double = (pow(velocity, 2) * radius) / G
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
                                        }                                    }
                                }
                                .frame(alignment: .leading)
                                .textSelection(.enabled)
                            Text(" kg")
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
                                        }                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                else if (!v.isEmpty && !m.isEmpty && r.isEmpty) {
                    let radius: Double = (mass * G) / (pow(velocity, 2))
                    ScrollView(.horizontal) {
                        HStack (spacing: 0){
                            Text("Radius: ")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                            Text(String(radius))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = String(radius)
                                    }) {
                                        HStack {
                                            Image(systemName: "doc.on.doc")
                                            Text("Copy")
                                        }                                    }
                                }
                                .frame(alignment: .leading)
                                .textSelection(.enabled)
                            Text(" m")
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
                            Text("Orbital velocity is not just a fancy term for how fast you can spin around in circles. It's actually a very important concept in physics and astronomy. Orbital velocity is the speed at which an object needs to move in order to orbit around another object. For example, the Earth orbits around the Sun at an average speed of about 30 kilometers per second. That's pretty fast, right? But if the Earth moved any slower, it would fall into the Sun and burn up. And if it moved any faster, it would escape the Sun's gravity and fly away into space.")
                                .multilineTextAlignment(.center)
                                .padding(20)
                                .font(.headline)
                            Spacer(minLength: 20)
                            // Formula
                            LaTeX("$$v = \\sqrt{\\frac{GM}{r}}$$")
                            Text("v = Velocity, G = Gravitational Constant, M = mass, r = radius")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(7.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                            SubSuperScriptText(inputString: "Gravitational Constant = 6.67 • 10^{-11}", bodyFont: .callout, subScriptFont: .caption, baseLine: 6.0)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(7.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Spacer(minLength: 40)
                            // Example
                            VStack(spacing: 10) {
                                Text("Example")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Divider()
                                HStack(spacing: 30) {
                                    // Box representing the object
                                    Circle()
                                        .fill(
                                            RadialGradient(
                                                gradient: Gradient(colors: [.blue, .gray]),
                                                center: .center,
                                                startRadius: 0,
                                                endRadius: 50
                                            )
                                        )
                                        .frame(width: 50, height: 50)
                                    // Labels showing the object's properties
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("Mass: 1,000,000 kg")
                                        Text("Radius: 0.000025 m")
                                        Text("Velocity: 1.6334013591276333 m/s")
                                    }.navigationTitle("Orbital Velocity")
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
        .navigationTitle("Orbital Velocity")
    }
}

struct OrbitalVelocity_Previews: PreviewProvider {
    static var previews: some View {
        OrbitalVelocity()
    }
}
