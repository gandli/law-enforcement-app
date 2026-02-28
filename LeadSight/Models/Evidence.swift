import Foundation

// MARK: - Evidence

struct Evidence: Identifiable, Codable, Hashable {
    let id: UUID
    let type: EvidenceType
    let timestamp: Date
    let rawContent: String          // file path or raw text
    let structuredData: StructuredData?
    
    enum EvidenceType: String, Codable, CaseIterable {
        case photo = "图片"
        case video = "视频"
        case audio = "音频"
        case text = "文本"
        
        var systemImage: String {
            switch self {
            case .photo: return "photo.fill"
            case .video: return "video.fill"
            case .audio: return "waveform"
            case .text: return "doc.text.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .photo: return .blue
            case .video: return .purple
            case .audio: return .orange
            case .text: return .green
            }
        }
    }
}

// MARK: - Structured Data (AI-extracted)

struct StructuredData: Codable, Hashable {
    let ocrText: String?
    let transcription: String?
    let licensePlates: [String]
    let faceMatches: [FaceMatch]
    let objectTags: [String]
    let confidence: Double          // 0.0 - 1.0
}

// MARK: - Face Match Result

struct FaceMatch: Codable, Hashable, Identifiable {
    let id: UUID
    let name: String
    let matchScore: Double          // 0.0 - 1.0
    let database: String            // e.g. "重点人员库", "在逃人员库"
}

import SwiftUI
