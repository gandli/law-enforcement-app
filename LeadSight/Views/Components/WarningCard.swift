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
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct WarningCard_Previews: PreviewProvider {
    static var previews: some View {
        WarningCard(warning: Warning.mockWarnings[0])
            .previewLayout(.sizeThatFits)
    }
}
