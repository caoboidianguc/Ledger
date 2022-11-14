//
//  GhiChu.swift
//  Ledger
//
//  Created by Thong Vu on 11/11/22.
//

import SwiftUI

struct GhiChu: View {
    var nhanVien: Technician
    
    var body: some View {
        List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
            Text("Tuan dau lam duoc: $1000")
        }
    }
}

struct GhiChu_Previews: PreviewProvider {
    static var previews: some View {
        GhiChu(nhanVien: quang)
    }
}
