//
//  InitialViewController.swift
//  HandyAccess
//
//  Created by Karen Fuentes on 2/19/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//



import UIKit
import Speech
import SnapKit
import AVFoundation



class InitialViewController: UIViewController, SFSpeechRecognizerDelegate {
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    var isFinal = false
    var isAlreadyPushed = false
    let color = ColorScheme()
    //var searchTerm = " "
    
    
    var level = 0
    
    let boroughsDict = ["Queens":"Queens",
                        "Brooklyn":"Brooklyn",
                        "Bronx":"Bronx",
                        "Manhatttan":"Manhattan",
                        "Staten Island":"Staten_island",
                        "All":"All" ]
    let catagoriesDict = ["aging" : "aging",
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
    var urlComponents = ["borough": "Queens", "category": "aging"]
    
    var textViewText = "" {
        didSet {
            let synthesizer = AVSpeechSynthesizer()
            let myUtterance = AVSpeechUtterance(string: self.textViewText)
            myUtterance.rate = 0.50
            myUtterance.pitchMultiplier = 1.0
            myUtterance.voice = AVSpeechSynthesisVoice.init(language: "en-US")
            synthesizer.speak(myUtterance)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        viewHiearchy()
        configureConstraints()
        self.view.backgroundColor = color._50
        recordButton.isEnabled = false
        self.textViewText = "Welcome to Easy Access. Tap the Red record button to give you local services or resources"
        self.textView.text = self.textViewText
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        speechRecognizer.delegate = self
        let synthesizer = AVSpeechSynthesizer()
        let myUtterance = AVSpeechUtterance(string: "Welcome to Easy Access. Tap the Red record button to give you local services or resources")
        myUtterance.rate = 0.50
        myUtterance.pitchMultiplier = 1.0
        myUtterance.voice = AVSpeechSynthesisVoice.init(language: "en-US")
        synthesizer.speak(myUtterance)
        
        self.recordButton.addTarget(self , action: #selector(recordButtonWasTapped), for: .touchUpInside)
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.recordButton.isEnabled = true
                    
                case .denied:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("User denied access to speech recognition", for: .disabled)
                    
                case .restricted:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("Speech recognition restricted on this device", for: .disabled)
                    
                case .notDetermined:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("Speech recognition not yet authorized", for: .disabled)
                }
            }
        }
    }
    
    func startRecording() throws {
        
        if let recognitionTask  = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else { fatalError("Audio engine has no input node") }
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        
        recognitionRequest.shouldReportPartialResults = true
        
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            self.isFinal = false
            //print("isFinal \(self.isFinal) after entering the speechRecognizer; suppose to be false")
            if let result = result {
                let results = result.bestTranscription.formattedString
                //self.textView.text = result.bestTranscription.formattedString
                self.isFinal = result.isFinal
                //print("\(self.isFinal) when do self.isFinal = result.isFinal")
                //if results == "Resources" || results == "Resource"{
                if (results.lowercased().contains("resources") || results.lowercased().contains("resource")) && self.level == 0 {
                    if self.isAlreadyPushed == false {
                        self.audioEngine.stop()
                        self.recognitionRequest?.endAudio()
                        self.recordButton.isEnabled = false
                        self.recordButton.setTitle("Stopping", for: .disabled)
                        self.isAlreadyPushed = true
                        self.level += 1
                        self.textViewText = "Okay, I got resources. Which borough's resources would you like? Queens, Brooklyn, Bronx, Manhattan, Staten Island or All?"
                        self.textView.text = self.textViewText
                    }
                
                //} else if results == "Local service" || results == "Local services" {
                } else if (results.lowercased().contains("local service") || results.lowercased().contains("local services")) && self.level == 0 {
                    if self.isAlreadyPushed == false {
                    self.navigationController?.pushViewController(MapViewController(), animated: true)
                        self.audioEngine.stop()
                        self.recognitionRequest?.endAudio()
                        self.recordButton.isEnabled = false
                        self.recordButton.setTitle("Stopping", for: .disabled)
                        self.isAlreadyPushed = true
                    }
                    
                } else if self.level == 1 && self.isAlreadyPushed == false {
                        let boroughsArr = [ "Queens",
                                            "Brooklyn",
                                            "Bronx",
                                            "Manhattan",
                                            "Staten Island",
                                            "All"]
                    for borough in boroughsArr {
                        if results.lowercased().contains(borough.lowercased()) {
                            self.urlComponents["borough"] = self.boroughsDict[borough]
                            dump(self.urlComponents)
                            self.level += 1
                            self.audioEngine.stop()
                            self.recognitionRequest?.endAudio()
                            self.recordButton.isEnabled = false
                            self.recordButton.setTitle("Stopping", for: .disabled)
                            self.isAlreadyPushed = true
                            self.textViewText = "Okay! I got \(borough). Which resources would you like? Aging, Counseling Support, Disabilities, Education, Health, Housing, Immigration, Job Training, Legal Services, Veterans, Victim Services or Youth Services?"
                            self.textView.text = self.textViewText
                        }
                    }
                } else if self.level == 2 && self.isAlreadyPushed == false {
                    let categoryArr = ["aging", "counseling support", "disabilities", "education", "health", "housing", "immigration", "job training", "legal services", "veterans", "victim services", "youth services"]
                    for category in categoryArr {
                        if results.lowercased().contains(category) {
                            self.urlComponents["category"] = self.catagoriesDict[category]
                            dump(self.urlComponents)
                            let socialServicesTableViewController = SocialServicesTableViewController()
                            socialServicesTableViewController.urlComponents = self.urlComponents
                            self.navigationController?.pushViewController(socialServicesTableViewController, animated: true)
                            self.audioEngine.stop()
                            self.recognitionRequest?.endAudio()
                            self.recordButton.isEnabled = false
                            self.recordButton.setTitle("Stopping", for: .disabled)
                            self.isAlreadyPushed = true
                        }
                    }
                }
            }
            self.recordButton.isEnabled = true
            //print("isFinal \(self.isFinal) after resetting record button to true, suppose to be true")
            
            if error != nil || self.isFinal == true {
                
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
                self.recordButton.setTitle("Start Recording", for: [])
            }
        }
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        try audioEngine.start()
        
        textView.text = self.textViewText + "(Go ahead, I'm listening)"
        textView.font = UIFont.systemFont(ofSize: 30.0)
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            recordButton.isEnabled = true
            recordButton.setTitle("Start Recording", for: [])
        } else {
            recordButton.isEnabled = false
            recordButton.setTitle("Recognition not available", for: .disabled)
        }
    }
    
    func viewHiearchy() {
        self.edgesForExtendedLayout = []
        self.view.addSubview(textView)
        self.view.addSubview(recordButton)
        //self.view.addSubview(textView)
        //self.view.addSubview(buttonContainer)
        //self.buttonContainer.addSubview(resourcesButton)
        //self.buttonContainer.addSubview(serviceButton)
    }
    
    func configureConstraints() {
        textView.snp.makeConstraints { (view) in
            view.top.leading.trailing.equalToSuperview()
            view.bottom.equalTo(self.recordButton.snp.top)
            //view.bottom.equalToSuperview().inset(50.0)
            
        }
        recordButton.snp.makeConstraints { (button) in
            button.leading.trailing.bottom.equalToSuperview()
            button.top.equalTo(textView.snp.bottom)
        }
        //textView.snp.makeConstraints { (view) in
        //    view.top.leading.trailing.equalToSuperview()
        //    view.bottom.equalToSuperview().inset(50.0)
        //
        //}
        //buttonContainer.snp.makeConstraints { (container) in
        //    container.top.bottom.leading.trailing.equalToSuperview()
        //}
        //resourcesButton.snp.makeConstraints { (button) in
        //    button.leading.trailing.top.equalToSuperview()
        //    button.height.equalToSuperview().multipliedBy(0.4)
        //}
        //serviceButton.snp.makeConstraints { (button) in
        //    button.leading.trailing.equalToSuperview()
        //    button.bottom.equalToSuperview().inset(8.0)
        //    button.height.equalToSuperview().multipliedBy(0.4)
        //}
        
    }
    
    // MARK: - Button Function
    
    func recordButtonWasTapped() {
        //print("I'm trapped")
        self.isAlreadyPushed = false
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            recordButton.setTitle("Stopping", for: .disabled)
        } else {
//            if self.level == 0 {
//                let synthesizer = AVSpeechSynthesizer()
//                let myUtterance = AVSpeechUtterance(string: self.textViewText)
//                myUtterance.rate = 0.50
//                myUtterance.pitchMultiplier = 1.0
//                myUtterance.voice = AVSpeechSynthesisVoice.init(language: "en-US")
//                synthesizer.speak(myUtterance)
//            } else if self.level == 1 {
//                let synthesizer = AVSpeechSynthesizer()
//                let myUtterance = AVSpeechUtterance(string: self.textViewText)
//                myUtterance.rate = 0.50
//                myUtterance.pitchMultiplier = 1.0
//                myUtterance.voice = AVSpeechSynthesisVoice.init(language: "en-US")
//                synthesizer.speak(myUtterance)
//            }
            
            try! startRecording()
            recordButton.setTitle("Stop recording", for: [])
        }
    }
    
    
    // MARK: -  UI Objects
    //lazy var siriSpeachLabel: UILabel = {
    //   let label = UILabel()
    //    label.numberOfLines = 0
    //    return label
    //}()
    
    lazy var textView: UITextView = {
        let text = UITextView()
        //text.backgroundColor = .blue
        //text.font = UIFont(name: "system", size: 40.0)
        text.font = UIFont.systemFont(ofSize: 28.0)
        text.backgroundColor = self.color._50
        text.isUserInteractionEnabled = false
        return text
    }()
    
    lazy var recordButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Start Recording", for: .normal)
        
        return button
        
    }()
    lazy var buttonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    lazy var serviceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Local Services", for: .normal)
        return button
        
    }()
    lazy var resourcesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Resouces", for: .normal)
        return button
        
    }()
    
}
