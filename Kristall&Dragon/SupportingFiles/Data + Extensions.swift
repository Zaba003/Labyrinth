//
//  Data + Extensions.swift
//  Kristall&Dragon
//
//  Created by Кирилл Заборский on 25.11.2021.
//

import Foundation

extension Data {
    func removeNullsFrom(string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
