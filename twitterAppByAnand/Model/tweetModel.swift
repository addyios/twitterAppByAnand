//
//  tweetModel.swift
//  twitterAppByAnand
//
//  Created by APPLE on 14/11/23.
//

import Foundation
import UIKit


struct TwitterData: Codable {
    let tweets: [Tweet]
}

struct Tweet: Codable {
    let postType: String
    let profileImage: String
    let name, tweetID, createdAt, description: String
    let hashtag: [String]
    let postVideo: String
    let postImage, postTime: String
    let tweetCommentsCount, tweetShareCount, tweetLikeCount, tweetSeenCount: Int

    enum CodingKeys: String, CodingKey {
        case postType = "post_type"
        case profileImage = "profile_image"
        case name
        case tweetID = "tweet_id"
        case createdAt = "created_at"
        case description, hashtag
        case postImage = "post_image"
        case postVideo = "post_video"
        case tweetCommentsCount = "tweet_comments_count"
        case tweetShareCount = "tweet_share_count"
        case tweetLikeCount = "tweet_like_count"
        case tweetSeenCount = "tweet_seen_count"
        case postTime = "post_date"
    }
}

