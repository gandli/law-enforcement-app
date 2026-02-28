import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("个人信息")) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("执勤人员")
                                .font(.headline)
                            Text("编号: SP-9527")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section(header: Text("统计")) {
                    HStack {
                        Label("今日采集", systemImage: "pencil.and.outline")
                        Spacer()
                        Text("12")
                    }
                    HStack {
                        Label("待处理线索", systemImage: "clock")
                        Spacer()
                        Text("5")
                    }
                }
                
                Section(header: Text("系统")) {
                    NavigationLink(destination: Text("设置")) {
                        Label("设置", systemImage: "gearshape")
                    }
                    NavigationLink(destination: Text("帮助与反馈")) {
                        Label("帮助与反馈", systemImage: "questionmark.circle")
                    }
                }
                
                Section {
                    Button(action: {}) {
                        Text("退出登录")
                            .foregroundColor(.red)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("我的")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
