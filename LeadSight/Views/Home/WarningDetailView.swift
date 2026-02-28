import SwiftUI

struct WarningDetailView: View {
    let warning: Warning
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Severity Header
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.largeTitle)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(warning.type)
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .foregroundStyle(.white)
                            .background(warning.severity.color, in: Capsule())
                        
                        Text(warning.title)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal)
                
                // Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("预警详情")
                        .font(.headline)
                    Text(warning.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                
                // Severity Level Indicator
                VStack(alignment: .leading, spacing: 12) {
                    Text("风险等级")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        ForEach(["常规", "注意", "高度疑似", "紧急"], id: \.self) { level in
                            let isActive = warning.severity.rawValue == level
                            Text(level)
                                .font(.caption)
                                .fontWeight(isActive ? .bold : .regular)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .foregroundStyle(isActive ? .white : .secondary)
                                .background(
                                    isActive ? AnyShapeStyle(warning.severity.color) : AnyShapeStyle(.fill.quaternary),
                                    in: Capsule()
                                )
                        }
                    }
                }
                .padding(.horizontal)
                
                // Recommended Actions
                VStack(alignment: .leading, spacing: 12) {
                    Text("建议处置")
                        .font(.headline)
                    
                    RecommendedAction(icon: "magnifyingglass", title: "立即核查", description: "安排稽查人员前往现场核实情况。")
                    RecommendedAction(icon: "doc.text.fill", title: "形成报告", description: "汇总数据并上报至上级部门。")
                    RecommendedAction(icon: "bell.badge.fill", title: "持续监控", description: "将该预警加入重点关注列表。")
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// A single recommended action row
private struct RecommendedAction: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.blue)
                .frame(width: 40, height: 40)
                .background(.blue.opacity(0.1), in: Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

#Preview {
    NavigationStack {
        WarningDetailView(warning: DataStore().warnings[0])
    }
}
