import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("首页", systemImage: "house.fill")
                }
            
            LeadListView()
                .tabItem {
                    Label("稽查线索", systemImage: "list.bullet.rectangle.portrait.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("我的", systemImage: "person.fill")
                }
        }
        .tint(.blue)
    }
}

#Preview {
    MainTabView()
        .environment(DataStore())
}
