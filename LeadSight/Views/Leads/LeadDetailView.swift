import SwiftUI

struct LeadDetailView: View {
    let lead: Lead
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Media Section
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(.fill.quaternary)
                        .frame(height: 200)
                    
                    VStack(spacing: 8) {
                        Image(systemName: "photo.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(.secondary)
                        Text("现场图片_4829.jpg")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                }
                .padding(.horizontal)
                
                // Status Badge + Info Section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(lead.status.rawValue)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .foregroundStyle(.white)
                            .background(lead.status.color, in: Capsule())
                        Spacer()
                    }
                    
                    Text(lead.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text(lead.reporter)
                        Text("•")
                        Text(lead.timestamp, style: .date)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
                .padding(.horizontal)
                
                // AI Summary
                if let analysis = lead.aiAnalysis {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundStyle(.blue)
                            Text("AI 分析摘要")
                                .font(.headline)
                        }
                        
                        Text(analysis)
                            .font(.body)
                            .foregroundStyle(.primary)
                            .padding()
                            .background(.blue.opacity(0.08), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.horizontal)
                }
                
                // Content section
                VStack(alignment: .leading, spacing: 10) {
                    Text("稽查详情")
                        .font(.headline)
                    Text(lead.content)
                        .font(.body)
                }
                .padding(.horizontal)
                
                // Location
                VStack(alignment: .leading, spacing: 10) {
                    Text("位置信息")
                        .font(.headline)
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundStyle(.red)
                        Text(lead.location)
                            .font(.body)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LeadDetailView(lead: DataStore().leads[0])
    }
}
