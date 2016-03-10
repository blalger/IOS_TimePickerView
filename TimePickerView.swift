//
//  TimePickerView.swift
//
//  Originally written by Mark Flores on 10/26/15 for Gravitus (http://gravitus.co).
//  Released to open source per MIT License
//

import UIKit

class TimePickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    enum ComponentType: Int {
        case Hours = 0
        case Minutes = 1
        case Seconds = 2
    }
    
    private static let secondsInMinute = 60
    private static let minutesInHour = 60
    private static let secondsInHour = 3600
    private static let formatLeadingZero = "%02lu"
    
    private var hoursLabel: UILabel!
    private var minutesLabel: UILabel!
    private var secondsLabel: UILabel!
    private var everSet = false
    private var hours: Int = 0
    private var minutes: Int = 0
    private var seconds: Int = 0
    var label: UITextField?
    
    var displayMinutesSeconds: String? {
        let formattedSeconds = String(format: TimePickerView.formatLeadingZero, seconds)
        if hours > 0 {
            let formattedMinutes = String(format: TimePickerView.formatLeadingZero, minutes)
            return "\(hours):\(formattedMinutes):\(formattedSeconds)"
        }
        return "\(minutes):\(formattedSeconds)"
    }
    
    var getTotalTimeInSeconds: Int? {
        return everSet ? hours * TimePickerView.secondsInHour + minutes * TimePickerView.secondsInMinute + seconds : nil
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
        setup()
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        hoursLabel = UILabel()
        hoursLabel.text = "hr"
        hoursLabel.font = cellTitleFont
        addSubview(hoursLabel)
        
        minutesLabel = UILabel()
        minutesLabel.text = "min"
        minutesLabel.font = cellTitleFont
        addSubview(minutesLabel)
        
        secondsLabel = UILabel()
        secondsLabel.backgroundColor = UIColor.clearColor()
        secondsLabel.text = "sec"
        secondsLabel.font = cellTitleFont
        addSubview(secondsLabel)

        delegate = self
        dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        hoursLabel.frame = CGRect(x: (frame.size.width / 6) + 16, y: frame.size.height / 2 - 15, width: 75, height: 30)
        minutesLabel.frame = CGRect(x: (3 * frame.size.width / 6) + 22, y: frame.size.height / 2 - 15, width: 75, height: 30)
        secondsLabel.frame = CGRect(x: (5 * frame.size.width / 6) + 22, y: frame.size.height / 2 - 15, width: 75, height: 30)
    }
    
    func setPickerToTime(totalSeconds: Int, explicitSet: Bool) {
        hours = totalSeconds / TimePickerView.secondsInHour
        minutes = (totalSeconds % TimePickerView.secondsInHour) / TimePickerView.secondsInMinute
        seconds = totalSeconds % TimePickerView.secondsInMinute
        selectRow(hours, inComponent: ComponentType.Hours.rawValue, animated: false)
        selectRow(minutes, inComponent: ComponentType.Minutes.rawValue, animated: false)
        selectRow(seconds, inComponent: ComponentType.Seconds.rawValue, animated: false)
        everSet = explicitSet
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case ComponentType.Hours.rawValue:
            return 8
        case ComponentType.Minutes.rawValue:
            return TimePickerView.minutesInHour
        case ComponentType.Seconds.rawValue:
            return TimePickerView.secondsInMinute
        default:
            fatalError("Invalid component")
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){        
        switch component {
        case ComponentType.Hours.rawValue:
            hours = row
        case ComponentType.Minutes.rawValue:
            minutes = row
        case ComponentType.Seconds.rawValue:
            seconds = row
        default:
            fatalError("no component with number \(component)")
        }
        
        everSet = true
        label?.text = displayMinutesSeconds
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
}
