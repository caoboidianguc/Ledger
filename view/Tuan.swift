//
//  Tuan.swift
//  Ledger
//
//  Created by Thong Vu on 11/4/22.
//

import SwiftUI

struct Tuan: View {
    var khach: [Khach]
    var body: some View {
        List {
            ForEach(khach) { khach in
                if khach.tuan {
                    /*@START_MENU_TOKEN@*/HStack {
                        Text(khach.name)
                        Spacer()
                        Text("\(khach.ngay, style: .date)")
                    }/*@END_MENU_TOKEN@*/
                }
            }
        }
    }
}

struct Tuan_Previews: PreviewProvider {
    static var previews: some View {
        Tuan(khach: khachmau)
    }
}
