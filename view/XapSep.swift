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
                Section(header: Text("Last week earn: $\(worker.khach.tongTuan())")){
                        ForEach(text == "" ? worker.khach.khach : listDaTim){kha in
                            NavigationLink(destination: ClientDetail(khach: binding(for: kha))){
                                KhachRow(khach: kha)
                            }
                        }}
                
            }
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

