//
//  UserProfile.swift
//  iOS-FakeNFT-Extended
//
//  Created by Vitaly Lobov on 26.06.2025.
//

import Foundation

struct UserProfile: Codable, Identifiable, Sendable, Equatable {
    let id: String
    var name: String
    var description: String
    var website: String
    var avatar: String?
    var nfts: [String]
    var likes: [String]
}
//
//struct UpdateProfileRequest: Encodable {
//    let likes: String
//    let avatar: String
//    let name: String
//    let description: String
//    let website: String
//
//    init(profile: UserProfile) {
//        self.likes = profile.likes.joined(separator: ",")
//        self.avatar = profile.avatar ?? ""
//        self.name = profile.name
//        self.description = profile.description
//        self.website = profile.website
//    }
//    
//    func encode(to encoder: Encoder) throws {
//            var container = encoder.singleValueContainer()
//            let parameters: [String: String] = [
//                "name": name,
//                "description": description,
//                "website": website,
//                "avatar": avatar
//            ]
//            let formString = parameters
//                .map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")" }
//                .joined(separator: "&")
//
//            guard let data = formString.data(using: .utf8) else {
//                throw EncodingError.invalidValue(formString, .init(codingPath: encoder.codingPath, debugDescription: "Unable to encode form data."))
//            }
//
//            try container.encode(data)
//        }
//}
