//
//  ChonDichVu.swift
//  Ledger
//
//  Created by Thong Vu on 11/2/22.
//

import SwiftUI

struct ChonDichVu: View {
    @EnvironmentObject var worker: KhachData
    @Binding var client: Khach.ThemKhach
    var cotGrid: [GridItem] = [GridItem(spacing:5, alignment: .center),
                               GridItem(spacing:5, alignment: .center),
                               GridItem(spacing:5, alignment: .center)]
    
    
    
    var body: some View {
        LazyVGrid (columns: cotGrid,alignment: .center, spacing: 5, content: {
            ForEach(worker.khach.services){ serv in
                Button(action: {
                    client.dvDone.append(serv)
                }, label: {
                    VStack {
                    Text(serv.dichVu)
                    Text("$\(serv.gia)")
                    }.padding()
                            
                })
            }
        })
    }
}

struct ChonDichVu_Previews: PreviewProvider {
    static var previews: some View {
        ChonDichVu(client: .constant(khachmau[0].mau))
            .environmentObject(KhachData())
    }
}
