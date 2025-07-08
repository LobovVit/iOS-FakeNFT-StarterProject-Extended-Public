//
//  RoundedCorner.swift
//  iOS-FakeNFT-Extended
//
//  Created by Demain Petropavlov on 30.06.2025.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = 12
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
