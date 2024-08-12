//
//  Extention + View.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
