//
//  DetailViewController.swift
//  ForecastApp
//
//  Created by Hyung Jip Moon on 2017-05-23.
//  Copyright © 2017 leomoon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var receivedValue = [Weather]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let otherVC = FavoritesTableViewController()
        receivedValue = otherVC.favoritesStoreObject
        
        self.view.backgroundColor = .blue

        print(receivedValue)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
