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
    let type: MediaType
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            AsyncImage(url: URL(string: previewLink)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                case .failure(_):
                    failedLoadPlaceholder()
                default:
                    ProgressView()
                        .frame(height: 150)
                }
            }
            Rectangle()
                .fill(Color.gray.opacity(0.7))
                .cornerRadius(12, corners: [.bottomRight, .bottomLeft])
                .frame(maxWidth: .infinity, maxHeight: 25)
                .overlay(alignment: .center) {
                    Text(title)
                        .foregroundStyle(Color.black)
                }
                .overlay(alignment: .trailing) {
                    Image(systemName: "play.circle")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(Color.black)
                        .frame(width: 15, height: 15)
                        .padding(.trailing)
                        .opacity(type.isPlayable ? 1 : 0)
                }
        }
        .padding(.horizontal)
    }
    @ViewBuilder
    func failedLoadPlaceholder() -> some View {
        ZStack {
            // Background with a gradient and subtle glassmorphism effect
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.9, green: 0.9, blue: 0.9),
                            Color(red: 0.8, green: 0.8, blue: 0.8)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            // Icon and text with error message
            VStack(spacing: 15) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60) // Error icon
                    .foregroundColor(.red.opacity(0.8))
                
                Text("Failed to Load Image")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
            .padding(.bottom)
        }
        .frame(maxWidth: .infinity) // Larger frame for prominence
        .frame(height: 150)
    }
}

#Preview {
    MediaItemView(previewLink: "https://wallpapershome.com/images/pages/ico_h/25371.jpg", title: "Text 1", type: .image)
}

