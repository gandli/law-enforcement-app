import SwiftUI

struct MainTabView: View {
    @Environment(DataStore.self) private var dataStore
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("首页", systemImage: "house.fill")
                }
            
            LeadListView()
                .tabItem {
                    Label("线索", systemImage: "list.bullet.rectangle.portrait.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("我的", systemImage: "person.fill")
                }
        }
        .accentColor(.blue)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
