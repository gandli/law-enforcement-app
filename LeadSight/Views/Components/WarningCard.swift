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
                    .symbolRenderingMode(.multicolor)
                    .symbolEffect(.bounce, value: warning.severity == .critical)
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
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(warning.type): \(warning.title)")
        .accessibilityValue(warning.description)
    }
}

#Preview {
    let dataStore = DataStore()
    return WarningCard(warning: dataStore.warnings[0])
        .padding()
}
