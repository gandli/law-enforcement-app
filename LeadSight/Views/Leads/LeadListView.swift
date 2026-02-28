import SwiftUI

struct LeadListView: View {
    @Environment(DataStore.self) private var dataStore
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dataStore.leads) { lead in
                    NavigationLink(destination: LeadDetailView(lead: lead)) {
                        LeadRow(lead: lead)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("线索")
            .searchable(text: $searchText, prompt: "搜索线索、地点或人员")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
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
