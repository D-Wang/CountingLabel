//
//  CountingLabel.swift
//  CountingLabel
//
//  Created by WangWei on 2017/4/25.
//  Copyright © 2017年 Wang. All rights reserved.
//

import UIKit

public protocol CountingLabelValueFormatter: class {
    func string(fromValue value: CGFloat) -> String?
    func attributedString(fromValue value: CGFloat) -> NSAttributedString?
}

public extension CountingLabelValueFormatter {
    func string(fromValue value: CGFloat) -> String? {
        return nil
    }

    func attributedString(fromValue value: CGFloat) -> NSAttributedString? {
        return nil
    }
}

public enum AnimationOption {
    case linear
    case easeIn
    case easeOut
    case easeInOut

    fileprivate var updater: CountingLabelValueUpdater {
        switch self {
        case .linear:
            return LinearUpdater()
        case .easeIn:
            return EaseInUpdater()
        case .easeOut:
            return EaseOutUpdater()
        case .easeInOut:
            return EaseInOutUpdater()
        }
    }
}

fileprivate protocol CountingLabelValueUpdater {
    func update(value: CGFloat) -> CGFloat
}

fileprivate class LinearUpdater: CountingLabelValueUpdater {
    func update(value: CGFloat) -> CGFloat {
        return value
    }
}

fileprivate class EaseInUpdater: CountingLabelValueUpdater {
    func update(value: CGFloat) -> CGFloat {
        return pow(value, 3)
    }
}

fileprivate class EaseOutUpdater: CountingLabelValueUpdater {
    func update(value: CGFloat) -> CGFloat {
        return 1 - pow((1 - value), 3)
    }
}

fileprivate class EaseInOutUpdater: CountingLabelValueUpdater {
    func update(value: CGFloat) -> CGFloat {
        return 3 * pow(value, 2) - 2 * pow(value, 3)
    }
}

open class CountingLabel: UILabel {

    fileprivate var timer: CADisplayLink?
    fileprivate var lastUpdate: TimeInterval = 0
    fileprivate var progress: TimeInterval = 0
    public var duration: TimeInterval = 2

    fileprivate var fromValue: CGFloat = 0
    fileprivate var toValue: CGFloat = 100

    
    /// String format will be used if no valueFormatter avaliable
    public var format: String = "%.0f"
    
    /// You can implement protocol CountingLabelValueFormatter for your own value formatter
    /// Refer to PercentFormatter in CountingLabelDemo
    public var valueFormatter: CountingLabelValueFormatter?
    fileprivate var valueUpdater: CountingLabelValueUpdater?

    public var currentValue: CGFloat {
        if progress >= duration {
            return toValue
        }

        let percent = CGFloat(progress / duration)
        let updatePercent = (valueUpdater ?? LinearUpdater()).update(value: percent)
        return fromValue + updatePercent * (toValue - fromValue)
    }

    
    /// count from `fromValue` to `toValue`
    ///
    /// - Parameters:
    ///   - fromValue: start value
    ///   - toValue: destination value
    ///   - duration: total duration
    ///   - option: AnimationOption, default is linear
    public func count(fromValue: CGFloat, toValue: CGFloat, duration: TimeInterval = 2, option: AnimationOption = .linear) {
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration

        timer?.invalidate()
        timer = nil
        progress = 0
        lastUpdate = Date.timeIntervalSinceReferenceDate

        if duration == 0 {
            updateLabel(withValue: toValue)
            return
        }

        valueUpdater = option.updater

        timer = CADisplayLink(target: self, selector: #selector(updateValue))
        if #available(iOS 10.0, *) {
            timer?.preferredFramesPerSecond = 30
        } else {
            timer?.frameInterval = 2
        }
        timer?.add(to: .main, forMode: .commonModes)
    }

    func updateValue(timer: CADisplayLink) {
        let now = Date.timeIntervalSinceReferenceDate
        progress += now - lastUpdate
        lastUpdate = now

        if progress > duration {
            self.timer?.invalidate()
            self.timer = nil
            progress = duration
        }

        updateLabel(withValue: currentValue)
    }

    func updateLabel(withValue value: CGFloat) {
        if let formatter = valueFormatter {
            if let attributedString = formatter.attributedString(fromValue: value) {
                attributedText = attributedString
            } else {
                text = valueFormatter?.string(fromValue: value)
            }
        } else {
            text = String(format: format, value)
        }
    }
}
