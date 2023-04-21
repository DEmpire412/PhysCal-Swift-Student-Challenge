//All rights for third party packages such as LaTeXSwiftUI go to their applicable authors on GitHub. Additional copied code is cited.
import SwiftUI

let coloredNavAppearance = UINavigationBarAppearance()

struct ContentView: View {
    
    @State private var formulas: [ (name: String, destination: AnyView) ] = [
        (name: "Force", destination: AnyView(Force())),
        (name: "Weight", destination: AnyView(Weight())),
        (name: "Projectile Motion", destination: AnyView(ProjectileMotion())),
        (name: "Orbital Velocity", destination: AnyView(OrbitalVelocity())),
        (name: "Universal Gravitation", destination: AnyView(UniversalGravitation()))
    ]
    
    @State private var searchBar = ""
    @State var showSidebar: Bool = false
    @SceneStorage("hasShownOnboarding") var hasShownOnboarding = false
    @State private var showOnboarding: Bool = false // New state variable
    
    //Cited from Stack Overflow
    init() {
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor(named: "BackgroundColor")
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    //End citation
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "BackgroundColor")!).edgesIgnoringSafeArea(.all)
            NavigationView {
                ZStack {
                    Color(UIColor(named: "BackgroundColor")!).edgesIgnoringSafeArea(.all)
                    List {
                        Section {
                            ForEach(formulaSearchList, id: \.name) { formula in
                                NavigationLink (formula.name, destination: formula.destination)
                            }
                        } header: {
                            Text("Formulas")
                        }
                    }.navigationTitle("PhysCal")
                    .background(Color(UIColor(named: "BackgroundColor")!))
                    .searchable(text: $searchBar, placement: .navigationBarDrawer(displayMode: .always))
                    .listStyle(SidebarListStyle())
                    .frame(minWidth: 260)
                    .preferredColorScheme(.dark)
                }
            }
        }
        .sheet(isPresented: $showOnboarding) {
            OnboardingView()
        }
        .onAppear {
            if !hasShownOnboarding {
                showOnboarding = true
            }
        }
    }
    
    var formulaSearchList: [ (name: String, destination: AnyView) ] {
        if searchBar.isEmpty {
            return formulas
        } else {
            return formulas.filter { $0.name.localizedCaseInsensitiveContains(searchBar) }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
