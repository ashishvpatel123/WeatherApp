//
//  ViewController.swift
//  WeatherApp
//
//  Created by IMCS2 on 2/16/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var textViewWeatherDetails: UITextView!

    @IBOutlet weak var cityTextLable: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "weatherData"))
        textViewWeatherDetails.text = ""

    }
    
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        
        let city = cityTextLable.text
        let updatedCityName = city?.replacingOccurrences(of: " ", with: "-")
        let lookForString = "</div></div></div>\(String(describing: city!)) Weather Forecast."
        print(city!)
        let myURLString = "https://www.weather-forecast.com/locations/"+updatedCityName!+"/forecasts/latest"
        guard let myURL = URL(string: myURLString) else {
            textViewWeatherDetails.text = "Error: \(city!) doesn't seem to be a valid city"
            return
        }

        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            //print("HTML : \(myHTMLString)")
            print(lookForString)
            let apartFrom = "<span class=\"read-more-small\""
            //<span class="read-more-small"><span class="read-more-content">
            let weatherDataString: [String] = myHTMLString.components(separatedBy: lookForString)
            print(weatherDataString[1])
            let finalDataToDisplay: [String] = weatherDataString[1].components(separatedBy: apartFrom)
            print("this is index \(finalDataToDisplay[0])")
            
            textViewWeatherDetails.text = "\(city!) Weather Forecast.\(finalDataToDisplay[0])"
        } catch let error {
            print("Error: \(error)")
        }
        

    }
    


}

