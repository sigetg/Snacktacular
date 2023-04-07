//
//  Photo.swift
//  Snacktacular
//
//  Created by George Sigety on 4/7/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Photo: Identifiable, Codable {
    @DocumentID var id: String?
    var imageURLString = "" //this will hold the URL for leading the image
    var description = ""
    var reviewer = Auth.auth().currentUser?.email ?? ""
    var postedOn = Date()
    
    var dictionary: [String: Any] {
        return ["imageURLString": imageURLString, "description": description, "reviewer": reviewer, "postedOn": Timestamp(date: Date())]
    }
}
