//
//  ImageViewController.swift
//  Snapchat Clone
//
//  Created by Vincent Ninh DO on 3/14/18.
//  Copyright © 2018 org.iosdecal. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageButton: UIButton!
    
    @IBAction func pressImageButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToFeedView", sender: self)
    }
    
    var displayedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imageButton.setBackgroundImage(self.displayedImage, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
