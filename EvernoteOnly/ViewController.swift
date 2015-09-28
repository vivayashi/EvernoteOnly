//
//  ViewController.swift
//  EvernoteOnly
//
//  Created by Yutaro OBAYASHI on 2015/09/28.
//  Copyright © 2015年 Yutaro OBAYASHI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let CONSUMER_KEY    = "CONSUMER_KEY"
    let CONSUMER_SECRET = "CONSUMER_SECRET"
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        postTestNote()
    }
    
    private func postTestNote() {
        ENSession.setSharedSessionConsumerKey(CONSUMER_KEY, consumerSecret: CONSUMER_SECRET,
            optionalHost: ENSessionHostSandbox)
        
        let session = ENSession.sharedSession()
        if session.isAuthenticated {
            let note = ENNote()
            note.title = "Evernote Only Test"
            note.content = ENNoteContent(string: "Evernote Only test")
            session.uploadNote(note, notebook: nil, completion: { noteRef, error in
                if error == nil {
                    print("OK")
                } else {
                    print("Upload note error: \(error)")
                }
            })
        } else {
            session.authenticateWithViewController(self, preferRegistration: false, completion: { error in
                if error == nil {
                    self.postTestNote()
                } else {
                    print("Authentication error: \(error)")
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}