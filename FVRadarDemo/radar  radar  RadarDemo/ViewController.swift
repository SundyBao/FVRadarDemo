//
//  ViewController.swift
//  radar  radar  RadarDemo
//
//  Created by james on 2017/12/15.
//  Copyright © 2017年 AiJiaSu Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var RaView : FVRadarView?
    
    @IBOutlet weak var radarView: FVRadarView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        RaView = FVRadarView(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
//        self.view.addSubview(RaView!)
    }

    @IBAction func onClick(_ sender: Any) {
        
        self.radarView.animationStart()
    }
    @IBAction func stopOnClick(_ sender: Any) {
        self.radarView.animationStop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

