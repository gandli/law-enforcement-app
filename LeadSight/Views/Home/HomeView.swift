import SwiftUI

struct HomeView: View {
    @Environment(DataStore.self) private var dataStore
    let userName = "执勤人员"
    let dutyID = "SP-9527"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    // Smart Judgment Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("智能研判")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            Button("查看全部") { }
                                .font(.subheadline)
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(dataStore.warnings) { warning in
                                    WarningCard(warning: warning)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Emergency SOS Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("紧急呼救")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        EmergencyButton(action: {
                            print("SOS triggered")
                        })
                    }
                    
                    // Recent Leads Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("最近采集")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            Button("查看全部") { }
                                .font(.subheadline)
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 0) {
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
