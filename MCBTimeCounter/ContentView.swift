//
//  ContentView.swift
//  MCBTimeCounter
//
//  Created by Marcius Bezerra on 02/06/23.
//

import SwiftUI
import Cocoa
import AVFoundation

// @NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    @Published var displayText = "00:00:00"
    
    var statusItem: NSStatusItem!
    var timer: Timer?
    var countdown: TimeInterval = 0
    let beepSound = NSSound(named: "BeepSound")
    var beepPlayed = false;

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Cria o item na barra superior
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem.button?.title = "00:00:00"
        statusItem.button?.target = self
        statusItem.button?.action = #selector(showMenu)

        // Cria o menu
        let menu = NSMenu()
        menu.addItem(withTitle: "Pausar/Continuar", action: #selector(toggleTimer), keyEquivalent: "")
        menu.addItem(withTitle: "15 minutos", action: #selector(setTime15), keyEquivalent: "")
        menu.addItem(withTitle: "30 minutos", action: #selector(setTime30), keyEquivalent: "")
        menu.addItem(withTitle: "45 minutos", action: #selector(setTime45), keyEquivalent: "")
        menu.addItem(withTitle: "60 minutos", action: #selector(setTime60), keyEquivalent: "")
        menu.addItem(withTitle: "120 minutos", action: #selector(setTime120), keyEquivalent: "")
        menu.addItem(withTitle: "+5 minutos", action: #selector(incrementTime5Min), keyEquivalent: "")
        menu.addItem(withTitle: "-5 minutos", action: #selector(decrementTime5Min), keyEquivalent: "")
        menu.addItem(withTitle: "Reiniciar", action: #selector(resetTimer), keyEquivalent: "")
        menu.addItem(withTitle: "Créditos", action: #selector(showCredits), keyEquivalent: "")
        menu.addItem(withTitle: "Sair", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        statusItem.menu = menu
    }
    
    @objc func showMenu() {
        // Implemente a lógica para mostrar um menu personalizado, se necessário
    }
    
    @objc func toggleTimer() {
        if timer == nil {
            startTimer()
        } else {
            pauseTimer()
        }
    }
    
    @objc func setTime15() {
        countdown = 15 * 60
        updateDisplay()
        pauseTimer()
        startTimer()
        beepPlayed = false
    }
    
    @objc func setTime30() {
        countdown = 30 * 60
        updateDisplay()
        pauseTimer()
        startTimer()
        beepPlayed = false
    }
    
    @objc func setTime45() {
        countdown = 45 * 60
        updateDisplay()
        pauseTimer()
        startTimer()
        beepPlayed = false
    }
    
    @objc func setTime60() {
        countdown = 60 * 60
        updateDisplay()
        pauseTimer()
        startTimer()
        beepPlayed = false
    }
    
    @objc func setTime120() {
        countdown = 120 * 60
        updateDisplay()
        pauseTimer()
        startTimer()
        beepPlayed = false
    }
    
    @objc func incrementTime5Min() {
        countdown += 5 * 60
        updateDisplay()
        beepPlayed = countdown <= 0
    }
    
    @objc func decrementTime5Min() {
        countdown -= 5 * 60
        beepPlayed = countdown <= 0
        updateDisplay()
    }
    
    @objc func resetTimer() {
        pauseTimer()
        countdown = 0
        beepPlayed = false
        updateDisplay()
    }
    
    func startTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.countdown <= 0 && !beepPlayed {
                self.playBeep()
            } else {
                self.countdown -= 1
                self.updateDisplay()
            }
        }
        
        updateDisplay()
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func playBeep() {
        for _ in 1...3 {
            beepSound?.stop()
            beepSound?.play()
            Thread.sleep(forTimeInterval: 1.0)
        }
        beepPlayed = true
    }
    
    func updateDisplay() {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        let formattedTime = formatter.string(from: abs(countdown))!
        
        statusItem.button?.title = formattedTime
        displayText = formattedTime
    }
    
    @objc func showCredits() {
        let alert = NSAlert()
        alert.messageText = "Créditos"
        alert.informativeText = "Marcius Bezerra (marciusbezerra@gmail.com) © 2023"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    

}

struct ContentView: View {
    @ObservedObject var appDelegate: AppDelegate

    var body: some View {
        VStack {
            Text(appDelegate.displayText)
                .padding()
                .font(.title)
                .minimumScaleFactor(0.5)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
 }
