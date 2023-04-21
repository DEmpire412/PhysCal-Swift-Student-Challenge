//For demo purposes, this onboarding view shows whenever a user launches the app. In a production version, the code would be modified so it would only show when the user first launches the app
import SwiftUI

struct OnboardingView: View {
    @SceneStorage("hasShownOnboarding") var hasShownOnboarding = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack(alignment: .center, spacing: 20) {
                Text("Welcome to PhysCal!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Text("Forget about trying to find that magic formula in your notes! With PhysCal, just select what you're calculating, enter your input values, and you will be presented with your solution, automatically! To copy your result, simply long-press. To read more about your formula, just click the i-button in your toolbar!")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(20)
                
                Image("PhysCal-Symbol")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                
                Text("Let's get started!")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Button(action: {
                    hasShownOnboarding = true
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(Color("BackgroundColor"))
                        .padding(.horizontal, 50)
                        .padding(.vertical, 10)
                        .background(Color("AccentColor"))
                        .hoverEffect()
                        .cornerRadius(25)
                }
            }
            .padding()
        }
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
