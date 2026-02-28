import SwiftUI

struct WarningCard: View {
    let warning: Warning
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(warning.type)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(warning.severity.color.opacity(0.2))
                    .foregroundColor(warning.severity.color)
                    .cornerRadius(4)
                
                Spacer()
                
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(warning.severity.color)
            }
            
            Text(warning.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(warning.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .padding()
        .frame(width: 260, height: 160)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
    }
}

#Preview {
    let dataStore = DataStore()
    return WarningCard(warning: dataStore.warnings[0])
        .padding()
}
