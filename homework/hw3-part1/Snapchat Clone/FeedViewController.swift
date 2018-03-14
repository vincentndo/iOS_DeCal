//
//  FeedViewController.swift
//  Snapchat Clone
//
//  Created by Vincent Ninh DO on 3/13/18.
//  Copyright © 2018 org.iosdecal. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func unwindToFeedView(segue: UIStoryboardSegue) {
        
    }
    
    var selectedFeedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func selectImage(_ image: UIImage) {
        self.selectedFeedImage = image
        performSegue(withIdentifier: "feedToImageView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "feedToImageView", let dest = segue.destination as? ImageViewController {
            dest.displayedImage = self.selectedFeedImage
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return threadNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return threadNames[section].capitalized
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return threads[threadNames[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedTableViewCell {
            
            var triplet = threads[threadNames[indexPath.section]]![indexPath.row]
            
            if triplet[1] as! Bool == false {
                cell.seenStatus.image = #imageLiteral(resourceName: "unread")
                cell.elapsedTime.text = "0 Minute Ago"
            } else {
                cell.seenStatus.image = #imageLiteral(resourceName: "read")
                
                let currentTime = Date()
                let calendar = Calendar.current

                let component = calendar.dateComponents([.minute], from: triplet[2] as! Date, to: currentTime)
                let suffix = component.minute! > 1 ? " Minutes Ago" : " Minute Ago"
                cell.elapsedTime.text = String(describing: component.minute!) + suffix
            }
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = tableView.cellForRow(at: indexPath) as? FeedTableViewCell {
            var triplet = threads[threadNames[indexPath.section]]![indexPath.row]
            if triplet[1] as! Bool == false {
                
                threads[threadNames[indexPath.section]]![indexPath.row][1] = true
                threads[threadNames[indexPath.section]]![indexPath.row][2] = Date()
                selectImage(triplet[0] as! UIImage)
                
            }
        }
    }
    
}
