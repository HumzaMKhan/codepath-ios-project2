//
//  TweetViewController.swift
//  Twitter
//
//  Created by Humza Khan on 4/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var charactersRemaining: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
    }
    
    func textView(_ tweetTextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 280
        
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        
        if(newText.count <= characterLimit) {
            charactersRemaining.text = "\(280 - newText.count)"
        }
        
        return newText.count <= characterLimit
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if(!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (Error) in
                print("Error posting tweet \(Error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
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

}
