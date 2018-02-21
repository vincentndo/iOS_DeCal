//
//  HangmanGame.swift
//  Hangman
//
//  Created by Vincent Ninh DO on 2/19/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import Foundation

class HangmanGame {
    
    private static var hangmanImages = ["hangman1", "hangman2", "hangman3", "hangman4", "hangman5", "hangman6", "hangman7"]

    let hangmanWord: String
    private var hiddenLetters: [Character]
    private var incorrectGuesses: String
    
    init() {
        let hangmanPhrases = HangmanPhrases()
        
        // Generate a random phrase for the user to guess
        let phrase: String = hangmanPhrases.getRandomPhrase()
        print(phrase)
        
        hangmanWord = phrase
        self.incorrectGuesses = ""
        self.hiddenLetters = []
//        while self.hiddenLetters.count < 3 {
//            let randomIndex = Int(arc4random_uniform(UInt32(hangmanWord.count)))
//            let i = hangmanWord.index(hangmanWord.startIndex, offsetBy: randomIndex)
//            if  !self.hiddenLetters.contains(hangmanWord[i]) && hangmanWord[i] != " " {
//                self.hiddenLetters.append(hangmanWord[i])
//            }
//        }
        for c in hangmanWord {
            if !self.hiddenLetters.contains(c) && c != " " {
                self.hiddenLetters.append(c)
            }
        }
    }
    
    func getImageName() -> String {
        return HangmanGame.hangmanImages[self.incorrectGuesses.count]
    }
    
    func getCurrentWord() -> String {
        var ret = ""
        for c in hangmanWord {
            if self.hiddenLetters.contains(c) {
                ret += "-"
            } else {
                ret += String(c)
            }
        }
        return ret
    }
    
    func getIncorrectGuesses() -> String {
        return "Incorrect Guesses: " + self.incorrectGuesses
    }
    
    func update(_ letter: Character) -> Int? {
        if self.incorrectGuesses.range(of: String(letter)) != nil {
            return nil
        } else {
            if self.hiddenLetters.contains(letter) {
                let index = self.hiddenLetters.index(of: letter)
                self.hiddenLetters.remove(at: index!)
                if self.hiddenLetters.count == 0 {
                    return 1
                } else {
                    return 0
                }
            } else {
                self.incorrectGuesses += String(letter)
                if self.incorrectGuesses.count == 6 {
                    return -1
                } else {
                    return 0
                }
            }
        }
    }
}
