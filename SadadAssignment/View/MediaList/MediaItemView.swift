//
//  MediaItemView.swift
//  SadadAssignment
//
//  Created by kiarash on 8/12/24.
//

import SwiftUI

struct MediaItemView: View {
    let previewLink: String
    let title: String
    let imageWidth = 150.0
    let imageHeight = 150.0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: previewLink)) { image in
                image
                    .resizable()
                    .frame(width: imageWidth, height: imageHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
            } placeholder: {
                ProgressView()
                    .frame(height: imageHeight)
            }
            
                Text(title)
                    .frame(maxWidth: imageWidth)
                    .background {
                        Rectangle()
                            .fill(Color.gray.opacity(0.7))
                            .cornerRadius(12, corners: [.bottomRight, .bottomLeft])
                    }
            
        }
    }
}

#Preview {
    MediaItemView(previewLink: "https://wallpapershome.com/images/pages/ico_v/25365.jpg", title: "Text 1")
}

