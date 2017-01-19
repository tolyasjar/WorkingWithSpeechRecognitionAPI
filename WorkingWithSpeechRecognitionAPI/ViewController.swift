//
//  ViewController.swift
//  WorkingWithSpeechRecognitionAPI
//
//  Created by Toleen Jaradat on 1/10/17.
//  Copyright © 2017 Toleen Jaradat. All rights reserved.
//

import UIKit
import Speech
import AVFoundation


class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    @IBOutlet weak var textView: UITextView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
    }

    @IBAction func buttonPressed(_ sender: Any) {
        self.activitySpinner.isHidden = false
        self.activitySpinner.startAnimating()
        requestSpechAuth()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    func requestSpechAuth(){
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                
                //// Play Audio file
                if let path = Bundle.main.url(forResource: "movie", withExtension: "m4a") {
                    
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                        
                    } catch {  print("Error!")  }
                    
                //// Analyzing the Audio file
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print ("There was an error: \(error)")
                        } else {
                            self.textView.text =  result?.bestTranscription.formattedString
                        }
                    }
             }
         }
     }
  }

}
