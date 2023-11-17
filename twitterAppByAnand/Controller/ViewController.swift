//
//  ViewController.swift
//  twitterAppByAnand
//
//  Created by APPLE on 14/11/23.
//

import UIKit

enum TypesOfSelection{
    case forYou
    case following
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tweetTblList: UITableView!
    @IBOutlet weak var forYouHL: UIView!
    @IBOutlet weak var followingHL: UIView!
    
    var Selection:TypesOfSelection = .forYou
    var currentPlayingIndexPath: IndexPath?
    var vm = TwitterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        configureTableView()
        fetchJsonData()
        
    }
    
    private func UISetup(){
        switch Selection{
        case .forYou :
            followingHL.isHidden = true
            forYouHL.isHidden = false
        case .following :
            forYouHL.isHidden = true
            followingHL.isHidden = false
        }
    }
    
    //fetch Json Data and table reload
    private func fetchJsonData(){
        vm.fetchTweetData{ [self] in
            tweetTblList.reloadData()
        }
    }
    
    //configure table view
    private func configureTableView() {
        tweetTblList.register(UINib(nibName: "TweetTVC", bundle: nil), forCellReuseIdentifier: "TweetTVC")
        tweetTblList.rowHeight = UITableView.automaticDimension
        tweetTblList.estimatedRowHeight = 500.0
    }
    
    @IBAction func forYouBtnAction(_ sender: Any) {
        self.Selection = .forYou
        UISetup()
        tweetTblList.reloadData()
    }
    
    @IBAction func followingBtnAction(_ sender: Any) {
        
        self.Selection = .following
        UISetup()
        tweetTblList.reloadData()
    }
}

//TODO: table view cell delegate and protocal
extension ViewController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Selection{
        case .forYou :
            return vm.tweetsList.count
        case .following :
            return vm.onlyTextView.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch Selection{
        case .forYou :
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTVC", for: indexPath) as? TweetTVC{
                let tweet = vm.tweetsList[indexPath.row]
                    cell.configure(with: tweet)
                return cell
            }
        case .following :
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTVC", for: indexPath) as? TweetTVC{
                let tweet = vm.onlyTextView[indexPath.row]
                    cell.configure(with: tweet)
                return cell
            }
        }

        
       
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? TweetTVC {
            // Check if there was a previous playing cell
            if let previousPlayingIndexPath = currentPlayingIndexPath, previousPlayingIndexPath != indexPath {
                // Pause the video of the previous playing cell
                if let previousPlayingCell = tableView.cellForRow(at: previousPlayingIndexPath) as? TweetTVC {
                    previousPlayingCell.pause()
                    print("player off index: \(indexPath.row)")
                }
            }
            currentPlayingIndexPath = indexPath
            videoCell.play()
            print("current show player index: \(indexPath.row)")
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? TweetTVC {
            print("player off index: \(indexPath.row)")
            videoCell.pause()
        }
    }
}

