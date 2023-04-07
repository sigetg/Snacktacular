//
//  SpotReviewRowView.swift
//  Snacktacular
//
//  Created by George Sigety on 4/4/23.
//

import SwiftUI

struct SpotReviewRowView: View {
    @State var review: Review
    var body: some View {
        VStack(alignment: .leading) {
            Text(review.title)
            HStack {
                StarsSelectionView(rating: $review.rating, interactive: false, font: .callout)
                Text(review.body)
                    .font(.callout)
                    .lineLimit(1)
            }
        }
    }
}

struct SpotReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        SpotReviewRowView(review: Review(title: "fantastic food", body: "Great place. the food is delectable.", rating: 4))
    }
}
