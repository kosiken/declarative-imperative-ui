# Declarative vs Imperative UI

 In designing the user interfaces of human facing computer applications there are a couple of approaches that we can follow. I would be going over two approaches in this session

1. Declarative UI Implemntation
2. Imperative UI Implementation



### Declarative UI Implemntation

We'd start with what a declarative UI is a user interface implementation approach that declares or implements what the interface should look like, the possible states a user interface should have  and relies on a framework or system to update the UI and manage state transitons.

```swift

import SwiftUI

struct StopwatchView: View {
    // Timer properties
    @State private var isRunning = false
    @State private var elapsedTimeText = "00:00:00"
    @State private var timer: Timer? = nil
    @State private var currentTime = ["ms": 0, "mins": 0, "secs": 0]
    
    var body: some View {
        VStack(spacing: 20) {
            // Time Display
            Text("StopWatch")
                .font(.system (size: 23, weight: .heavy))
                .padding()
            
            Text(formatTime(currentTime)).font(.system(size: 30, weight: .black))
            
            // Start/Stop Button
            Button(action: toggleTimer) {
                Text(isRunning ? "Stop" : "Start")
                    .font(.body)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                  
                   
                    
                 
            }
            .buttonStyle(DefaultButtonStyle())
         
            .padding(.horizontal)
        }
        .padding()
    }
    
    // Format time as HH:MM:SS
    func formatTime(_ elapsed: Dictionary<String, Int>) -> String {
        let mins = elapsed["mins"]!
        let secs = elapsed["secs"]!
        let ms = (elapsed["ms"]! / 10)
        let currentValue = String(format: "%02d:%02d:%02d", mins, secs, ms)
        return currentValue
    }
    
    // Toggle timer start/stop
    func toggleTimer() {
        if isRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    // Start the timer
    func startTimer() {
        currentTime = ["ms": 0, "mins": 0, "secs": 0]
        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { _ in
           
            var previousMs: Int = currentTime["ms"]!
            var previousSecs: Int = currentTime["secs"]!
            var previousMins: Int = currentTime["mins"]!
            previousMs = previousMs + 1;
              if(previousMs > 999) {
                  previousMs = 0;
                  previousSecs = previousSecs + 1;
              }
              if(previousSecs > 59) {
                  previousSecs = 0;
                  previousMins = previousMins + 1;
              }
            
            currentTime = ["mins": previousMins, "secs": previousSecs, "ms": previousMs]
            
        }
        isRunning = true
    }
    
    // Stop the timer
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
    }
}


```

The above snippet of code is an example of a user interface implemented in a declarative style using [Swift UI](https://developer.apple.com/xcode/swiftui/). Notice how the UI is **"declared"** along with some `state` parameters.

As we can see here there two main states the UI can be in. 

- One where the stopwatch is running `isRunning = true`.
    - We set `isRunning = true` and start a repeating timer that updates the value of the state variable `currentValue`.
    - This triggers swift UI, the ***framework*** in this example to update the UI to show users that something is happening

- One where the stopwatch is stopped `isRunning = false`
    - We can see that we set `isRunning = false`. The timer is cancelled and swift UI updates the UI to show that


We can discern a couple of characteristics of **Declarative UI** from the code snippet

- **Focus on State**: You define the UI as a function of the application's state.
    - This can greatly simplify  complex UIs by abstracting DOM manipulations or widget updates
    - This may also abstract too much, leading to performance bottlenecks if the framework or code is not optimized.

- **A lot of abstraction**: Since you only manage the state. Swift UI abstracts the process for actually updating the UI
    - Easier to reason about: the UI is just a reflection of the current state
    - Debugging framework behavior can sometimes be harder because of these abstractions

- **Easier Maintenance**: Code is usually more concise and easier to understand.


##### Examples of Declarative UI frameworks

- [Jetpack Compose](https://developer.android.com/compose)
- [Swift UI](https://developer.apple.com/xcode/swiftui/)
- [React JS](https://react.dev/)
- [Vue JS](https://vuejs.org/)


### Imperative UI Implemntation

In imperative UI, you describe how to update the UI by giving explicit instructions for each change. The developer is responsible for managing the UI state and changes.


```python


import gi

gi.require_version('Gtk', '3.0')

from gi.repository import Gtk


class HexCalculator(Gtk.Grid):

    CSS = """
    label {
        color: #f61100;
        font-size: 1.2em
    }
    """
   
    def __init__(self, *args, **kwds):
        """
        docstring
        """

        super().__init__(*args, **kwds)
        self.convert_from = 10
        self.convert_to = 16
        self.convert_from_str = "Decimal"
        self.convert_to_str = "Hexadecimal"       
        self.entry = Gtk.Entry()
        self.entry.set_placeholder_text("Enter a number")
        combo1_store = Gtk.ListStore(int, str)
        combo2_store = Gtk.ListStore(int, str)
        base_num = 1

        combo1_store.append([10, "Decimal"])
        combo2_store.append([10, "Decimal"])

       
        for base in ["Binary","Octal","Hexadecimal"]:
            # print(2**base_num)
            combo1_store.append([2**base_num, base])
            combo2_store.append([2**base_num, base])
            if(base_num == 1):
                base_num = base_num + 1
            base_num = base_num + 1

        self.button = Gtk.Button.new_with_label("Convert")
        self.label = Gtk.Label(label="")
        self._style_prov = Gtk.CssProvider()
        style_context = self.label.get_style_context()
        style_context.add_provider(self._style_prov, 999)
        s= HexCalculator.CSS.strip()


        self._style_prov.load_from_data( bytes(s, "utf8"))
        self.combo1 = Gtk.ComboBox.new_with_model_and_entry(combo1_store)
        self.combo2 = Gtk.ComboBox.new_with_model_and_entry(combo2_store)
        self.combo1.set_entry_text_column(1)
        self.combo1.set_active(0)
        self.combo2.set_entry_text_column(1)
        self.combo2.set_active(3)   
        self.combo1.connect("changed", self.on_combo1_changed)
        self.combo2.connect("changed", self.on_combo2_changed)
        self.button.connect("clicked", self.convert_to_num)
        self.set_row_spacing(6)
        self.set_margin_start(10)
        self.set_margin_end(10)
        self.attach(self.entry, 0, 0,1,1)
        self.attach(self.combo1, 0, 1,1,1)
        self.attach(self.combo2, 0, 2,1,1)
        self.attach(self.button, 0, 3,1,1)
        self.attach(self.label, 0, 4,1,1)


    def on_combo1_changed(self, combo):
        tree_iter = combo.get_active_iter()
        if tree_iter is not None:
            model = combo.get_model()
            row_id, name = model[tree_iter][:2]
            self.convert_from_str = name
            self.convert_from = row_id
            # print("Selected: ID=%d, name=%s" % (row_id, name))


    def on_combo2_changed(self, combo):
        tree_iter = combo.get_active_iter()
        if tree_iter is not None:
            model = combo.get_model()
            row_id, name = model[tree_iter][:2]
            self.convert_to_str = name
            self.convert_to = row_id
            # print("Selected: ID=%d, name=%s" % (row_id, name))


    def convert_to_num(self, button=None):
        text = self.entry.get_text()
        if(len(text) == 0):
            return
        num=0
        try:
            num = int(text, self.convert_from)
        except ValueError as err:
            self.label.set_label(str(err))
            return

        self.entry.set_text(HexCalculator.convert(self.convert_to, num))
        self.label.set_label("")

    @staticmethod
    def convert(to, num):
        ans = ""
        hex_array = ['F', 'E', 'D', 'C', 'B', 'A']
        _num = int(num)
        # print("num: ",to)
        while (_num >= 1):
            m = _num % to
            
            if((to == 16) and (m > 9) ):

                mod = hex_array[15 - m]
            else: mod = str(m)
            # # print("m: ",m)
            ans =  str(mod) + ans
            _num = int(_num / to)
            
        return ans

```

The above snippet of code is an example of a user interface implemented in a imperative using the [pyGTK framework](https://pypi.org/project/PyGTK/). Notice how the UI is **"declared"** and the updates to the UI are handled **explicitly** by the code

- The program creates a couple of UI elements and keeps references to them.
- The program also declares a couple of what we call event listeners to capture user triggered events
- Based on the input provided to the program through the combox inputs when the convert button is clicked the program converts the inputed number to its hexadecimal equivalent and updates the UI explicitly to display that.



We can discern a couple of characteristics of **Imperative UI** from the code snippet

- **Direct Manipulation**: You manually update the DOM, widgets, or UI elements in response to user actions or system events.
    - This can be very suitable for simple UIs or cases where fine-grained control is essential
    - This opens the door more to bugs or crashes

- **Step-by-Step Instructions**: Focuses on the sequence of operations and implements ui this way.

- **Fine-Grained Control**: You have near total control over performance and behavior of the program.
    - This can lead to a more optimized performance
    - This can also become cumbersome and error-prone for complex UIs



##### Examples of Imperative UI frameworks

- [UIKit](https://developer.apple.com/documentation/uikit/)
- [Android XML and Java](https://developer.android.com/develop/ui/views/layout/declaring-layout#java)
- [Vanilla JavaScript with JQuery DOM Manipulation](https://jquery.com/)
- [pyGTK framework](https://pypi.org/project/PyGTK/)