# IOS_TimePickerView
A very basic swift inputView to be applied to text fields on iOS for users to select time as hours/minutes/seconds.  We use it extensively in [Gravitus](http://gravitus.co) to select time input for runs and cardio activities.

## Usage:
```
class MyClass {
  private var timeField: UITextField!
  private let timePicker = TimePickerView()
  
  func init() {
    timeField.inputView = timePicker  // Show TimePickerView when timeField gets focus
    timePicker.label = timeField      // Allows TimePickerView to set the timeField label when a new value is chosen
  }
}
```

[Screenshot](http://d.pr/i/1c5Q5)
