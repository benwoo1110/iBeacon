//
//  ViewController.swift
//  Broadcast iBeacon
//
//  Created by Ben Woo on 30/11/18.
//  Copyright © 2018 Ben Woo. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    
    @IBOutlet weak var majorNum: UITextField!
    @IBOutlet weak var minorNum: UITextField!
    @IBOutlet weak var btnBroadcast: UIButton!
    @IBOutlet weak var broadcastStatus: UILabel!
    @IBOutlet weak var bluetoothStatus: UILabel!
    
    let uuid = NSUUID(uuidString: "F34A1A1F-500F-48FB-AFAA-9584D641D7B1")
    var beaconRegion: CLBeaconRegion!
    var bluetoothPeripheralManager: CBPeripheralManager!
    var isBroadcasting = false
    var dataDictionary = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        btnBroadcast.layer.cornerRadius = btnBroadcast.frame.size.width / 2
        
        bluetoothPeripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        var statusMessage = ""
        
        switch peripheral.state {
        case .poweredOn: statusMessage = "Bluetooth Status: Turned On"
            
        case .poweredOff:
            if isBroadcasting { broadcastBtn(self) }
            statusMessage = "Bluetooth Status: Turned Off"
            
        case .resetting: statusMessage = "Bluetooth Status: Resetting"
            
        case .unauthorized: statusMessage = "Bluetooth Status: Not Authorized"
            
        case .unsupported: statusMessage = "Bluetooth Status: Not Supported"
            
        default: statusMessage = "Bluetooth Status: Unknown"
        }
        
        bluetoothStatus.text = statusMessage
    }
    
    @IBAction func broadcastBtn(_ sender: AnyObject) {
        if majorNum.text == "" || minorNum.text == "" {
            return
        }
        
        if !isBroadcasting {
            if bluetoothPeripheralManager.state == .poweredOn {
                let major: CLBeaconMajorValue = UInt16(majorNum.text!)!
                let minor: CLBeaconMinorValue = UInt16(minorNum.text!)!
                beaconRegion = CLBeaconRegion(proximityUUID: uuid! as UUID, major: major, minor: minor, identifier: "com.test.ben")
                dataDictionary = beaconRegion.peripheralData(withMeasuredPower: -60)
                bluetoothPeripheralManager.startAdvertising((dataDictionary as! [String : Any]))
                
                btnBroadcast.setTitle("Stop", for: .normal)
                broadcastStatus.text = "Broadcasting..."
                
                majorNum.isEnabled = false
                minorNum.isEnabled = false
                
                isBroadcasting = true
            }
        }
        else {
            bluetoothPeripheralManager.stopAdvertising()
            
            btnBroadcast.setTitle("Start", for: .normal)
            broadcastStatus.text = "Stopped"
            
            majorNum.isEnabled = true
            minorNum.isEnabled = true
            
            isBroadcasting = false
        }
    }
}
    


