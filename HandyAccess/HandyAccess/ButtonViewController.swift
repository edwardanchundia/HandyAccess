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

class ButtonViewController: UIViewController, SFSpeechRecognizerDelegate, UIScrollViewDelegate {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var mapView:MapViewController?

    public func setMapController(map1: MapViewController) {
        mapView = map1
    }
    
    class MyCustomPointAnnotation: MGLPointAnnotation {
        var willUseImage: Bool = false
    }
    var wheelMapLocationsArr = [WheelMapLocations]()

    var textSpoken = String()
    let data = [WheelMapLocations]()
    var effect: UIVisualEffect!

    let boroughsDict = ["Queens":"Queens",
                        "Brooklyn":"Brooklyn",
                        "Bronx":"Bronx",
                        "Manhatttan":"Manhattan",
                        "Staten Island":"Staten_island",
                        "All":"All" ]
    let categoriesDict = ["aging" : "aging",
                          "counseling support" : "counseling_support_groups",
                          "disabilities" : "disabilities",
                          "education" : "education",
                          "health" : "health",
                          "housing" : "housing",
                          "immigration" : "immigration",
                          "job training" : "employment_job_training",
                          "legal services" : "legal_services",
                          "veterans" : "veterans_military_families",
                          "victim services" : "victim_services",
                          "youth services" : "youth_services"]
    var urlComponents = ["borough": " ", "category": " "]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        view.backgroundColor = UIColor.black
//        view.alpha = 0.2
        
//        effect = self.blur.effect
//        blur.effect = self.effect
        
        //view.isOpaque = false
        setupViewHierarchy()
        setupView()
        
//        speechButton.isEnabled = false
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: Selector("filterButtonBarButtonPressed"))
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        speechRecognizer.delegate = self
//        effect = self.blur.effect
//        blur.effect = self.effect
//        SFSpeechRecognizer.requestAuthorization { authStatus in
//            /*
//             The callback may not be called on the main thread. Add an
//             operation to the main queue to update the record button's state.
//             */
//            OperationQueue.main.addOperation {
//                switch authStatus {
//                case .authorized:
//                    self.speechButton.isEnabled = true
//                case .denied:
//                    self.speechButton.isEnabled = false
//                    self.speechButton.setTitle("User denied access to speech recognition", for: .disabled)
//                case .restricted:
//                    self.speechButton.isEnabled = false
//                    self.speechButton.setTitle("Speech recognition restricted on this device", for: .disabled)
//                case .notDetermined:
//                    self.speechButton.isEnabled = false
//                    self.speechButton.setTitle("Speech recognition not yet authorized", for: .disabled)
//                }
//            }
//        }
//    }
    
    //private func filterButtonBarButtonPressed() {
    //    self.present(ButtonViewController(), animated: true, completion: nil)
    //}
    
//    private func startRecording() throws {
//        
//        // Cancel the previous task if it's running.
//        if let recognitionTask = recognitionTask {
//            recognitionTask.cancel()
//            self.recognitionTask = nil
//        }
//        
//        let audioSession = AVAudioSession.sharedInstance()
//        try audioSession.setCategory(AVAudioSessionCategoryRecord)
//        try audioSession.setMode(AVAudioSessionModeMeasurement)
//        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
//        
//        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//        
//        guard let inputNode = audioEngine.inputNode else { fatalError("Audio engine has no input node") }
//        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
//        
//        // Configure request so that results are returned before audio recording is finished
//        recognitionRequest.shouldReportPartialResults = true
//        
//        // A recognition task represents a speech recognition session.
//        // We keep a reference to the task so that it can be cancelled.
//        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
//            var isFinal = false
//            
//            if let result = result {
//                self.textSpoken = result.bestTranscription.formattedString
//                print("Speech: \(result.bestTranscription.formattedString)")
//                isFinal = result.isFinal
//            }
//            
//            if error != nil || isFinal {
//                self.audioEngine.stop()
//                inputNode.removeTap(onBus: 0)
//                
//                self.recognitionRequest = nil
//                self.recognitionTask = nil
//                
//                self.speechButton.isEnabled = true
//            }
//        }
//        
//        let recordingFormat = inputNode.outputFormat(forBus: 0)
//        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
//            self.recognitionRequest?.append(buffer)
//        }
//        
//        audioEngine.prepare()
//        
//        try audioEngine.start()
//        
////        textView.text = "(Go ahead, I'm listening)"
//    }
    
    // MARK: SFSpeechRecognizerDelegate
    
//    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
//        if available {
//            speechButton.isEnabled = true
//        } else {
//            speechButton.isEnabled = false
//        }
//    }
    
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        
        view.addSubview(blur)
//        view.addSubview(boroughContainer)
//        view.addSubview(speechOrButtonContainer)
//        view.addSubview(resourcesScrollView)
        
//        boroughContainer.addSubview(boroughLabel)
//        boroughContainer.addSubview(queensButton)
//        boroughContainer.addSubview(brooklynButton)
//        boroughContainer.addSubview(bronxButton)
//        boroughContainer.addSubview(statenIslandButton)
//        boroughContainer.addSubview(manhattanButton)
//        boroughContainer.addSubview(allButton)
//        
//        resourcesScrollView.addSubview(resourceLabel)
//        resourcesScrollView.addSubview(housingButton)
//        resourcesScrollView.addSubview(healthButton)
//        resourcesScrollView.addSubview(educationButton)
//        resourcesScrollView.addSubview(employmentButton)
//        resourcesScrollView.addSubview(verteransButton)
//        resourcesScrollView.addSubview(disabilitiesButton)
//        resourcesScrollView.addSubview(goButton)
//        
//        speechOrButtonContainer.addSubview(speechOrClickLabel)
//        speechOrButtonContainer.addSubview(speechButtonForContainer)
//        speechOrButtonContainer.addSubview(clickButtonsForContainer)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        view.addSubview(button5)
        view.addSubview(button6)
        view.addSubview(button7)
        view.addSubview(button8)
        view.addSubview(button9)
        view.addSubview(button10)
//        view.addSubview(speechButton)
    }
    
    func setupView() {
        blur.snp.makeConstraints({ (view) in
            view.top.bottom.trailing.leading.equalToSuperview()
        })
        
//        speechAndButtonContainer()
//        setupContrainers()
        
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
        
//        speechButton.snp.makeConstraints({ (view) in
//            view.bottom.equalToSuperview().inset(60)
//            view.centerX.equalToSuperview()
//            view.width.equalToSuperview().multipliedBy(0.2)
//            view.height.equalToSuperview().multipliedBy(0.1)
//        })
    }
    
//    func boroughButtonPressed(button: UIButton) {
//        guard let validButtonTitle = button.titleLabel?.text else { return }
//        guard let validBorough = self.boroughsDict[validButtonTitle] else { return }
//        self.urlComponents["borough"] = validBorough
//    }
//    
//    func resourcesCategoryButtonPressed(button: UIButton) {
//        guard let validResourcesCategoryTitle = button.titleLabel?.text else { return }
//        guard let validCategory = self.categoriesDict[validResourcesCategoryTitle.lowercased()] else { return }
//        self.urlComponents["category"] = validCategory
//    }
    
//    func goButtonPressed(button: UIButton) {
//        dump(self.urlComponents)
//        for (key, value) in self.urlComponents {
//            if value == " " {
//                let alertController = UIAlertController(title: "Opps!", message: "Please select a borough and a category", preferredStyle: .alert)
//                let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
//                alertController.addAction(okayAction)
//                self.present(alertController, animated: true, completion: nil)
//            }
//        }
//        dump(self.urlComponents)
//        let socialServicesTableViewController = SocialServicesTableViewController()
//        socialServicesTableViewController.urlComponents = self.urlComponents
//        self.navigationController?.pushViewController(socialServicesTableViewController, animated: true)
//    }
    
    func buttonPressed(button: UIButton) {
        
//        switch button {
//            //        case speechButtonForContainer:
//        //            print("Speech Button pressed")
//        case clickButtonsForContainer:
//            print("Want buttons")
//            fadeOutView(view: speechOrButtonContainer, hidden: true)
//            fadeInView(view: boroughContainer, hidden: true)
//            fadeInView(view: resourcesScrollView, hidden: true)
//        default:
//            break
//        }
        
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
            DispatchQueue.main.async {
                if allData != nil {
                    self.mapView!.refresh(object1: (allData)!)
//                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("None There")
                }
                
            }
            
            

//            dump(allData)
//            DispatchQueue.main.async {
//                MapViewController().reloadInputViews()
//            }
            
        }
        //dismiss after
        //dismiss(animated: true, completion: nil)
    }
    
    
//    func setupContrainers() {
//        self.edgesForExtendedLayout = []
//        
//        boroughContainer.snp.makeConstraints({ (view) in
//            view.top.equalTo(self.view.snp.top).offset(80)
//            view.centerX.equalToSuperview()
//            view.height.equalToSuperview().multipliedBy(0.4)
//            view.width.equalToSuperview().multipliedBy(0.9)
//        })
//        boroughContainer.isHidden = true
//        
//        boroughLabel.snp.makeConstraints({ (view) in
//            view.top.equalTo(boroughContainer.snp.top).offset(20)
//            view.centerX.equalTo(boroughContainer.snp.centerX)
//        })
//        
//        queensButton.snp.makeConstraints({ (view) in
//            view.leading.equalTo(boroughContainer.snp.leading).offset(20)
//            view.top.equalTo(boroughLabel.snp.bottom).offset(20)
//            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
//            view.height.equalTo(45)
//        })
//        
//        brooklynButton.snp.makeConstraints({ (view) in
//            view.leading.equalTo(boroughContainer.snp.leading).offset(20)
//            view.top.equalTo(queensButton.snp.bottom).offset(20)
//            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
//            view.height.equalTo(45)
//        })
//        
//        bronxButton.snp.makeConstraints({ (view) in
//            view.leading.equalTo(boroughContainer.snp.leading).offset(20)
//            view.top.equalTo(brooklynButton.snp.bottom).offset(20)
//            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
//            view.height.equalTo(45)
//        })
//        
//        statenIslandButton.snp.makeConstraints({ (view) in
//            view.trailing.equalTo(boroughContainer.snp.trailing).inset(20)
//            view.top.equalTo(boroughLabel.snp.bottom).offset(20)
//            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
//            view.height.equalTo(45)
//        })
//        
//        manhattanButton.snp.makeConstraints({ (view) in
//            view.trailing.equalTo(boroughContainer.snp.trailing).inset(20)
//            view.top.equalTo(statenIslandButton.snp.bottom).offset(20)
//            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
//            view.height.equalTo(45)
//        })
//        
//        allButton.snp.makeConstraints({ (view) in
//            view.trailing.equalTo(boroughContainer.snp.trailing).inset(20)
//            view.top.equalTo(manhattanButton.snp.bottom).offset(20)
//            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
//            view.height.equalTo(45)
//        })
//        
//        resourcesScrollView.snp.makeConstraints({ (view) in
//            view.top.equalTo(self.boroughContainer.snp.bottom).offset(10)
//            view.leading.equalTo(boroughContainer.snp.leading)
//            view.height.equalToSuperview().multipliedBy(0.4)
//            view.width.equalTo(1000)
//        })
//        resourcesScrollView.isHidden = true
//        
//        resourceLabel.snp.makeConstraints({ (view) in
//            view.top.equalTo(resourcesScrollView.snp.top).offset(20)
//            view.centerX.equalTo(boroughContainer.snp.centerX)
//        })
//        
//        employmentButton.snp.makeConstraints({ (view) in
//            view.leading.equalTo(boroughContainer.snp.leading).offset(20)
//            view.top.equalTo(resourceLabel.snp.bottom).offset(20)
//            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
//            view.height.equalTo(45)
//        })
//        
//        disabilitiesButton.snp.makeConstraints({ (view) in
//            view.leading.equalTo(boroughContainer.snp.leading).offset(20)
//            view.top.equalTo(employmentButton.snp.bottom).offset(20)
//            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
//            view.height.equalTo(45)
//        })
//        
//        housingButton.snp.makeConstraints({ (view) in
//            view.leading.equalTo(boroughContainer.snp.leading).offset(20)
//            view.top.equalTo(disabilitiesButton.snp.bottom).offset(20)
//            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
//            view.height.equalTo(45)
//        })
//        
//        educationButton.snp.makeConstraints({ (view) in
//            view.trailing.equalTo(boroughContainer.snp.trailing).inset(20)
//            view.top.equalTo(resourceLabel.snp.bottom).offset(20)
//            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
//            view.height.equalTo(45)
//        })
//        
//        verteransButton.snp.makeConstraints({ (view) in
//            view.trailing.equalTo(boroughContainer.snp.trailing).inset(20)
//            view.top.equalTo(educationButton.snp.bottom).offset(20)
//            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
//            view.height.equalTo(45)
//        })
//        
//        healthButton.snp.makeConstraints({ (view) in
//            view.trailing.equalTo(boroughContainer.snp.trailing).inset(20)
//            view.top.equalTo(verteransButton.snp.bottom).offset(20)
//            view.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
//            view.height.equalTo(45)
//        })
//        
//        goButton.snp.makeConstraints({(button) in
//            button.centerX.equalToSuperview()
//            button.top.equalTo(educationButton.snp.bottom).offset(20)
//            button.width.equalTo(boroughContainer.snp.width).multipliedBy(0.4)
//            button.height.equalTo(45)
//        })
//    }
    
    func speechAndButtonContainer() {
        speechOrButtonContainer.snp.makeConstraints({ (view) in
            view.center.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.3)
            view.width.equalToSuperview().multipliedBy(0.8)
        })
        
        speechOrClickLabel.snp.makeConstraints({ (view) in
            view.top.equalTo(speechOrButtonContainer.snp.top).offset(20)
            view.centerX.equalTo(speechOrButtonContainer.snp.centerX)
        })
        
        clickButtonsForContainer.snp.makeConstraints({ (view) in
            view.top.equalTo(speechOrClickLabel.snp.bottom).offset(20)
            view.width.equalTo(speechOrButtonContainer.snp.width).multipliedBy(0.8)
            view.centerX.equalTo(speechOrButtonContainer.snp.centerX)
            view.height.equalTo(45)
        })
        
        speechButtonForContainer.snp.makeConstraints({ (view) in
            view.top.equalTo(clickButtonsForContainer.snp.bottom).offset(20)
            view.width.equalTo(speechOrButtonContainer.snp.width).multipliedBy(0.8)
            view.centerX.equalTo(speechOrButtonContainer.snp.centerX)
            view.height.equalTo(45)
        })
    }
    
  
    
    
//    func speachButtonPressed() {
//        if audioEngine.isRunning {
//            audioEngine.stop()
//            recognitionRequest?.endAudio()
//            speechButton.isEnabled = false
//        } else {
//            try! startRecording()
//        }
//    }

    internal lazy var button1: UIButton = {
        let button = UIButton()
        button.setTitle("Food", for: .normal)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button2: UIButton = {
        let button = UIButton()
        button.setTitle("Public Transport", for: .normal)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button3: UIButton = {
        let button = UIButton()
        button.setTitle("Health", for: .normal)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button4: UIButton = {
        let button = UIButton()
        button.setTitle("Government", for: .normal)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button5: UIButton = {
        let button = UIButton()
        button.setTitle("Banks", for: .normal)
        button.backgroundColor = UIColor.gray
//        button.backgroundColor?.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button6: UIButton = {
        let button = UIButton()
        button.setTitle("Education", for: .normal)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button7: UIButton = {
        let button = UIButton()
        button.setTitle("Leisure", for: .normal)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button8: UIButton = {
        let button = UIButton()
        button.setTitle("Shopping", for: .normal)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button9: UIButton = {
        let button = UIButton()
        button.setTitle("Sport", for: .normal)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var button10: UIButton = {
        let button = UIButton()
        button.setTitle("Tourism", for: .normal)
        button.backgroundColor = UIColor.gray
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
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
    
//    internal lazy var speechButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Speak", for: .normal)
//        button.backgroundColor = UIColor.red
//        button.addTarget(self, action: #selector(speachButtonPressed), for: .touchUpInside)
//        return button
//    }()
    
    internal lazy var speechOrButtonContainer: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.brown
        return view
    }()
    
    internal lazy var speechOrClickLabel: UILabel = {
        let label = UILabel()
        label.text = "How would you like to navigate?"
        return label
    }()
    
    internal lazy var speechButtonForContainer: UIButton = {
        let button = UIButton()
        button.setTitle("Sound", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    internal lazy var clickButtonsForContainer: UIButton = {
        let button = UIButton()
        button.setTitle("Sight", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 0.8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
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
    
//    internal lazy var queensButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Queens", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.borderWidth = 0.8
//        button.addTarget(self, action: #selector(boroughButtonPressed), for: .touchUpInside)
//        return button
//    }()
//    
//    internal lazy var brooklynButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Brooklyn", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.borderWidth = 0.8
//        button.addTarget(self, action: #selector(boroughButtonPressed), for: .touchUpInside)
//        return button
//    }()
//    
//    internal lazy var bronxButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Bronx", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.borderWidth = 0.8
//        //        button.backgroundColor?.withAlphaComponent(0.5)
//        button.addTarget(self, action: #selector(boroughButtonPressed), for: .touchUpInside)
//        return button
//    }()
//    
//    internal lazy var statenIslandButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Staten Island", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.borderWidth = 0.8
//        button.addTarget(self, action: #selector(boroughButtonPressed), for: .touchUpInside)
//        return button
//    }()
//    
//    internal lazy var manhattanButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Manhattan", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.borderWidth = 0.8
//        button.addTarget(self, action: #selector(boroughButtonPressed), for: .touchUpInside)
//        return button
//    }()
    
//    internal lazy var allButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("All", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.borderWidth = 0.8
//        button.addTarget(self, action: #selector(boroughButtonPressed), for: .touchUpInside)
//        return button
//    }()
    
    internal lazy var resourcesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = true
        //        scrollView.gestureRecognizerShouldBegin(true)
        //scrollView.backgroundColor = UIColor.blue
        scrollView.delegate = self
        return scrollView
    }()
    
    internal lazy var resourceLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose Resource..."
        return label
    }()
    
//    internal lazy var housingButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Housing", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.borderWidth = 0.8
//        button.addTarget(self, action: #selector(resourcesCategoryButtonPressed), for: .touchUpInside)
//        return button
//    }()
//    
//    internal lazy var healthButton: UIButton = {
//        let button = UIButton()
//        //button.setTitle("Health", for: .normal)
//        button.setTitle("Go", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.borderWidth = 0.8
//        //button.addTarget(self, action: #selector(resourcesCategoryButtonPressed), for: .touchUpInside)
//        button.addTarget(self, action: #selector(goButtonPressed), for: .touchUpInside)
//        return button
//    }()
//    
//    internal lazy var educationButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Education", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.borderWidth = 0.8
//        button.addTarget(self, action: #selector(resourcesCategoryButtonPressed), for: .touchUpInside)
//        return button
//    }()
//    
//    internal lazy var employmentButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Employment", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.borderWidth = 0.8
//        button.addTarget(self, action: #selector(resourcesCategoryButtonPressed), for: .touchUpInside)
//        return button
//    }()
//    
//    internal lazy var verteransButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Veterans", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.borderWidth = 0.8
//        button.addTarget(self, action: #selector(resourcesCategoryButtonPressed), for: .touchUpInside)
//        return button
//    }()
//    
//    internal lazy var disabilitiesButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Disabilities", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.borderWidth = 0.8
//        button.addTarget(self, action: #selector(resourcesCategoryButtonPressed), for: .touchUpInside)
//        return button
//    }()
//    
//
//    internal lazy var goButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Go", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.layer.borderWidth = 0.8
//        button.addTarget(self, action: #selector(goButtonPressed), for: .touchUpInside)
//        return button
//    }()
    
//    internal lazy var speechButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Speak", for: .normal)
//        button.backgroundColor = UIColor.red
//        button.addTarget(self, action: #selector(speachButtonPressed), for: .touchUpInside)
//        return button
//    }()
    
    internal lazy var blur: UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffectStyle.light)
        var blurEffectView = UIVisualEffectView(effect: blur)
        return blurEffectView
    }()
}
