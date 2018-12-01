//
//  ViewController.swift
//  Receiving iBeacon
//
//  Created by Ben Woo on 30/11/18.
//  Copyright © 2018 Ben Woo. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var connectStatus: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var locationManager:CLLocationManager = CLLocationManager()
    var discoveredBeacons:[CLBeacon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveredBeacons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        cell.background.layer.cornerRadius = 20
        
        cell.major.text = "Major: " + String(discoveredBeacons[indexPath.row].major.intValue)
        cell.minor.text = "Minor: " + String(discoveredBeacons[indexPath.row].minor.intValue)
 
        
        let discoveredBeaconProcimity = discoveredBeacons[indexPath.row].proximity
        
        switch discoveredBeaconProcimity {
            
        case .immediate:
            cell.background.backgroundColor = .green
            cell.distance.text = "Distance: immediate"
            
        case .near:
            cell.background.backgroundColor = .orange
            cell.distance.text = "Distance: near"
            
        case .far:
            cell.background.backgroundColor = .red
            cell.distance.text = "Distance: far"
            
        case .unknown:
            cell.background.backgroundColor = .white
            cell.distance.text = "Distance: unknown"
        }

        return cell
    }
    
    func rangeBeacons() {
        
        let uuid = UUID(uuidString: "F34A1A1F-500F-48FB-AFAA-9584D641D7B1")
        let identifier = "com.test.ben"
        
        let region = CLBeaconRegion(proximityUUID: uuid!, identifier: identifier)
        
        locationManager.startRangingBeacons(in: region)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            rangeBeacons()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        discoveredBeacons = beacons
        
        if discoveredBeacons.count > 0 {
        connectStatus.text = "Connection status: connected"
        } else {
            connectStatus.text = "Connection status: no iBeacons in range"
        }
        
        tableView.reloadData()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        connectStatus.text = "Connection status: disconnected"
        print(error)
    }
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        connectStatus.text = "Connection status: disconnected"
        print(error)
    }
    
    func locationManager(manager: CLLocationManager!, rangingBeaconsDidFailForRegion region: CLBeaconRegion!, withError error: NSError!) {
        connectStatus.text = "Connection status: disconnected"
        print(error)
    }

}

