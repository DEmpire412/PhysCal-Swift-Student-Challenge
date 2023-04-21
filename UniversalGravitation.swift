import SwiftUI
import Combine
import LaTeXSwiftUI

struct UniversalGravitation: View {
    //Initializes input string variables
    @State private var Fb: String = ""
    @State private var Fe: String = ""
    @State private var m1b: String = ""
    @State private var m1e: String = ""
    @State private var m2b: String = ""
    @State private var m2e: String = ""
    @State private var rb: String = ""
    @State private var re: String = ""
    @State private var showPopover = false
    
    //Function to format output number in scientific notation
    func formatNumber(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.exponentSymbol = " • 10^"
        formatter.maximumSignificantDigits = 4
        formatter.maximumFractionDigits = 3
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
    
    var body: some View {
        ScrollView {
            VStack {
                //Gives user directions on which box to enter
                Text("Enter known values in scientific notation. Leave unknown values empty. Calculation automatically populates! To copy your result, simply long-press. Click on i-button to learn more!")
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .padding(20.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                //Allows user to input the values
                HStack {
                    VStack(alignment: .leading){
                        TextField("G. Force (N)", text: $Fb.blockingNumbersAndPunctuation())
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        

                            .keyboardType(.numbersAndPunctuation)

                    }
                    Spacer()
                    VStack(alignment: .leading){
                        Text("• 10^")
                            .fontWeight(.medium)
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        TextField("", text: $Fe.blockingNumbersAndPunctuation())
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        

                            .keyboardType(.numbersAndPunctuation)

                    }
                }
                HStack {
                    VStack(alignment: .leading){
                        TextField("Mass of item 1 (kg)", text: $m1b.blockingNumbersAndPunctuation())
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        

                            .keyboardType(.numbersAndPunctuation)

                    }
                    Spacer()
                    VStack(alignment: .leading){
                        Text("• 10^")
                            .fontWeight(.medium)
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        TextField("", text: $m1e.blockingNumbersAndPunctuation())
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        

                            .keyboardType(.numbersAndPunctuation)

                    }
                }
                HStack {
                    VStack(alignment: .leading){
                        TextField("Mass of item 2 (kg)", text: $m2b.blockingNumbersAndPunctuation())
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        

                            .keyboardType(.numbersAndPunctuation)

                    }
                    Spacer()
                    VStack(alignment: .leading){
                        Text("• 10^")
                            .fontWeight(.medium)
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        TextField("", text: $m2e.blockingNumbersAndPunctuation())
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        

                            .keyboardType(.numbersAndPunctuation)

                    }
                }
                HStack {
                    VStack(alignment: .leading){
                        TextField("Radius (m)", text: $rb.blockingNumbersAndPunctuation())
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        

                            .keyboardType(.numbersAndPunctuation)

                    }
                    Spacer()
                    VStack(alignment: .leading){
                        Text("• 10^")
                            .fontWeight(.medium)
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        TextField("", text: $re)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        

                            .keyboardType(.numbersAndPunctuation)

                    }
                }
            }
            
            //Converts the string values into numerical values
            let fB = Double(Fb) ?? 0
            let fE = Double(Fe) ?? 0
            let powfE = pow(10, fE)
            let gravitationalForce: Double =  fB * powfE
            
            let M1b = Double(m1b) ?? 0
            let M1e = Double(m1e) ?? 0
            let powM1e = pow(10, M1e)
            let mass1: Double = M1b * powM1e
            
            let M2b = Double(m2b) ?? 0
            let M2e = Double(m2e) ?? 0
            let powM2e = pow(10, M2e)
            let mass2: Double = M2b * powM2e
            
            let Rb = Double(rb) ?? 0
            let Re = Double(re) ?? 0
            let powRe = pow(10, Re)
            let radius: Double = Rb * powRe
            
            let G = 6.67e-11
            
            //Conditional statements based on which text boxes are full and empty
            VStack {
                if(Fb.isEmpty && Fe.isEmpty && !m1b.isEmpty && !m1e.isEmpty && !m2b.isEmpty && !m2e.isEmpty && !rb.isEmpty && !re.isEmpty) {
                    let gravitationalForce: Double = G * ((mass1 * mass2) / pow(radius, 2))
                    ScrollView(.horizontal) {
                        HStack (spacing: 0){
                            Text("Gravitational Force: ")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = String(gravitationalForce)
                                    }) {
                                        HStack {
                                            Image(systemName: "doc.on.doc")
                                            Text("Copy")
                                        }                                    }
                                }
                                .frame(alignment: .leading)
                            Text(formatNumber(number: gravitationalForce))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
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
                
                else if(!Fb.isEmpty && !Fe.isEmpty && m1b.isEmpty && m1e.isEmpty && !m2b.isEmpty && !m2e.isEmpty && !rb.isEmpty && !re.isEmpty) {
                    let mass1: Double = (gravitationalForce * pow(radius, 2)) / (G * mass2)
                    ScrollView(.horizontal) {
                        HStack (spacing: 0){
                            Text("Mass 1: ")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                            Text(formatNumber(number: mass1))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = String(mass1)
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
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                
                else if(!Fb.isEmpty && !Fe.isEmpty && !m1b.isEmpty && !m1e.isEmpty && m2b.isEmpty && m2e.isEmpty && !rb.isEmpty && !re.isEmpty) {
                    let mass2: Double = (gravitationalForce * pow(radius, 2)) / (G * mass1)
                    ScrollView(.horizontal) {
                        HStack (spacing: 0){
                            Text("Mass 2: ")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                            Text(formatNumber(number: mass2))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                                .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = String(mass2)
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
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                
                else if(!Fb.isEmpty && !Fe.isEmpty && !m1b.isEmpty && !m1e.isEmpty && !m2b.isEmpty && !m2e.isEmpty && rb.isEmpty && re.isEmpty) {
                    let radius: Double = sqrt((mass2 * mass1 * G)/gravitationalForce)
                    ScrollView(.horizontal) {
                        HStack (spacing: 0){
                            Text("Radius: ")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 0))
                                .frame(alignment: .leading)
                            Text(formatNumber(number: radius))
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
                            Text("Universal Gravitation is the physical law that states that every object in the universe attracts every other object with a force proportional to their masses and inversely proportional to the square of the distance between them. This means that you are always being pulled by everything around you, from the Sun to the dust mite on your pillow. Universal Gravitation explains many phenomena such as the orbits of planets, the tides, and the motion of artificial satellites.")
                                .multilineTextAlignment(.center)
                                .font(.headline)
                            Spacer(minLength: 20)
                            // Formula
                            LaTeX("$$g = G*\\frac{M_1 • M_2}{r^2}$$")
                                .font(.title)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("g = Gravitational Force, G = Gravitational Constant, M1 and M2 = masses, r = radius")
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(7.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                            SubSuperScriptText(inputString: "Gravitational Constant = 6.67 • 10^{-11}", bodyFont: .callout, subScriptFont: .caption, baseLine: 6.0)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.center)
                                .padding(7.5)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }.padding(20)
                        Spacer(minLength: 40)
                        // Example
                        VStack(spacing: 10) {
                            Text("Example")
                                .font(.title)
                                .fontWeight(.bold)
                            Divider()
                            ZStack {
                                // Draw the celestial bodies
                                Circle()
                                    .fill(Color.yellow)
                                    .frame(width: 20, height: 20)
                                    .padding(.top, 40)
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 10, height: 10)
                                    .padding(.top, 60)
                                // Draw the gravitational force
                                Rectangle()
                                    .fill(Color.orange)
                                    .frame(width: 3, height: 80)
                                    .rotationEffect(.degrees(-45))
                            }
                            .padding(20)
                            VStack(alignment: .leading, spacing: 5) {
                                SubSuperScriptText(inputString: "Gravitational Constant = 1.989 • 10^{30} kg", bodyFont: .callout, subScriptFont: .caption, baseLine: 6.0)
                                SubSuperScriptText(inputString: "Mass of Earth: 5.972 x 10^{24} kg", bodyFont: .callout, subScriptFont: .caption, baseLine: 6.0)
                                SubSuperScriptText(inputString: "Distance between Sun and Earth: 1.47 x 10^{11} m", bodyFont: .callout, subScriptFont: .caption, baseLine: 6.0)
                                SubSuperScriptText(inputString: "Gravitational Force: 3.52 x 10^{22} N", bodyFont: .callout, subScriptFont: .caption, baseLine: 6.0)
                            }.navigationTitle("Universal Gravitation")
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
        }.navigationTitle("Universal Gravitation")
    }
    
    struct UniversalGravitation_Previews: PreviewProvider {
        static var previews: some View {
            UniversalGravitation()
        }
    }
}
