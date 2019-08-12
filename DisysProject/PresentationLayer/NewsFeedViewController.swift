//
//  NewsFeedViewController.swift
//  DisysProject
//
//  Created by Moses on 12/08/19.
//  Copyright © 2019 Raja Inbam. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var newsFeedTableView: UITableView!
    var newsFeedsData = NewsFeeds()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newsFeedTableView.isHidden = true
        self.navigationItem.title =  "News Feeds"
        // Do any additional setup after loading the view.
        self.newsFeedTableView.delegate = self
        self.newsFeedTableView.dataSource = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        self.newsFeedTableView.refreshControl = refreshControl
        self.newsFeedTableView.estimatedRowHeight = 100
        self.activityIndicator.startAnimating()
        self.makeFeedCallAndRefreshTableView()
    }

    @objc func doSomething(refreshControl: UIRefreshControl) {
        print("Hello World!")
        self.makeFeedCallAndRefreshTableView()
        // somewhere in your code you might need to call:
        refreshControl.endRefreshing()
    }
    
    func makeFeedCallAndRefreshTableView(){
        
        DisysServiceHandler.getFeedData(SuccessCallBack: { (responseStatus, response) in
            guard let _ = response,
                let newsFeedsData = NewsFeeds.init(json: (response)) else {
                    return
            }
            
            if !newsFeedsData.payload.isEmpty{
                self.newsFeedsData = newsFeedsData
                self.reloadTableView()
            }
            
        }) { (error) in
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func reloadTableView(){
        self.newsFeedTableView.isHidden = false
        self.newsFeedTableView.reloadData()
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}

extension NewsFeedViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsFeedsData.payload.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! NewsFeedTableViewCell
        let payload = self.newsFeedsData.payload[indexPath.row]
        cell.configureCell(payload: payload)
        return cell
    }
}
extension NewsFeedViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


