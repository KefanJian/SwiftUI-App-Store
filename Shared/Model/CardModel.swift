//
//  CardModel.swift
//  AppStrore
//
//  Created by Kefan Jian on 2021/8/25.
//

import SwiftUI

struct CardModel: Identifiable, Codable {
    var id: Int
    let imageName: String
    let name: String
    let caption: String
    let descriptions: [String]
}
