import SwiftUI

struct HomeView: View {
    @Environment(DataStore.self) private var dataStore
    let dutyID = "SP-9527"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 28) {
                    // Smart Judgment Section
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "智能研判", actionTitle: "查看全部") {}
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(dataStore.warnings) { warning in
                                    WarningCard(warning: warning)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Emergency SOS Section
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "紧急呼救")
                        
                        EmergencyButton(action: {
                            print("SOS triggered")
                        })
                    }
                    
                    // Recent Leads Section
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "最新稽查", actionTitle: "查看全部") {}
                        
                        LazyVStack(spacing: 0) {
                            ForEach(dataStore.leads) { lead in
                                LeadRow(lead: lead)
                                    .padding(.horizontal)
                                if lead.id != dataStore.leads.last?.id {
                                    Divider().padding(.leading, 86)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("首页")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "person.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .font(.title3)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Text("编号: \(dutyID)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(DataStore())
}
