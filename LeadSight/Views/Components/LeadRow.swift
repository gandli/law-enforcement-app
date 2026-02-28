import SwiftUI

struct LeadRow: View {
    let lead: Lead
    
    var body: some View {
        HStack(spacing: 16) {
            // Image Placeholder/Thumbnail
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.blue.opacity(0.05)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 64, height: 64)
                
                Image(systemName: lead.imageName == "fire_lane" ? "flame.fill" : "person.2.fill")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(lead.title)
                    .font(.headline)
                
                Text(lead.reporter)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                HStack {
                    Text(lead.timestamp, style: .time)
                    Text("•")
                    Text(lead.location)
                }
                .font(.caption2)
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("线索: \(lead.title)")
        .accessibilityValue("报告人: \(lead.reporter), 地点: \(lead.location)")
    }
}

#Preview {
    let dataStore = DataStore()
    return LeadRow(lead: dataStore.leads[0])
        .padding(.horizontal)
}
