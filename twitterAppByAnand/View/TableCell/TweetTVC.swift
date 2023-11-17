//
//  TweetTVC.swift
//  twitterAppByAnand
//
//  Created by APPLE on 14/11/23.
//

import UIKit
import AVKit
import AVFoundation

class TweetTVC: UITableViewCell {
    
    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userIDNameLbl: UILabel!
    @IBOutlet weak var userDescriptionLbl: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var hashtagLbl: UILabel!
    @IBOutlet weak var showImgView: UIView!
    @IBOutlet weak var showVideoView: UIView!
    @IBOutlet weak var tweetImg: UIImageView!
    
    @IBOutlet weak var totalCommentBtn: UIButton!
    @IBOutlet weak var totalShareBtn: UIButton!
    @IBOutlet weak var totalLikeBtn: UIButton!
    @IBOutlet weak var totalSeenBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var videoView: UIView!
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(with tweet: Tweet) {
        userNameLbl.text = tweet.name
        userIDNameLbl.text = "\(tweet.tweetID + " . " + tweet.postTime)"
        userDescriptionLbl.text = tweet.description
        descriptionTextView.attributedText = highlightMentions(in: tweet.description, withColor: UIColor(hex: "#0075E3"))
        
        hashtagLbl.text = tweet.hashtag.joined(separator: "\n")
        if (tweet.postType) == "onlyTextView"{
            showImgView.isHidden = true
            showVideoView.isHidden = true
        }else if (tweet.postType) == "textViewWithImage"{
            showImgView.isHidden = false
            showVideoView.isHidden = true
        }else{
            showImgView.isHidden = true
            showVideoView.isHidden = false
            
            
            guard let videoURL = Bundle.main.url(forResource: tweet.postVideo, withExtension: "mp4") else {return }
            
            DispatchQueue.main.async { [self] in
                player = AVPlayer(url: videoURL)
                playerLayer = AVPlayerLayer(player: player)
                playerLayer?.frame = videoView.bounds
                playerLayer?.videoGravity = .resizeAspectFill
                playerLayer?.cornerRadius = 5.0
                videoView.layer.addSublayer(playerLayer!)
            }
           
        }
        tweetImg.image = UIImage(named: tweet.postImage)
        totalCommentBtn.setTitle(String(tweet.tweetCommentsCount), for: .normal)
        totalShareBtn.setTitle(String(tweet.tweetShareCount), for: .normal)
        totalLikeBtn.setTitle(String(tweet.tweetLikeCount), for: .normal)
        totalSeenBtn.setTitle(String(tweet.tweetSeenCount), for: .normal)
    }
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
}
