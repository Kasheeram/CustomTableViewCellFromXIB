//
//  AddPostViewController.swift
//  CustomTableViewCellFromXIB
//
//  Created by Apogee on 9/26/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

protocol MyProtocol {
    func setResultOfBusinessLogic(valueSent: [String])
}

class AddPostViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate {
    @IBOutlet weak var categoryTxtField: UITextField!
    @IBOutlet weak var titalTxtField: UITextField!
    @IBOutlet weak var descTxtView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var plushButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var lowButton: UIButton!
    var labelButton:UIBarButtonItem?
    var myProtocol:MyProtocol?
    
    let category = ["General","OBC","SC","ST"]
    var priority:String?
    var image:String?
    var picker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        descTxtView.delegate = self
        descTxtView.text = "Description (max 128) character"
        descTxtView.textColor = UIColor.lightGray
        
        labelButton = UIBarButtonItem()
        labelButton?.tintColor = UIColor.black
        submitButton.addTarget(self, action: #selector(AddPostViewController.submitData), for: .touchUpInside)

        
        picker.delegate = self
        picker.dataSource = self
        self.categoryTxtField.inputView = picker
        pickerToolBar(textField:categoryTxtField)

        addLayertoTxtFieldAtBottom(txtField:categoryTxtField)
        addLayertoTxtFieldAtBottom(txtField:titalTxtField)
        submitButton.layer.cornerRadius = 10
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        plushButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        plushButton.layer.shadowRadius = 10.0
        plushButton.layer.cornerRadius = 35
        plushButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        plushButton.layer.shadowOpacity = 1.0
        plushButton.backgroundColor = UIColor.white
        plushButton.layer.masksToBounds = false
        
        let arrow = UIImageView(image: UIImage(named: "drop-down-arrow-a"))
        setImagetoTextField(arrow:arrow,textField:categoryTxtField)
        
        descTxtView!.layer.borderWidth = 1
        descTxtView!.layer.borderColor = UIColor.lightGray.cgColor
        
    // adding right image to barbutton item
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 35, height: 35) //CGRectMake(0, 0, 30, 30)
        let leftImageView = UIImageView(image: UIImage(named:"gandhi"))
        leftImageView.frame = CGRect(x: 0, y: 0, width: button.frame.width-5, height: button.frame.size.height-5)
        button.addSubview(leftImageView)
        
        button.imageView?.contentMode = .scaleAspectFill
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: button.frame.width - (button.imageView?.frame.width)!)
    // adding right image to barbutton item
        let rightImageView = UIImageView(image: UIImage(named:"drop"))
        rightImageView.tintColor = UIColor.blue
        let height = button.frame.height * 0.3
        let width = height
        let xPos = button.frame.width - width
        let yPos = (button.frame.height - height) / 1
        rightImageView.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        button.addSubview(rightImageView)
        leftImageView.layer.cornerRadius = 15
        leftImageView.layer.masksToBounds = true
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func addLayertoTxtFieldAtBottom(txtField:UITextField)
    {
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: txtField.frame.height - 1, width: txtField.frame.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        txtField.borderStyle = UITextBorderStyle.none
        txtField.layer.addSublayer(bottomLine)
    }
    
    func setImagetoTextField(arrow:UIImageView,textField:UITextField){
        if let size = arrow.image?.size {
            arrow.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 15.0, height: size.height)
        }
        arrow.contentMode = UIViewContentMode.center
        textField.rightView = arrow
        textField.rightViewMode = UITextFieldViewMode.always
        
    }
    @IBAction func plushButtonTapped(_ sender: Any) {
//        let storyBoard = UIStoryboard(name:"Main",bundle:nil);
//        let vcOBJ = storyBoard.instantiateViewController(withIdentifier: "UserInfoViewController") as! UserInfoViewController
//       // vcOBJ.image = "gandhi"
//        navigationController?.pushViewController(vcOBJ, animated: true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            categoryTxtField.text = category[0]
            return category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            categoryTxtField.text = category[row]
        labelButton?.title = category[row]
    }
    
    func pickerToolBar(textField:UITextField){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddPostViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddPostViewController.canclePicker))
        toolBar.setItems([cancelButton,spaceButton, labelButton! ,spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }

    func donePicker (sender:UIBarButtonItem)
    {
        view.endEditing(true)
    }
    func canclePicker (sender:UIBarButtonItem)
    {
        view.endEditing(true)
    }
    
    @IBAction func highButtonTapped(_ sender: Any) {
        priority = "High"
        highButton.setImage(UIImage(named: "radio_active.png"), for: .normal)
        mediumButton.setImage(UIImage(named: "radio_inactive.png"), for: .normal)
        lowButton.setImage(UIImage(named: "radio_inactive.png"), for: .normal)

    }
    
    @IBAction func lowButtonTapped(_ sender: Any) {
        priority = "Low"
        lowButton.setImage(UIImage(named: "radio_active.png"), for: .normal)
        mediumButton.setImage(UIImage(named: "radio_inactive.png"), for: .normal)
        highButton.setImage(UIImage(named: "radio_inactive.png"), for: .normal)
    }
    
    @IBAction func mediumButtonTapped(_ sender: Any) {
        priority = "Medium"
        mediumButton.setImage(UIImage(named: "radio_active.png"), for: .normal)
        highButton.setImage(UIImage(named: "radio_inactive.png"), for: .normal)
        lowButton.setImage(UIImage(named: "radio_inactive.png"), for: .normal)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descTxtView.textColor == UIColor.lightGray {
            descTxtView.text = nil
            descTxtView.textColor = UIColor.black
        }
    }
    
    func submitData(){
        let postData = [descTxtView.text,categoryTxtField.text,priority,titalTxtField.text]
        myProtocol?.setResultOfBusinessLogic(valueSent: postData as! [String])
        navigationController?.popViewController(animated: true)
    }
}