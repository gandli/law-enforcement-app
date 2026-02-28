import SwiftUI

struct LeadListView: View {
    @Environment(DataStore.self) private var dataStore
    @State private var searchText = ""
    
    private var filteredLeads: [Lead] {
        if searchText.isEmpty {
            return dataStore.leads
        }
        return dataStore.leads.filter { lead in
            lead.title.localizedCaseInsensitiveContains(searchText) ||
            lead.location.localizedCaseInsensitiveContains(searchText) ||
            lead.reporter.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredLeads) { lead in
                    NavigationLink(value: lead) {
                        LeadRow(lead: lead)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("稽查线索")
            .navigationDestination(for: Lead.self) { lead in
                LeadDetailView(lead: lead)
            }
            .searchable(text: $searchText, prompt: "搜索零售户、证号或稽查地点")
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
