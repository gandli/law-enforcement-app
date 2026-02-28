import SwiftUI

struct LeadListView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Lead.mockLeads) { lead in
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

struct LeadListView_Previews: PreviewProvider {
    static var previews: some View {
        LeadListView()
    }
}
