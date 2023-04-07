//
//  ReviewViewModel.swift
//  Snacktacular
//
//  Created by George Sigety on 4/2/23.
//

import Foundation
import FirebaseFirestore

class ReviewViewModel: ObservableObject {
    @Published var review = Review()
    
    func saveReview(spot: Spot, review: Review) async -> Bool {
        let db = Firestore.firestore() //ignore any error that shows up here. Wait for indexing. Clean build if it persists with Shift+Command+K.
        
        guard let spotID = spot.id else {
            print("😡 ERROR: spot.id = nil")
            return false
        }
        
        let collectionString = "spots/\(spotID)/reviews"
        
        if let id = review.id { //review must already exist, so save
            do {
                try await db.collection(collectionString).document(id).setData(review.dictionary)
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not update data in 'reviews' \(error.localizedDescription)")
                return false
            }
        } else { //no id? then this must be a new review to add.
            do {
                _ = try await db.collection(collectionString).addDocument(data: review.dictionary)
                print("🐣 Data created successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not create a new review in 'reviews' \(error.localizedDescription)")
                return false

            }
        }
    }
    
    func deleteReview(spot: Spot, review: Review) async -> Bool {
        let db = Firestore.firestore()
        guard let spotID = spot.id, let reviewID = review.id else {
            print("😡 ERROR: spot.id = \(spot.id ?? "nil"), review.id = \(review.id ?? "nil"). This should not have happened.")
            return false
        }
        do {
            let _ = try await db.collection("spots").document(spotID).collection("reviews").document(reviewID).delete()
            print("🗑️ document successfully deleted!")
            return true
        } catch {
            print("😡 ERROR: removing document \(error.localizedDescription)")
            return false
        }
    }
}
