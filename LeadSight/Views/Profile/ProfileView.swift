import SwiftUI

struct ProfileView: View {
    @Environment(DataStore.self) private var dataStore
    
    var body: some View {
        NavigationStack {
            List {
                Section("个人信息") {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.blue)
                        VStack(alignment: .leading) {
                            Text("执勤人员")
                                .font(.headline)
                            Text("编号: SP-9527")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section("统计") {
                    NavigationLink {
                        StatsView()
                    } label: {
                        HStack {
                            Label("今日线索", systemImage: "pencil.and.outline")
                            Spacer()
                            Text("\(dataStore.leads.count)")
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    HStack {
                        Label("待处理线索", systemImage: "clock")
                        Spacer()
                        Text("\(dataStore.leads.filter { $0.status == .pending }.count)")
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Label("活跃预警", systemImage: "exclamationmark.triangle")
                        Spacer()
                        Text("\(dataStore.warnings.count)")
                            .foregroundStyle(.secondary)
                    }
                }
                
                Section("系统") {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Label("设置", systemImage: "gearshape")
                    }
                    NavigationLink {
                        HelpView()
                    } label: {
                        Label("帮助与反馈", systemImage: "questionmark.circle")
                    }
                }
                
                Section {
                    Button("退出登录", role: .destructive) {
                        // logout action
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("我的")
        }
    }
}

/// Help & Feedback Page
private struct HelpView: View {
    var body: some View {
        List {
            Section("常见问题") {
                FAQRow(question: "如何新增线索？", answer: "在「稽查线索」标签页点击右上角 + 按钮即可新增线索。")
                FAQRow(question: "如何使用紧急呼救？", answer: "首页点击红色「紧急呼救」按钮，将自动上报当前位置。")
                FAQRow(question: "智能研判如何工作？", answer: "系统基于多源数据自动生成预警，包括用电、物流、轨迹等数据分析。")
            }
            
            Section("联系我们") {
                HStack {
                    Label("技术支持", systemImage: "phone")
                    Spacer()
                    Text("400-XXX-XXXX")
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Label("邮箱", systemImage: "envelope")
                    Spacer()
                    Text("support@leadsight.cn")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("帮助与反馈")
    }
}

private struct FAQRow: View {
    let question: String
    let answer: String
    @State private var isExpanded = false
    
    var body: some View {
        DisclosureGroup(question, isExpanded: $isExpanded) {
            Text(answer)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.top, 4)
        }
    }
}

#Preview {
    ProfileView()
        .environment(DataStore())
}
