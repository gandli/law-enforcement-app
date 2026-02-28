import SwiftUI

struct EvidenceDetailView: View {
    let evidence: Evidence
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Media Preview
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(evidence.type.color.opacity(0.08))
                        .frame(height: 250)
                    
                    VStack(spacing: 12) {
                        Image(systemName: evidence.type.systemImage)
                            .font(.system(size: 60))
                            .foregroundStyle(evidence.type.color)
                        
                        Text(evidence.type.rawValue)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .foregroundStyle(.white)
                            .background(evidence.type.color, in: Capsule())
                    }
                }
                .padding(.horizontal)
                
                // Metadata
                HStack {
                    Text(evidence.timestamp, format: .dateTime.month().day().hour().minute())
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    if let data = evidence.structuredData {
                        ConfidenceBadge(confidence: data.confidence)
                    }
                }
                .padding(.horizontal)
                
                // Structured Data
                if let data = evidence.structuredData {
                    VStack(alignment: .leading, spacing: 16) {
                        // OCR
                        if let ocr = data.ocrText, !ocr.isEmpty {
                            DataCard(title: "OCR 文字识别", icon: "doc.text.viewfinder") {
                                Text(ocr)
                                    .font(.callout)
                                    .textSelection(.enabled)
                            }
                        }
                        
                        // Transcription
                        if let trans = data.transcription, !trans.isEmpty {
                            DataCard(title: "语音转文字", icon: "waveform") {
                                Text(trans)
                                    .font(.callout)
                                    .textSelection(.enabled)
                            }
                        }
                        
                        // License Plates
                        if !data.licensePlates.isEmpty {
                            DataCard(title: "车牌识别", icon: "car.fill") {
                                ForEach(data.licensePlates, id: \.self) { plate in
                                    HStack {
                                        Image(systemName: "number")
                                            .foregroundStyle(.orange)
                                        Text(plate)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .fontDesign(.monospaced)
                                    }
                                }
                            }
                        }
                        
                        // Face Matches
                        if !data.faceMatches.isEmpty {
                            DataCard(title: "人脸识别", icon: "person.viewfinder") {
                                ForEach(data.faceMatches) { face in
                                    HStack {
                                        Image(systemName: "person.crop.circle.fill")
                                            .font(.title2)
                                            .foregroundStyle(.red)
                                        VStack(alignment: .leading) {
                                            Text(face.name)
                                                .fontWeight(.semibold)
                                            Text(face.database)
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                        Spacer()
                                        Text("匹配 \(Int(face.matchScore * 100))%")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.red)
                                    }
                                }
                            }
                        }
                        
                        // Object Tags
                        if !data.objectTags.isEmpty {
                            DataCard(title: "物体检测", icon: "viewfinder") {
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 8) {
                                    ForEach(data.objectTags, id: \.self) { tag in
                                        Text(tag)
                                            .font(.caption)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 6)
                                            .background(.blue.opacity(0.1), in: Capsule())
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("证据详情")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Components

private struct DataCard<Content: View>: View {
    let title: String
    let icon: String
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(.blue)
                Text(title)
                    .font(.headline)
            }
            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

private struct ConfidenceBadge: View {
    let confidence: Double
    
    var color: Color {
        if confidence > 0.9 { return .green }
        if confidence > 0.7 { return .orange }
        return .red
    }
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "brain.head.profile.fill")
                .font(.caption2)
            Text("置信度 \(Int(confidence * 100))%")
                .font(.caption)
                .fontWeight(.semibold)
        }
        .foregroundStyle(color)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(color.opacity(0.12), in: Capsule())
    }
}

#Preview {
    NavigationStack {
        EvidenceDetailView(evidence: DataStore().leads[0].evidences[0])
    }
}
