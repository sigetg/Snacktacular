//
//  SoptViewModel.swift
//  Snacktacular
//
//  Created by George Sigety on 3/27/23.
//

import Foundation
import FirebaseFirestore

class SpotViewModel: ObservableObject {
    @Published var spot = Spot()
    
    func saveSpot(spot: Spot) async -> Bool {
        let db = Firestore.firestore() //ignore any error that shows up here. Wait for indexing. Clean build if it persists with Shift+Command+K.
        if let id = spot.id { //spot must already exist, so save
            do {
                try await db.collection("spots").document(id).setData(spot.dictionary)
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not update data in 'spots' \(error.localizedDescription)")
                return false
            }
        } else { //no id? then this must be a new spot to add.
            do {
                try await db.collection("spots").addDocument(data: spot.dictionary)
                print("🐣 Data created successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not create a new spot in 'spots' \(error.localizedDescription)")
                return false

            }
        }
    }
}
