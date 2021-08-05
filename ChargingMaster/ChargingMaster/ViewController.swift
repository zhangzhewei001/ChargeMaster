//
//  ViewController.swift
//  ChargingMaster
//
//  Created by 张哲炜 on 2021/8/5.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var batteryLevelLbl: UILabel!
    @IBOutlet weak var bateryStateImgView: UIImageView!
    
    @IBOutlet weak var autoGradientView: AutoGradientView!
    var audioPlayer = AudioPlayer()
    var resourceName: String?
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeBattery()
        autoGradientView.alpha = 0
        resourceName = segmentControl.titleForSegment(at: self.segmentControl.selectedSegmentIndex)
        
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        resourceName = segmentControl.titleForSegment(at: self.segmentControl.selectedSegmentIndex)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if BatteryManager.shared.battery.value.state == .charging || BatteryManager.shared.battery.value.state == .full {
            loadAndPlay()
            setGradientViewAnimation(alpha: 1)
        }
    }
    
    func setGradientViewAnimation(alpha: Float) {
        UIView.animate(withDuration: 0.3) {
            self.autoGradientView.alpha = CGFloat(alpha)
        }
    }
    
    func observeBattery() {
        BatteryManager.shared.battery.observe(on: self) { battery in
            var image: UIImage?
            let text: String = battery.level == -1 ? "Unknown" : "\(Int(battery.level * 100))%"
        
            switch battery.state {
            case .charging:
                image = UIImage.init(systemName: "battery.100.bolt")
                image?.withTintColor(.green)
                self.loadAndPlay()
                self.setGradientViewAnimation(alpha: 1)
            case .full:
                image = UIImage.init(systemName: "battery.100.bolt")
                image?.withTintColor(.green)
                self.loadAndPlay()
                self.setGradientViewAnimation(alpha: 1)
            case .unplugged:
                image = self.imageWithUnplugged()
                self.setGradientViewAnimation(alpha: 0)
            case .unknown:
                image = UIImage.init(systemName: "bolt.fill.batteryblock")
                image?.withTintColor(.red)
            @unknown default:
                break
            }
            
            DispatchQueue.main.async {
                self.bateryStateImgView.image = image
                self.batteryLevelLbl.text = text
            }
        }
    }
    
    func loadAndPlay() {
        audioPlayer.loadAudio(forResource: resourceName ?? "SpongeBob", ofType: "mp3")
        self.audioPlayer.play()
    }
    
    func imageWithUnplugged() -> UIImage {
        let batteryLevel = BatteryManager.shared.battery.value.level
        var image: UIImage!
        
        if batteryLevel.isLess(than: 0.1) {
            image = UIImage.init(systemName: "battery.0")
            image?.withTintColor(.red)
            return image
        }
        
        if batteryLevel.isLess(than: 0.25) {
            image = UIImage.init(systemName: "battery.25")
            image.withTintColor(.yellow)
            return image
        }
        
        image = UIImage.init(systemName: "battery.100")
        image.withTintColor(.green)
        
        return image
    }

}

