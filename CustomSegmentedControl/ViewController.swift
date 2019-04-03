//
//  ViewController.swift
//  CustomSegmentControl
//
//  Created by Tara Singh M C on 02/04/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var segmentedControl: CustomSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSegmentControl()
        
        self.view.backgroundColor = .red

    }


    func addSegmentControl() {
        segmentedControl = CustomSegmentedControl.init(items: ["First", "Two", "Three"])
        segmentedControl.backgroundColor = .white
        segmentedControl.addTarget(self, action: #selector(onChangeOfSegment(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([

            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            segmentedControl.heightAnchor.constraint(equalToConstant: 45)
            ])
        
        
    }
    
    @objc func onChangeOfSegment(_ sender: CustomSegmentedControl) {
        
        
        switch sender.selectedSegmentIndex {
        case 0:
           self.view.backgroundColor = .red
            
        case 1:
           self.view.backgroundColor = .yellow
        case 2:
            self.view.backgroundColor = .green
        default:
            break
        }
        
        
    }
}

