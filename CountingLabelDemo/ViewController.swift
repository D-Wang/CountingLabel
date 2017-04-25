//
//  ViewController.swift
//  CountingLabelDemo
//
//  Created by WangWei on 2017/4/25.
//  Copyright © 2017年 Wang. All rights reserved.
//

import UIKit
import CountingLabel

class ViewController: UIViewController {
    lazy var label: CountingLabel = {
        let label = CountingLabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.valueFormatter = PercentFormatter()

        return label
    }()

    lazy var button: UIButton = {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Layout subviews
        view.addSubview(label)
        let hLabel = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        let vLabel = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        view.addConstraints([hLabel, vLabel])
        label.count(fromValue: 0, toValue: 0)

        view.addSubview(button)
        let hButton = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        let vButton = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1.0, constant: 10)
        view.addConstraints([hButton, vButton])
        button.addTarget(self, action: #selector(tapOn(_:)), for: .touchUpInside)
    }

    func tapOn(_ button: UIButton) {
        let toValue = arc4random() % 100
        label.count(fromValue: 0, toValue: CGFloat(toValue), duration: 2, option: .easeInOut)
    }
}

