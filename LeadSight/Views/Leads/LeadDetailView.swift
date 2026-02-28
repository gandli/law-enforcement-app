import SwiftUI

struct LeadDetailView: View {
    let lead: Lead
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Media Section
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 200)
                    
                    VStack {
                        Image(systemName: "photo.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("现场图片_4829.jpg")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                
                // Info Section
                VStack(alignment: .leading, spacing: 8) {
                    Text(lead.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text(lead.reporter)
                        Text("•")
                        Text(lead.timestamp, style: .date)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                // AI Summary
                if let analysis = lead.aiAnalysis {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundColor(.blue)
                            Text("AI 分析摘要")
                                .font(.headline)
                        }
                        
                        Text(analysis)
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding()
                            .background(Color.blue.opacity(0.05))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                
                // Content section
                VStack(alignment: .leading, spacing: 10) {
                    Text("采集详情")
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
                            .foregroundColor(.red)
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

struct LeadDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LeadDetailView(lead: Lead.mockLeads[1])
        }
    }
}
