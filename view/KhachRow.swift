//
//  KhachRow.swift
//  Ledger
//
//  Created by Thong Vu on 10/12/22.
//

import SwiftUI

struct KhachRow: View {
    var khach: Khach
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(khach.name)
                Spacer()
                Text("$\(khach.khachTra())")
            }
                .foregroundColor(khach.today ? .green : .gray)
            
            Text(khach.ngay, style: .date)
                .font(.footnote)
                .foregroundColor(.secondary)
        }.padding(6)
           
    }

   
}

struct KhachRow_Previews: PreviewProvider {
    static var previews: some View {
        KhachRow(khach: khachmau[0]).previewLayout(.fixed(width: 300, height: 50))
    }
}
//
