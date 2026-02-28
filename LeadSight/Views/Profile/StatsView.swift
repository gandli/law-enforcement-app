import SwiftUI

struct StatsView: View {
    @Environment(DataStore.self) private var dataStore
    
    private var pendingCount: Int { dataStore.leads.filter { $0.status == .pending }.count }
    private var investigatingCount: Int { dataStore.leads.filter { $0.status == .investigating }.count }
    private var resolvedCount: Int { dataStore.leads.filter { $0.status == .resolved }.count }
    
    var body: some View {
        List {
            Section("线索概览") {
                StatRow(label: "总线索数", value: "\(dataStore.leads.count)", icon: "doc.text.fill", color: .blue)
                StatRow(label: "待处理", value: "\(pendingCount)", icon: "clock.fill", color: .orange)
                StatRow(label: "调查中", value: "\(investigatingCount)", icon: "magnifyingglass", color: .blue)
                StatRow(label: "已解决", value: "\(resolvedCount)", icon: "checkmark.circle.fill", color: .green)
            }
            
            Section("预警概览") {
                StatRow(label: "活跃预警", value: "\(dataStore.warnings.count)", icon: "exclamationmark.triangle.fill", color: .red)
                StatRow(label: "紧急预警", value: "\(dataStore.warnings.filter { $0.severity == .critical }.count)", icon: "flame.fill", color: .red)
            }
            
            Section("执法环节分布") {
                EnforcementStageRow(icon: "building.2.fill", label: "制假窝点", count: countByImage("factory"))
                EnforcementStageRow(icon: "ferry.fill", label: "海运走私", count: countByImage("maritime"))
                EnforcementStageRow(icon: "truck.box.fill", label: "专车运假", count: countByImage("truck"))
                EnforcementStageRow(icon: "shippingbox.fill", label: "物流寄递", count: countByImage("package"))
                EnforcementStageRow(icon: "person.badge.shield.checkmark.fill", label: "上门兜售", count: countByImage("seller"))
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("统计")
    }
    
    private func countByImage(_ name: String) -> Int {
        dataStore.leads.filter { $0.imageName == name }.count
    }
}

private struct StatRow: View {
    let label: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(color)
                .frame(width: 28)
            Text(label)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
                .foregroundStyle(color)
        }
    }
}

private struct EnforcementStageRow: View {
    let icon: String
    let label: String
    let count: Int
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(.blue)
                .frame(width: 28)
            Text(label)
            Spacer()
            Text("\(count)")
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        StatsView()
            .environment(DataStore())
    }
}
