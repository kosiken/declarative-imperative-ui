//
//  ContentView.swift
//  declarative-app
//
//  Created by Kosy on 20/11/2024.
//

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
                Text(isRunning ? "Stop" : "starkt")
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
