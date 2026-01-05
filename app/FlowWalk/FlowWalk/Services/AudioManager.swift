import Foundation
import AVFoundation

actor AudioManager {
    private var queuePlayer: AVQueuePlayer?
    private var playerLooper: AVPlayerLooper?
    private let audioSession = AVAudioSession.sharedInstance()
    private var isPlaying = false
    
    init() {
        setupNotifications()
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            forName: AVAudioSession.interruptionNotification,
            object: audioSession,
            queue: nil
        ) { [weak self] notification in
            Task {
                await self?.handleInterruption(notification)
            }
        }
        
        NotificationCenter.default.addObserver(
            forName: AVAudioSession.routeChangeNotification,
            object: audioSession,
            queue: nil
        ) { [weak self] notification in
            Task {
                await self?.handleRouteChange(notification)
            }
        }
    }
    
    func configureAudioSession() async throws {
        do {
            try audioSession.setCategory(
                .playback,
                mode: .default,
                options: [.duckOthers, .allowBluetooth, .allowBluetoothA2DP]
            )
            try audioSession.setActive(true)
        } catch {
            print("Failed to configure audio session: \(error)")
            throw error
        }
    }
    
    func startMeditation432Hz() async throws {
        guard !isPlaying else { return }
        
        try await configureAudioSession()
        
        guard let audioURL = Bundle.main.url(forResource: "meditation_432hz", withExtension: "mp3") else {
            print("Audio file not found")
            throw AudioError.fileNotFound
        }
        
        let playerItem = AVPlayerItem(url: audioURL)
        queuePlayer = AVQueuePlayer(playerItem: playerItem)
        
        guard let queuePlayer = queuePlayer else {
            throw AudioError.playerInitializationFailed
        }
        
        // Use AVPlayerLooper for seamless looping
        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
        
        // Set initial volume
        queuePlayer.volume = 0.7
        
        // Start playback
        queuePlayer.play()
        isPlaying = true
        
        // Fade in
        await fadeVolume(to: 1.0, duration: 2.0)
    }
    
    func stopMeditation() async {
        guard isPlaying else { return }
        
        // Fade out before stopping
        await fadeVolume(to: 0.0, duration: 1.0)
        
        queuePlayer?.pause()
        queuePlayer = nil
        playerLooper = nil
        isPlaying = false
        
        // Deactivate audio session
        try? audioSession.setActive(false, options: .notifyOthersOnDeactivation)
    }
    
    func pauseMeditation() {
        queuePlayer?.pause()
    }
    
    func resumeMeditation() {
        queuePlayer?.play()
    }
    
    func adjustVolume(for zone: HeartRateZone.Zone) async {
        guard let queuePlayer = queuePlayer else { return }
        
        let targetVolume: Float = switch zone {
        case .optimal:
            1.0  // Full volume when in optimal zone
        case .belowTarget, .aboveTarget:
            0.7  // Slightly reduced volume when outside zone
        }
        
        await fadeVolume(to: targetVolume, duration: 0.5)
    }
    
    private func fadeVolume(to targetVolume: Float, duration: TimeInterval) async {
        guard let queuePlayer = queuePlayer else { return }
        
        let startVolume = queuePlayer.volume
        let volumeDelta = targetVolume - startVolume
        let steps = 20
        let stepDuration = duration / Double(steps)
        
        for step in 0...steps {
            let progress = Float(step) / Float(steps)
            queuePlayer.volume = startVolume + (volumeDelta * progress)
            
            if step < steps {
                try? await Task.sleep(nanoseconds: UInt64(stepDuration * 1_000_000_000))
            }
        }
    }
    
    private func handleInterruption(_ notification: Notification) async {
        guard let userInfo = notification.userInfo,
              let typeValue = userInfo[AVAudioSession.interruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
            return
        }
        
        switch type {
        case .began:
            // Interruption began (phone call, etc.)
            pauseMeditation()
        case .ended:
            // Interruption ended
            if let optionsValue = userInfo[AVAudioSession.interruptionOptionKey] as? UInt {
                let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
                if options.contains(.shouldResume) {
                    resumeMeditation()
                }
            }
        @unknown default:
            break
        }
    }
    
    private func handleRouteChange(_ notification: Notification) async {
        guard let userInfo = notification.userInfo,
              let reasonValue = userInfo[AVAudioSession.routeChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
            return
        }
        
        switch reason {
        case .oldDeviceUnavailable:
            // Headphones were unplugged, or Bluetooth device disconnected
            pauseMeditation()
        default:
            break
        }
    }
}

enum AudioError: LocalizedError {
    case fileNotFound
    case playerInitializationFailed
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Meditation audio file not found"
        case .playerInitializationFailed:
            return "Failed to initialize audio player"
        }
    }
}