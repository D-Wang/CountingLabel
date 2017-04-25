# CountingLabel ####

Swift version of [UICountingLabel](https://github.com/dataxpress/UICountingLabel)

Adds animated counting support to `UILabel`.

![alt text](https://github.com/D-Wang/CountingLabel/blob/master/demo.gif "demo")

## Integration ######
### Drop-in
All necessary classes & methods are written in `CountingLabel.swift`, you can just put that file in your project or copy it.

### Carthage
You can add a dependency on `CountingLabel` by adding it to your `Cartfile`:

```
github "D-Wang/CountingLabel"
```


## Usage ######
`CountingLabel` is subclass of `UILabel`, just use it as `UILabel`.
Call `count(fromValue: CGFloat, toValue: CGFloat, duration: TimeInterval = 2, option: AnimationOption = .linear)` to start the animation.

### Format #####
There are two ways to set the format of your label:

* Set `label.format` like "%.0f".
* Implement `CountingLabelValueFormatter` like `PercentFormatter` in the demo, and set `label.valueFormatter` to an instance of that.

`valueFormatter` has higher priority than `label.format`

### AnimationOption

`CountingLabel` support four kind of changing rate, and default is linear. Pass argument `option` in method `count(fromValue: CGFloat, toValue: CGFloat, duration: TimeInterval = 2, option: AnimationOption = .linear)` to change that.
Avaliable options are:

```
public enum AnimationOption {
    case linear
    case easeIn
    case easeOut
    case easeInOut
}
```