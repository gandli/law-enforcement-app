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
                    .background(warning.severity.color.opacity(0.2), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                    .foregroundStyle(warning.severity.color)
                
                Spacer()
                
                Image(systemName: "exclamationmark.triangle.fill")
                    .symbolRenderingMode(.multicolor)
                    .symbolEffect(.bounce, value: warning.severity == .critical)
            }
            
            Text(warning.title)
                .font(.headline)
                .foregroundStyle(.primary)
            
            Text(warning.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
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
    WarningCard(warning: DataStore().warnings[0])
        .padding()
}
