//
//  WIHomeViewController.swift
//  WeatherInfo
//
//  Created by Ganesan, Veeramani on 10/10/21.
//

import UIKit

class WIHomeViewController: UIViewController {
    
    @IBOutlet weak var weatherInfoTableView: UITableView?
    var locationWoeIdInfo = [(city: "Gothenburg", woeid: "890869"), (city: "Mountain View", woeid: "2455920"), (city: "Stockholm", woeid: "906057"), (city: "London", woeid: "44418"), (city: "New York", woeid: "2459115"), (city: "Berlin", woeid: "638242")]
    var locationUpdateInfo = [String: (loactionData: WILocationData?, lastUpdated: TimeInterval)]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWeatherTableView()
    }
}

extension WIHomeViewController {
    
    private func setupWeatherTableView() {
        weatherInfoTableView?.dataSource = self
        weatherInfoTableView?.delegate = self
    }
    
    private func refreshCell(_ cell: WITableViewCell, forRow row: Int) {
        let woeid = locationWoeIdInfo[row].woeid
        let city = locationWoeIdInfo[row].city
        if locationUpdateInfo[woeid] == nil {
            WILocationService.sharedLocationService.fetchData(forLocationWOEId: woeid) { [weak self] locationData in
                if let locationData = locationData, locationData.count > 2 {
                    self?.locationUpdateInfo[woeid] = (locationData[1], Date().timeIntervalSince1970)
                    self?.updateCell(cell, withData: locationData[1], forLocation: city)
                }
            }
        }
        else {
            if WILocationService.sharedLocationService.doRefersh(lastUpdated: locationUpdateInfo[woeid]?.lastUpdated) {
                WILocationService.sharedLocationService.fetchData(forLocationWOEId: woeid) { [weak self] locationData in
                    if let locationData = locationData, locationData.count > 2 {
                        self?.locationUpdateInfo[woeid] = (locationData[1], Date().timeIntervalSince1970)
                        self?.updateCell(cell, withData: locationData[1], forLocation: city)
                    }
                }
            }
            else {
                if let locationData = locationUpdateInfo[woeid]?.loactionData {
                    self.updateCell(cell, withData: locationData, forLocation: city)
                }
            }
        }
    }
    
    private func updateCell(_ cell: WITableViewCell, withData data: WILocationData, forLocation location: String) {
        let viewModel = WILocationDataViewModel(locationData: data)
        
        DispatchQueue.main.async {
            cell.cityLabel.text     = location
            cell.minLabel.text      = viewModel.minTemp
            cell.maxLabel.text      = viewModel.maxTemp
            cell.humLabel.text      = viewModel.humidity
            cell.windLabel.text     = viewModel.windSpeed
            cell.dateLabel.text     = viewModel.date
            cell.stateLabel.text    = viewModel.stateName
        }
        
        viewModel.loadStateImage { image in
            if let image = image {
                DispatchQueue.main.async { cell.stateImage.image = image }
            }
        }
    }
}

extension WIHomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationWoeIdInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "WITableViewCellId", for: indexPath) as! WITableViewCell
        refreshCell(tableViewCell, forRow: indexPath.row)
        return tableViewCell
    }
}

extension WIHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
