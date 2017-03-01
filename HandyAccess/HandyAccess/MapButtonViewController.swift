//
//  ButtonViewController.swift
//  HandyAccess
//
//  Created by Edward Anchundia on 2/18/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import UIKit
import SnapKit
import Speech
import Mapbox

class MapButtonViewController: UIViewController, SFSpeechRecognizerDelegate, UIScrollViewDelegate {
    
    private var mapView:MapViewController?
    public func setMapController(map1: MapViewController) {
        mapView = map1
    }
    class MyCustomPointAnnotation: MGLPointAnnotation {
        var willUseImage: Bool = false
    }
    var wheelMapLocationsArr = [WheelMapLocations]()
    let data = [WheelMapLocations]()
    let color = ColorScheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color._50
        
        setupViewHierarchy()
        setupView()
    }
    
    // MARK: SFSpeechRecognizerDelegate
    
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        
        view.addSubview(blur)
        view.addSubview(mitiButtonContainer)
        
        mitiButtonContainer.addSubview(button1)
        mitiButtonContainer.addSubview(button2)
        mitiButtonContainer.addSubview(button3)
        mitiButtonContainer.addSubview(button4)
        mitiButtonContainer.addSubview(button5)
        mitiButtonContainer.addSubview(button6)
        mitiButtonContainer.addSubview(button7)
        mitiButtonContainer.addSubview(button8)
        mitiButtonContainer.addSubview(button9)
        mitiButtonContainer.addSubview(button10)
    }
    
    func setupView() {
        blur.snp.makeConstraints({ (view) in
            view.top.bottom.trailing.leading.equalToSuperview()
        })
        mitiButtonContainerSetup()
    }
    
//    func buttonPressed(button: UIButton) {
////        switch button {
//            //        case speechButtonForContainer:
//        //            print("Speech Button pressed")
////        case clickButtonsForContainer:
////            print("Want buttons")
////            fadeOutView(view: speechOrButtonContainer, hidden: true)
////            fadeInView(view: resourcesOrNearBy, hidden: true)
////        case resoucesButton:
////            fadeOutView(view: resourcesOrNearBy, hidden: true)
////            fadeInView(view: boroughContainer, hidden: true)
////            fadeInView(view: resourcesScrollView, hidden: true)
////        case mapResoucesButton:
////            fadeOutView(view: resourcesOrNearBy, hidden: true)
////            fadeInView(view: mitiButtonContainer, hidden: true)
////        default:
////            break
////        }
//    }
    
    func mitiButtonContainerSetup() {
        mitiButtonContainer.snp.makeConstraints({ (view) in
            view.center.equalToSuperview()
            view.width.equalToSuperview().multipliedBy(0.9)
            view.height.equalToSuperview().multipliedBy(0.8)
        })
        //mitiButtonContainer.isHidden = true
        
        button1.snp.makeConstraints({ (view) in
            view.top.equalToSuperview().offset(50)
            view.leading.equalTo(20)
            view.width.equalToSuperview().multipliedBy(0.40)
            view.height.equalToSuperview().multipliedBy(0.1)
            //view.width.equalTo(150)
            //view.height.equalTo(70)
        })
        
        button2.snp.makeConstraints({ (view) in
            view.top.equalToSuperview().offset(50)
            view.trailing.equalToSuperview().inset(20)
            view.width.equalToSuperview().multipliedBy(0.40)
            view.height.equalToSuperview().multipliedBy(0.1)
            //view.width.equalTo(150)
            //view.height.equalTo(70)
        })
        
        button3.snp.makeConstraints({ (view) in
            view.top.equalTo(button1.snp.bottom).offset(30)
            view.leading.equalTo(20)
            view.width.equalToSuperview().multipliedBy(0.40)
            view.height.equalToSuperview().multipliedBy(0.1)
            //view.width.equalTo(150)
            //view.height.equalTo(70)
        })
        
        button4.snp.makeConstraints({ (view) in
            view.top.equalTo(button2.snp.bottom).offset(30)
            view.trailing.equalToSuperview().inset(20)
            view.width.equalToSuperview().multipliedBy(0.40)
            view.height.equalToSuperview().multipliedBy(0.1)
            //view.width.equalTo(150)
            //view.height.equalTo(70)
        })
        
        button5.snp.makeConstraints({ (view) in
            view.top.equalTo(button3.snp.bottom).offset(30)
            view.leading.equalTo(20)
            view.width.equalToSuperview().multipliedBy(0.40)
            view.height.equalToSuperview().multipliedBy(0.1)
            //view.width.equalTo(150)
            //view.height.equalTo(70)
        })
        
        button6.snp.makeConstraints({ (view) in
            view.top.equalTo(button4.snp.bottom).offset(30)
            view.trailing.equalToSuperview().inset(20)
            view.width.equalToSuperview().multipliedBy(0.40)
            view.height.equalToSuperview().multipliedBy(0.1)
            //view.width.equalTo(150)
            //view.height.equalTo(70)
        })
        
        button7.snp.makeConstraints({ (view) in
            view.top.equalTo(button5.snp.bottom).offset(30)
            view.leading.equalTo(20)
            view.width.equalToSuperview().multipliedBy(0.40)
            view.height.equalToSuperview().multipliedBy(0.1)
            //view.width.equalTo(150)
            //view.height.equalTo(70)
        })
        
        button8.snp.makeConstraints({ (view) in
            view.top.equalTo(button6.snp.bottom).offset(30)
            view.trailing.equalToSuperview().inset(20)
            view.width.equalToSuperview().multipliedBy(0.40)
            view.height.equalToSuperview().multipliedBy(0.1)
            //view.width.equalTo(150)
            //view.height.equalTo(70)
        })
        
        button9.snp.makeConstraints({ (view) in
            view.top.equalTo(button7.snp.bottom).offset(30)
            view.leading.equalTo(20)
            view.width.equalToSuperview().multipliedBy(0.40)
            view.height.equalToSuperview().multipliedBy(0.1)
            //view.width.equalTo(150)
            //view.height.equalTo(70)
        })
        
        button10.snp.makeConstraints({ (view) in
            view.top.equalTo(button8.snp.bottom).offset(30)
            view.trailing.equalToSuperview().inset(20)
            view.width.equalToSuperview().multipliedBy(0.40)
            view.height.equalToSuperview().multipliedBy(0.1)
            //view.width.equalTo(150)
            //view.height.equalTo(70)
        })
    }
    
    func buttonPressed(button: UIButton) {
        
        var categoryName = ""
        
        if button == button1 {
            print("button 1")
           categoryName = "food"

        } else if button == button2 {
            print("button 2")
            categoryName = "PublicTransport"

        } else if button == button3 {
            print("button 3")
            categoryName = "Health"

        } else if button == button4 {
            print("button 4")
            categoryName = "Government"

        } else if button == button5 {
            print("button 5")
            categoryName = "Bank/PostOffice"

        } else if button == button6 {
            print("button 6")
            categoryName = "Education"

        } else if button == button7 {
            print("button 7")
            categoryName = "Leisure"

        } else if button == button8 {
            print("button 8")
            categoryName = "food"

        } else if button == button9 {
            print("button 9")
            categoryName = "food"
            
        } else if button == button10 {
            print("button 10")
            categoryName = "food"
        }

        //baseendpoint
        //var endpoint = "http://wheelmap.org/api/categories/\(categoryNum)/node_types?&per_page=6"
        let c = self.mapView!.getmapbounds() as MGLCoordinateBounds

        var endpoint = "http://wheelmap.org/en/api/nodes/search?q=\(categoryName)&bbox=\(c.ne.longitude),\(c.ne.latitude),\(c.sw.longitude),\(c.sw.latitude)&per_page=10"
        print(endpoint)

        //make api call with endpoint
        //update an array for objects
        WheelMapManager.manager.getData(endpoint: endpoint) {(allData: [WheelMapLocations]?) in
            //guard let allData = allData else {return}

            if allData != nil {
                self.mapView!.refresh(object1: (allData)!)
                //self.navigationController?.pushViewController(self.mapView!, animated: true)
                self.dismiss(animated: true, completion: nil)
            } else {
                print("None There")
            }




//            dump(allData)
//            DispatchQueue.main.async {
//                MapViewController().reloadInputViews()
//            }

        }
        //dismiss after
        //dismiss(animated: true, completion: nil)
    }
    
    //MARK: ANIMATION
    func fadeOutView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 1.0, options: .transitionCrossDissolve, animations: {() -> Void in
            view.isHidden = true
        }, completion: { _ in })
    }
    
    func fadeInView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 1.0, options: .transitionCrossDissolve, animations: {() -> Void in
            view.isHidden = false
        }, completion: { _ in })
    }
    
    //MARK: THIRD CONTAINER PART 1 - MITTIS MAP BUTTONS
    
    internal lazy var mitiButtonContainer: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.blue
        return view
    }()
    
    internal lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle("Food", for: .normal)
        //button.backgroundColor = UIColor.gray
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle("Public Transport", for: .normal)
        //button.backgroundColor = UIColor.gray
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button3: UIButton = {
        let button = UIButton()
        button.setTitle("Health", for: .normal)
        //button.backgroundColor = UIColor.gray
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button4: UIButton = {
        let button = UIButton()
        button.setTitle("Government", for: .normal)
        //button.backgroundColor = UIColor.gray
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button5: UIButton = {
        let button = UIButton()
        button.setTitle("Banks", for: .normal)
        //button.backgroundColor = UIColor.gray
        //        button.backgroundColor?.withAlphaComponent(0.5)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button6: UIButton = {
        let button = UIButton()
        button.setTitle("Education", for: .normal)
        //button.backgroundColor = UIColor.gray
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button7: UIButton = {
        let button = UIButton()
        button.setTitle("Leisure", for: .normal)
        //button.backgroundColor = UIColor.gray
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button8: UIButton = {
        let button = UIButton()
        button.setTitle("Shopping", for: .normal)
        //button.backgroundColor = UIColor.gray
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button9: UIButton = {
        let button = UIButton()
        button.setTitle("Sport", for: .normal)
        //button.backgroundColor = UIColor.gray
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button10: UIButton = {
        let button = UIButton()
        button.setTitle("Tourism", for: .normal)
        //button.backgroundColor = UIColor.gray
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: THIRD CONTAINER PART 2 - BOROUGH AND RESOURCES
    internal lazy var boroughContainer: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.brown
        return view
    }()
    
    internal lazy var boroughLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose a borough..."
        return label
    }()
    
    internal lazy var queensButton: UIButton = {
        let button = UIButton()
        button.setTitle("Queens", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var brooklynButton: UIButton = {
        let button = UIButton()
        button.setTitle("Brooklyn", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var bronxButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bronx", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        //        button.backgroundColor?.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var statenIslandButton: UIButton = {
        let button = UIButton()
        button.setTitle("Staten Island", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var manhattanButton: UIButton = {
        let button = UIButton()
        button.setTitle("Manhattan", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var allButton: UIButton = {
        let button = UIButton()
        button.setTitle("All", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var blur: UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffectStyle.light)
        var blurEffectView = UIVisualEffectView(effect: blur)
        return blurEffectView
    }()
}
