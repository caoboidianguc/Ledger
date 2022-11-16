//
//  KhachData.swift
//  Ledger
//
//  Created by Thong Vu on 7/18/22.
//
import Foundation
import SwiftUI


class KhachData: ObservableObject {
    @Published var khach: Technician = Technician(name: "Quang")
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("client.data")
    }
    
    
    
    static func load(completion: @escaping (Result<Technician, Error>) -> Void){
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success(quang))
                    }
                    return
                }
                let khach = try JSONDecoder().decode(Technician.self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(khach))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(khach: Technician, completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(khach)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(1))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func delete(_ client: Khach){
        khach.khach.removeAll { $0.id == client.id }
    }
    
    func daDen(_ client: Khach) -> Bool {
        khach.khach.contains(client)
    }
    
    func theoNgay() -> Binding<[Khach]> {
        Binding<[Khach]> (
            get: {
                self.khach.khach.sorted(by: {$0.ngay > $1.ngay})
            },
            set: { khach in
                for client in khach {
                    if let index = self.khach.khach.firstIndex(where: {$0.id == client.id}) {
                        self.khach.khach[index] = client
                    }
                }
            }
        )
    }
    
    func tuan(quaTuan: QuaTuan) -> Binding<[Khach]> {
        Binding<[Khach]> (
        get: {
            self.khach.khach.filter {
                switch quaTuan {
                case .tuan:
                    return $0.haiNgay
                case .nuaThang:
                    return $0.overTuan
                case .xaxoi:
                    return $0.xahon
                }
            }.sorted(by: {$0.ngay < $1.ngay})
        },
        set: { khach in
            for client in khach {
                if let index = self.khach.khach.firstIndex(where: {$0.id == client.id}) {
                    self.khach.khach[index] = client
                }
            }
        }
        )
    }
    
}


enum QuaTuan: String, CaseIterable, Identifiable {
    case tuan = "Comming up"
    case nuaThang = "Within 7 week"
    case xaxoi = "Over week"
    
    var id: String {self.rawValue}
    var name: String {self.rawValue}
}
