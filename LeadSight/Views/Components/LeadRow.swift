import SwiftUI

struct LeadRow: View {
    let lead: Lead
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon thumbnail using model's computed property
            Image(systemName: lead.systemImageName)
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(.blue)
                .frame(width: 52, height: 52)
                .background(.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(lead.title)
                    .font(.headline)
                
                Text(lead.reporter)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 4) {
                    Text(lead.timestamp, style: .relative)
                    Text("·")
                    Text(lead.location)
                        .lineLimit(1)
                }
                .font(.caption2)
                .foregroundStyle(.tertiary)
            }
            
            Spacer()
            
            // Status indicator
            Text(lead.status.rawValue)
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundStyle(lead.status.color)
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("线索: \(lead.title)")
        .accessibilityValue("报告人: \(lead.reporter), 地点: \(lead.location)")
    }
}

#Preview {
    LeadRow(lead: DataStore().leads[0])
        .padding(.horizontal)
}
