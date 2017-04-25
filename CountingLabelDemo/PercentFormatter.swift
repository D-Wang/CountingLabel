//
//  PercentFormatter.swift
//  CountingLabel
//
//  Created by WangWei on 2017/4/25.
//  Copyright © 2017年 Wang. All rights reserved.
//

import CountingLabel


/// Simple CountingLabelValueFormatter to convert value to NSAttributedString with large number and small percent mark.
class PercentFormatter: CountingLabelValueFormatter {

    func attributedString(fromValue value: CGFloat) -> NSAttributedString? {
        
        let rawString = String(format: "%.0f", value)
        let numberString = NSMutableAttributedString(string: rawString, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 36)])

        let percentString = NSAttributedString(string: "%", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        numberString.append(percentString)

        return numberString
    }
}
