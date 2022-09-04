//
//  Double extension.swift
//  unspashApp
//
//  Created by Sergey Simashov on 04.09.2022.
//

import Foundation

extension Double {
    
    func addSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(for: self) ?? ""
    }
}
