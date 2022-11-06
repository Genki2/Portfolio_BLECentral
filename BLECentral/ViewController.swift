//
//  ViewController.swift
//  BLECentral
//
//  Created by GENKIFUJIMOTO on 2022/11/06.
//

import UIKit

import UIKit
import CoreBluetooth

class ViewController: UIViewController,CBCentralManagerDelegate {
    
    // BLE
    var centralManager: CBCentralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CBCentralManagerを初期化
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    //=======================
    //MARK: CoreBluetooth
    //=======================
    
    //1-1　Bluetooth状態確認
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        let service = CBUUID(string: "01000001-9da6-39a1-ab4d-172b698fe6c2")
        
        //1-2 サービス指定してCoreBluetoothを起動
        centralManager.scanForPeripherals(withServices: [service], options: nil)
    }
    
    //1-3 Peripheral探索結果の受信
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print(advertisementData["kCBAdvDataLocalName"])
        
        if let kCBAdvDataLocalName = advertisementData["kCBAdvDataLocalName"] {
            
            let title = kCBAdvDataLocalName as! String
            print(title)
            
            let alert = UIAlertController(title: title, message: "受信しました", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            
            //スキャン停止
            centralManager.stopScan()
            
            //1秒後停止
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                //再度検索開始
                self.centralManager = CBCentralManager(delegate: self, queue: nil)
            }
            
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }

}

