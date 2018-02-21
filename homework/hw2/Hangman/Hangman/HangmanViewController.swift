//
//  HangmanViewController.swift
//  Hangman
//
//  Created by Vincent Ninh DO on 2/19/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var currentWord: UILabel!
    @IBOutlet weak var incorrectGuesses: UILabel!
    @IBOutlet weak var guessLetter: UITextField!
    
    var hangmanGame: HangmanGame?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hangmanGame = HangmanGame()
        renderDisplay()
        
    }
    
    func renderDisplay() {
        hangmanImage.image = UIImage(named: hangmanGame!.getImageName())
        currentWord.text = hangmanGame!.getCurrentWord()
        incorrectGuesses.text = hangmanGame!.getIncorrectGuesses()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ACTION
    
    @IBAction func startOver(_ sender: Any) {
        hangmanGame = HangmanGame()
        renderDisplay()
    }
    
    @IBAction func guessLetter(_ sender: Any) {

        if let letter = guessLetter.text, letter.count == 1  {
            
            if let ret = hangmanGame?.update(Character(letter)) {
                
                renderDisplay()
                
                if ret == 1 {
                    
                    let alertController = UIAlertController(title: "Congratulations!", message: "You won.", preferredStyle: .alert)

                    let action = UIAlertAction(title: "New Game", style: .default) { (action:UIAlertAction) in
                        self.hangmanGame = HangmanGame()
                        self.renderDisplay()
                    }
                    
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                    
                } else if ret == -1 {
                    
                    let alertController = UIAlertController(title: "Game over!", message: "You lost.", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "Try Again", style: .default) { (action:UIAlertAction) in
                        self.hangmanGame = HangmanGame()
                        self.renderDisplay()
                    }
                    
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                    
                } else {
                    renderDisplay()
                }
                
            } else {
                let alertController = UIAlertController(title: "Oops!", message: "You guessed this letter, and it is not correct.", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    self.renderDisplay()
                }
                
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
            
        } else {
            let alertController = UIAlertController(title: "Oops!", message: "One letter only.", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                self.renderDisplay()
            }
            
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
        
        guessLetter.text = nil
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
