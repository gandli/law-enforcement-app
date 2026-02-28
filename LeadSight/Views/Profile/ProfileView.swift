import SwiftUI

struct ProfileView: View {
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
                    HStack {
                        Label("今日稽查", systemImage: "pencil.and.outline")
                        Spacer()
                        Text("12")
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Label("待处理线索", systemImage: "clock")
                        Spacer()
                        Text("5")
                            .foregroundStyle(.secondary)
                    }
                }
                
                Section("系统") {
                    NavigationLink(destination: Text("设置")) {
                        Label("设置", systemImage: "gearshape")
                    }
                    NavigationLink(destination: Text("帮助与反馈")) {
                        Label("帮助与反馈", systemImage: "questionmark.circle")
                    }
                }
                
                Section {
                    Button(role: .destructive, action: {}) {
                        Text("退出登录")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("我的")
        }
    }
}

#Preview {
    ProfileView()
}
