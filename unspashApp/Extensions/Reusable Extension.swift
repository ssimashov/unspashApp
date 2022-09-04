//
//  Reusable Extension.swift
//  unspashApp
//
//  Created by Sergey Simashov on 03.09.2022.
//

import UIKit

protocol Reusable {}

extension Reusable where Self: UIView {
    static var reuseID: String {
        return String(describing: self)
    }
}
