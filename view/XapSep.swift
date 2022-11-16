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
    @State private var daluu = false
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Total:")
                    Spacer()
                    Text("\(worker.khach.tinhTheoNgay())")
                }
                Section(header: Text("today")){
                    HStack {
                        Text("Earn: $\(worker.khach.tongNgay())")
                            .foregroundColor(daluu ? .primary : .green)
                        Spacer()
                        Button(action: {
                            let newWeek = WeekEarn(tuan: "\(Date.now.formatted(date: .numeric, time: .omitted))", earn: worker.khach.tongNgay())
                            worker.khach.weekEarn.insert(newWeek, at: 0)
                            daluu = true
                        }, label:{Image(systemName: "tray.and.arrow.down")}).disabled(daluu)
                    }
                        }
                
                
                Section(header: Text("days were saved")){
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
   
}

struct XapSep_Previews: PreviewProvider {
    static var previews: some View {
        XapSep()
            .environmentObject(KhachData())
    }
}

