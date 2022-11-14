//
//  XapSep.swift
//  Ledger
//
//  Created by Thong Vu on 10/22/22.
//

import SwiftUI

struct XapSep: View {
    @EnvironmentObject var worker: KhachData
    @State private var khong: Bool = false
    var xap: [Khach] {
        worker.khach.khach.sorted(by: {$0.name < $1.name || !khong})
    }
    @State private var text = ""
    @State private var listDaTim: [Khach] = []
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("today")){
                    Text("Last week earn: $\(tongNgay())")
                        }
                
                Section(header: Text("last seven day")){
                    HStack {
                        Text("Last week earn: $\(worker.khach.tongTuan())")
                        Spacer()
                        Button(action: {
                            let newWeek = WeekEarn(tuan: "\(Date.now.formatted(date: .numeric, time: .omitted))", earn: worker.khach.tongTuan())
                            worker.khach.weekEarn.insert(newWeek, at: 0)
                        }, label:{Image(systemName: "tray.and.arrow.down")})
                    }
                        }
                
                Section(header: Text("week were saved")){
                    ForEach(worker.khach.weekEarn) { tuan in
                        HStack {
                            Text(tuan.tuan)
                            Spacer()
                            Text("$\(tuan.earn)")
                        }
                    }.onDelete {tuan in
                        worker.khach.weekEarn.remove(atOffsets: tuan)
                    }
                }
                
                ForEach(text == "" ? xap : listDaTim) { khach in
                    NavigationLink(destination: ClientDetail(khach: binding(for: khach)) ){
                        KhachRow(khach: khach)
                    }
                }
            }
            .navigationTitle("Summary")
            .searchable(text: $text, placement: .automatic, prompt: "Find Name")
            .onChange(of: text){ timTu in
                listDaTim = worker.khach.khach.filter{$0.name.contains(timTu)}
            }
            
        }
    }//body
    
    private func binding(for theKhach: Khach) -> Binding<Khach> {
        guard let clientIndex = self.worker.khach.khach.firstIndex(where: {$0.id == theKhach.id}) else {
            fatalError("khong the lay khach")
        }
        return $worker.khach.khach[clientIndex]
    }
    
    func tongNgay() -> Int {
        var tong = 0
        for lan in worker.khach.khach {
            if lan.today {
                tong += lan.khachTra()
            }
        }
        return tong
    }
   
}

struct XapSep_Previews: PreviewProvider {
    static var previews: some View {
        XapSep()
            .environmentObject(KhachData())
    }
}

