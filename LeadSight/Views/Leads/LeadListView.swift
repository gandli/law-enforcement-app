import SwiftUI

struct LeadListView: View {
    @Environment(DataStore.self) private var dataStore
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dataStore.leads) { lead in
                    NavigationLink(destination: LeadDetailView(lead: lead)) {
                        LeadRow(lead: lead)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("线索")
            .searchable(text: $searchText, prompt: "搜索线索、地点或人员")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    LeadListView()
        .environment(DataStore())
}
