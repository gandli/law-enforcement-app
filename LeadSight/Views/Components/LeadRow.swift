import SwiftUI

struct LeadRow: View {
    let lead: Lead
    
    var body: some View {
        HStack(spacing: 16) {
            // Image Placeholder/Thumbnail
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 70, height: 70)
                
                Image(systemName: lead.imageName == "fire_lane" ? "flame.fill" : "person.2.fill")
                    .font(.title2)
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

struct LeadRow_Previews: PreviewProvider {
    static var previews: some View {
        LeadRow(lead: Lead.mockLeads[0])
            .previewLayout(.sizeThatFits)
    }
}
