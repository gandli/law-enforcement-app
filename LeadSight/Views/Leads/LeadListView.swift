import SwiftUI

struct LeadListView: View {
    @Environment(DataStore.self) private var dataStore
    @State private var searchText = ""
    @State private var showingAddLead = false
    
    private var filteredLeads: [Lead] {
        if searchText.isEmpty {
            return dataStore.leads
        }
        return dataStore.leads.filter { lead in
            lead.title.localizedCaseInsensitiveContains(searchText) ||
            lead.location.localizedCaseInsensitiveContains(searchText) ||
            lead.reporter.localizedCaseInsensitiveContains(searchText) ||
            lead.searchableEvidenceText.localizedCaseInsensitiveContains(searchText)
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
                .onDelete { offsets in
                    dataStore.deleteLead(at: offsets)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("线索")
            .navigationDestination(for: Lead.self) { lead in
                LeadDetailView(lead: lead)
            }
            .searchable(text: $searchText, prompt: "搜索零售户、证号或稽查地点")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddLead = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // filter action
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .sheet(isPresented: $showingAddLead) {
                AddLeadView()
            }
        }
    }
}

#Preview {
    LeadListView()
        .environment(DataStore())
}
