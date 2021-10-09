//
//  ViewController.swift
//  JBTextField
//
//  Created by jubakong@gmail.com on 12/29/2020.
//  Copyright (c) 2020 jubakong@gmail.com. All rights reserved.
//

import UIKit
import JBTextField

class ViewController: UIViewController {
  @IBOutlet weak var testTextField: JBTextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      testTextField.isTitleOn = true
      testTextField.titleText = "Title"
      testTextField.validation = { $0.count == 4 }
      testTextField.errorMessage = "Error!!"
      testTextField.errorMessageAlignment = .left
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

