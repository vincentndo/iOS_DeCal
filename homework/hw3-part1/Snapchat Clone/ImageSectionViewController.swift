//
//  ImageSectionViewController.swift
//  Snapchat Clone
//
//  Created by Vincent Ninh DO on 3/13/18.
//  Copyright © 2018 org.iosdecal. All rights reserved.
//

import UIKit

class ImageSectionViewController: UIViewController {

    var selectedImage: UIImage?
    var selectedSectionName: String?
    
    @IBOutlet weak var selectedSectionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertDidPostImage() {
        
        let alertDidPostImageController = UIAlertController(title: "Image Posted!", message: "Click OK to go back to the image picker", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {(action: UIAlertAction!) in
            self.performSegue(withIdentifier: "unwindSegueToPicker", sender: self)
        })
        
        alertDidPostImageController.addAction(action)
        self.present(alertDidPostImageController, animated: true, completion: nil)
        
    }
    
    func alertSelectSection() {
        
        let alertSelectSectionController = UIAlertController(title: "Select Section!", message: "Please select a section for you image", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertSelectSectionController.addAction(action)
        self.present(alertSelectSectionController, animated: true, completion: nil)
        
    }
    
    @IBAction func postImage(_ sender: Any) {

        if self.selectedSectionName == nil {
            self.alertSelectSection()
        } else {
            
            threads[self.selectedSectionName!]?.append([self.selectedImage!, false, nil])
            self.selectedImage = nil
            self.selectedSectionName = nil
            self.selectedSectionLabel.text = ""
            self.alertDidPostImage()
            
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

extension ImageSectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return threadNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as? SectionTableViewCell {
            cell.textLabel!.text = threadNames[indexPath.row].capitalized
            cell.textLabel!.textAlignment = NSTextAlignment.center
            cell.textLabel!.font = UIFont.systemFont(ofSize: 24)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let _ = tableView.cellForRow(at: indexPath) as? SectionTableViewCell {
            
            self.selectedSectionName = threadNames[indexPath.row]
            self.selectedSectionLabel.text = self.selectedSectionName!.capitalized
            
        }
        
    }
}
