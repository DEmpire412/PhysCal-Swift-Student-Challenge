import SwiftUI
import LaTeXSwiftUI
import Combine

struct ProjectileMotion: View {
    //Initializes input string variables
    @State private var Vi: String = ""
    @State private var AofL: String = ""
    @State private var h: String = ""
    @State private var showPopover = false
    
    var body: some View {
        ScrollView {
            VStack {
                //Gives user directions on which box(es) to enter
                Text("Enter values to calculate time of flight, distance, and maximum height. Calculation automatically populates! To copy your result, simply long-press. Click on i-button to learn more!")
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .padding(20.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                //Allows user to input the values
                TextField("Initial Velocity (m/s)", text: $Vi.blockingNumbersAndPunctuation())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                

                    .keyboardType(.numbersAndPunctuation)

                TextField("Angle of Launch (deg)", text: $AofL.blockingNumbersAndPunctuation())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                

                    .keyboardType(.numbersAndPunctuation)

                TextField("Launch height (m)", text: $h.blockingNumbersAndPunctuation())
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                

                    .keyboardType(.numbersAndPunctuation)

            }
            //Conditional statements based on which text boxes are full and empty
            VStack {
                if (!Vi.isEmpty && !AofL.isEmpty && !h.isEmpty) {
                    let initialVelocity = Double(Vi) ?? 0
                    let angleOfLaunch = Double(AofL) ?? 0
                    let angleOfLaunchRad = angleOfLaunch * Double.pi / 180
                    let initialHeight = Double(h) ?? 0
                    let sinAoL: Double = sin(angleOfLaunchRad)
                    let horizontalVelocity: Double = initialVelocity * cos(angleOfLaunchRad)
                    let verticalVelocity: Double = initialVelocity * sin(angleOfLaunchRad)
                    let vSquared: Double = pow(verticalVelocity, 2)
                    let viSquared: Double = pow(initialVelocity, 2)
                    let sinSquared: Double = pow(sinAoL, 2)
                    let tOFEQ: Double = vSquared + 2 * 9.80665 * initialHeight
                    let timeOfFlight: Double = (verticalVelocity + sqrt(tOFEQ)) / 9.80665
                    let range: Double = horizontalVelocity * (verticalVelocity + (sqrt(vSquared + 2 * 9.80665 * initialHeight))) / 9.80665
                    let maximumHeight: Double = initialHeight + (viSquared * sinSquared / 19.6133)
                    ScrollView(.horizontal) {
                        HStack (spacing: 0){
                            Text("Time of flight: ")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                            Text(String(timeOfFlight))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = String(timeOfFlight)
                                    }) {
                                        HStack {
                                            Image(systemName: "doc.on.doc")
                                            Text("Copy")
                                        }                                    }
                                }
                                .textSelection(.enabled)
                            Text(" s")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    ScrollView(.horizontal) {
                        HStack (spacing: 0){
                            Text("Distance: ")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                            Text(String(range))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = String(range)
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
                    ScrollView(.horizontal) {
                        HStack (spacing: 0){
                            Text("Maximum Height: ")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                            Text(String(maximumHeight))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = String(maximumHeight)
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
                            Text("If you ever want to impress your friends with your physics knowledge, just throw something in the air and explain how the object you threw is moving along a curved path because of gravity, while its horizontal speed stays the same. You can use examples like balls, arrows, or bullets to illustrate your point. But don't actually throw bullets, that's dangerous. And don't throw arrows either, unless you have a bow. And don't throw balls at people's faces, unless they are playing dodgeball. Just be careful with what you throw, okay?")
                                .multilineTextAlignment(.center)
                                .font(.headline)
                            Spacer(minLength: 20)
                            // Formula
                            LaTeX("$$t = \\frac{V•sin(θ) + \\sqrt{(V•sin(θ)^2) + 2gh}}{g}$$")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("Time of Flight")
                                .font(.headline)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(7.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("V = Initial Velocity, θ = Angle of Launch, h = Initial Height, g = Acceleration due to gravity (on Earth, 9.80665)")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(7.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }.padding(20)
                        Spacer(minLength: 40)
                        
                        VStack {
                            LaTeX("$$d = V•cos(θ) • \\frac{(V•sin(θ)) + \\sqrt{(V•sinθ)^2 + 2gh}}{g}$$")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("Distance")
                                .font(.headline)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(7.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("d = Distance, V = Initial Velocity, θ = Angle of Launch, h = Initial Height, g = Acceleration due to gravity (on Earth, 9.80665)")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(7.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Spacer(minLength: 40)
                        }.padding(20)
                        VStack {
                            LaTeX("$$H = h + \\frac{(V • sin(θ)^2}{2g}$$")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("Maximum Height")
                                .font(.headline)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(7.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("V = Initial Velocity, θ = Angle of Launch, h = Initial Height, g = Acceleration due to gravity (on Earth, 9.80665)")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(7.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Spacer(minLength: 40)
                        }.padding(20)
                        Spacer(minLength: 40)
                        // Example
                        VStack(spacing: 10) {
                            Text("Example")
                                .font(.title)
                                .fontWeight(.bold)
                            Divider()
                            ZStack {
                                // Draw the projectile
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 10, height: 10)
                                    .padding(.bottom, 40)
                                // Draw the ground
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(height: 1)
                            }
                            .padding(20)
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Initial Velocity: 1,000,000 kg")
                                Text("Angle of Launch: 0.000025 m")
                                Text("Launch Height: 1.6334013591276333 m/s")
                                Text("Time of Flight: 1,000,000 kg")
                                Text("Distance: 0.000025 m")
                                Text("Maximum Height: 1.6334013591276333 m/s")
                            }.navigationTitle("Projectile Motion")
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
        }.navigationTitle("Projectile Motion")
    }
}


struct ProjectileMotion_Previews: PreviewProvider {
    static var previews: some View {
        ProjectileMotion()
    }
}
