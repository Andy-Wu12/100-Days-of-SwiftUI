//
//  RatingView.swift
//  Bookworm
//
//  Created by Andy Wu on 1/14/23.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maxRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1...maxRating, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        // SwiftUI provides constant bindings, which are perfect for previews
        RatingView(rating: .constant(4))
    }
}
