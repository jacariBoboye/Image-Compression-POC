//
//  PreviewVC.swift
//  ImageCompressionPOC
//
//  Created by Jacari Boboye on 3/19/19.
//  Copyright © 2019 Jacari Boboye. All rights reserved.
//

import Foundation
import UIKit

class PreviewViewController: UIViewController{
    @IBOutlet var scrollView: UIScrollView!
    @IBAction func dismissActionButton(_ sender: Any) {
        //Show picker 
        self.dismiss(animated: true) { }
    }
}


extension PreviewViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
}
