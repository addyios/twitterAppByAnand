//
//  TweetViewModel.swift
//  twitterAppByAnand
//
//  Created by APPLE on 14/11/23.
//

import Foundation
import UIKit

class TwitterViewModel {
    
    var tweetsList: [Tweet] = []
    var onlyTextView:[Tweet] = []
    
    func fetchTweetData(completion:@escaping () -> Void){
        if let path = Bundle.main.path(forResource: "tweetData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let result = try decoder.decode(TwitterData.self, from: data)
                tweetsList = result.tweets
                onlyTextView = result.tweets.filter { $0.postType == "onlyTextView" }
                completion()
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
}

