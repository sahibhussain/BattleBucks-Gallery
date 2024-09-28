//
//  Array+Extension.swift
//  BattleBucks-Gallery
//
//  Created by Sahib Hussain on 27/09/24.
//

import Foundation

extension Array {
    func safeIndex(_ index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
