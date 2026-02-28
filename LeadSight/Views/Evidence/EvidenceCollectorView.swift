import SwiftUI

struct EvidenceCollectorView: View {
    @Environment(DataStore.self) private var dataStore
    @Environment(\.dismiss) private var dismiss
    let leadID: UUID
    
    @State private var selectedMode: Evidence.EvidenceType = .photo
    @State private var textNote = ""
    @State private var isProcessing = false
    @State private var processingComplete = false
    @State private var lastResult: StructuredData?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Mode Selector
                Picker("采集方式", selection: $selectedMode) {
                    ForEach(Evidence.EvidenceType.allCases, id: \.self) { type in
                        Label(type.rawValue, systemImage: type.systemImage)
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                Divider()
                
                // Capture Area
                ScrollView {
                    VStack(spacing: 20) {
                        switch selectedMode {
                        case .photo:
                            CaptureSimulator(icon: "camera.fill", label: "拍摄照片", color: .blue)
                        case .video:
                            CaptureSimulator(icon: "video.fill", label: "录制视频", color: .purple)
                        case .audio:
                            CaptureSimulator(icon: "mic.fill", label: "录制音频", color: .orange)
                        case .text:
                            TextEditor(text: $textNote)
                                .frame(minHeight: 150)
                                .padding(12)
                                .background(.fill.quaternary, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .padding(.horizontal)
                        }
                        
                        // Processing indicator
                        if isProcessing {
                            VStack(spacing: 12) {
                                ProgressView()
                                    .controlSize(.large)
                                Text("AI 正在分析...")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.top, 20)
                        }
                        
                        // Result preview
                        if let result = lastResult, processingComplete {
                            AIResultPreview(data: result)
                                .padding(.horizontal)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                    .padding(.vertical)
                }
                
                // Capture Button
                Button {
                    captureEvidence()
                } label: {
                    Label(selectedMode == .text ? "保存笔记" : "采集并分析", systemImage: "sparkles")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
                .buttonStyle(.borderedProminent)
                .disabled(selectedMode == .text && textNote.isEmpty)
                .padding()
            }
            .navigationTitle("证据采集")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("关闭") { dismiss() }
                }
            }
        }
    }
    
    private func captureEvidence() {
        isProcessing = true
        processingComplete = false
        
        // Simulate AI processing delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let structured: StructuredData?
            
            switch selectedMode {
            case .photo:
                structured = AIService.analyzeImage(named: "capture")
            case .video:
                structured = AIService.analyzeImage(named: "video_frame")
            case .audio:
                structured = AIService.analyzeAudio()
            case .text:
                structured = StructuredData(
                    ocrText: nil,
                    transcription: nil,
                    licensePlates: [],
                    faceMatches: [],
                    objectTags: textNote.components(separatedBy: .whitespacesAndNewlines).filter { $0.count > 1 },
                    confidence: 1.0
                )
            }
            
            let evidence = Evidence(
                id: UUID(),
                type: selectedMode,
                timestamp: Date(),
                rawContent: selectedMode == .text ? textNote : "simulated_\(selectedMode.rawValue)_\(UUID().uuidString.prefix(8))",
                structuredData: structured
            )
            
            dataStore.addEvidence(evidence, to: leadID)
            lastResult = structured
            isProcessing = false
            processingComplete = true
            
            if selectedMode == .text { textNote = "" }
        }
    }
}

// MARK: - Sub-components

private struct CaptureSimulator: View {
    let icon: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.fill.quaternary)
                    .frame(height: 220)
                
                VStack(spacing: 12) {
                    Image(systemName: icon)
                        .font(.system(size: 50))
                        .foregroundStyle(color)
                    Text(label)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.horizontal)
    }
}

private struct AIResultPreview: View {
    let data: StructuredData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "sparkles")
                    .foregroundStyle(.blue)
                Text("AI 识别结果")
                    .font(.headline)
                Spacer()
                Text("\(Int(data.confidence * 100))%")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.blue, in: Capsule())
            }
            
            if let ocr = data.ocrText, !ocr.isEmpty {
                TagSection(title: "OCR 文字", content: ocr)
            }
            
            if let trans = data.transcription, !trans.isEmpty {
                TagSection(title: "语音转文字", content: trans)
            }
            
            if !data.licensePlates.isEmpty {
                HStack {
                    Text("车牌:").font(.caption).foregroundStyle(.secondary)
                    ForEach(data.licensePlates, id: \.self) { plate in
                        Text(plate)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(.orange.opacity(0.15), in: Capsule())
                    }
                }
            }
            
            if !data.faceMatches.isEmpty {
                ForEach(data.faceMatches) { face in
                    HStack {
                        Image(systemName: "person.viewfinder")
                            .foregroundStyle(.red)
                        Text(face.name)
                            .fontWeight(.semibold)
                        Text("(\(face.database))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("\(Int(face.matchScore * 100))%")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                }
            }
            
            if !data.objectTags.isEmpty {
                FlowLayout(tags: data.objectTags)
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

private struct TagSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(content)
                .font(.callout)
        }
    }
}

private struct FlowLayout: View {
    let tags: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("物体标签:").font(.caption).foregroundStyle(.secondary)
            HStack(spacing: 6) {
                ForEach(tags.prefix(5), id: \.self) { tag in
                    Text(tag)
                        .font(.caption2)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.blue.opacity(0.1), in: Capsule())
                }
            }
        }
    }
}

#Preview {
    EvidenceCollectorView(leadID: UUID())
        .environment(DataStore())
}
