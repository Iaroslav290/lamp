//
//  ViewController.swift
//  Our_Rating
//
//  Created by Ярослав Вербило on 2023-06-17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        elements()
        [labelHi, labelName].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            labelHi.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            labelHi.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            labelName.topAnchor.constraint(equalTo: labelHi.bottomAnchor, constant: 0),
            labelName.leadingAnchor.constraint(equalTo: labelHi.leadingAnchor)
        ])
    }


}

