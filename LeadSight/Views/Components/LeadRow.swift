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
                    .foregroundColor(.secondary)
                
                HStack {
                    Text(lead.timestamp, style: .time)
                    Text("•")
                    Text(lead.location)
                }
                .font(.caption2)
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    let dataStore = DataStore()
    return LeadRow(lead: dataStore.leads[0])
        .padding(.horizontal)
}
