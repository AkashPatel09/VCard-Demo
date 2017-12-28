//
//  ViewController.swift
//  VCard-Demo
//
//  Created by Akash Patel on 28/12/17.
//  Copyright © 2017 Akash Patel. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnClicked(_ sender: Any) {
        
        let arrayContacts = self.fetchAllContacts()
        self.saveContactsInDocument(contacts: arrayContacts)
        
    }
    
    func saveContactsInDocument(contacts : [CNContact]) {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let fileURL = URL.init(fileURLWithPath: documentsPath.appending("/MyContacts.vcf"))
        
        let data : NSData?
        do {
            
            try data = CNContactVCardSerialization.data(with: contacts) as! NSData
            
            do {
                try data?.write(to: fileURL, options: .atomic)
                print(fileURL.absoluteString)
            }
            catch {
                
                print("Failed to write!")
            }
        }
        catch {
            
            print("Failed!")
        }
    }
    
    func fetchAllContacts() -> [CNContact] {
        
        var contacts : [CNContact] = []
        
        let contactStore = CNContactStore()
        let fetchReq = CNContactFetchRequest.init(keysToFetch: [CNContactVCardSerialization.descriptorForRequiredKeys()])
        
        do {
            try contactStore.enumerateContacts(with: fetchReq) { (contact, end) in
            
            contacts.append(contact)
            }}
        catch  {
            
            print("Failed to fetch")
        }
        
        return contacts
    }
}

