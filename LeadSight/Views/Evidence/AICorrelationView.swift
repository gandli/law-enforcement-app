import SwiftUI

struct AICorrelationView: View {
    @Environment(DataStore.self) private var dataStore
    let lead: Lead
    
    private var correlations: [AIService.Correlation] {
        AIService.findCorrelations(for: lead, in: dataStore.leads)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "brain.head.profile.fill")
                    .foregroundStyle(.purple)
                Text("AI 智能关联")
                    .font(.headline)
            }
            
            if correlations.isEmpty {
                HStack {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "link")
                            .font(.title)
                            .foregroundStyle(.tertiary)
                        Text("暂未发现关联线索")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .padding(.vertical, 20)
            } else {
                ForEach(correlations) { correlation in
                    CorrelationCard(correlation: correlation)
                }
            }
        }
    }
}

private struct CorrelationCard: View {
    let correlation: AIService.Correlation
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: correlation.type.systemImage)
                .font(.title3)
                .foregroundStyle(.purple)
                .frame(width: 44, height: 44)
                .background(.purple.opacity(0.1), in: Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(correlation.type.rawValue)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(correlation.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Text("\(Int(correlation.confidence * 100))%")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.purple)
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

#Preview {
    ScrollView {
        AICorrelationView(lead: DataStore().leads[0])
            .padding()
            .environment(DataStore())
    }
}
