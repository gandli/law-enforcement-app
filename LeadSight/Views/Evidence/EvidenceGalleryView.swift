import SwiftUI

struct EvidenceGalleryView: View {
    let evidences: [Evidence]
    @State private var selectedFilter: Evidence.EvidenceType? = nil
    
    private var filtered: [Evidence] {
        guard let filter = selectedFilter else { return evidences }
        return evidences.filter { $0.type == filter }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Filter chips
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    FilterChip(label: "全部", isSelected: selectedFilter == nil) {
                        selectedFilter = nil
                    }
                    ForEach(Evidence.EvidenceType.allCases, id: \.self) { type in
                        let count = evidences.filter { $0.type == type }.count
                        if count > 0 {
                            FilterChip(
                                label: "\(type.rawValue) (\(count))",
                                icon: type.systemImage,
                                isSelected: selectedFilter == type
                            ) {
                                selectedFilter = type
                            }
                        }
                    }
                }
            }
            
            // Grid
            if filtered.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "tray")
                        .font(.largeTitle)
                        .foregroundStyle(.tertiary)
                    Text("暂无证据")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 100, maximum: 120))
                ], spacing: 12) {
                    ForEach(filtered) { evidence in
                        NavigationLink(value: evidence) {
                            EvidenceThumbnail(evidence: evidence)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

// MARK: - Thumbnail

private struct EvidenceThumbnail: View {
    let evidence: Evidence
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(evidence.type.color.opacity(0.1))
                    .frame(height: 90)
                
                Image(systemName: evidence.type.systemImage)
                    .font(.title2)
                    .foregroundStyle(evidence.type.color)
            }
            
            Text(evidence.timestamp, style: .time)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .accessibilityLabel("\(evidence.type.rawValue)证据")
    }
}

// MARK: - Filter Chip

private struct FilterChip: View {
    let label: String
    var icon: String? = nil
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                if let icon {
                    Image(systemName: icon)
                        .font(.caption2)
                }
                Text(label)
                    .font(.caption)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .foregroundStyle(isSelected ? .white : .primary)
            .background(
                isSelected ? AnyShapeStyle(.blue) : AnyShapeStyle(.fill.quaternary),
                in: Capsule()
            )
        }
    }
}

#Preview {
    NavigationStack {
        ScrollView {
            EvidenceGalleryView(evidences: DataStore().leads[0].evidences)
                .padding()
        }
    }
}
