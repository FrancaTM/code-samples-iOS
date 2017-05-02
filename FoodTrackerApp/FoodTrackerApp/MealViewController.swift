//
//  MealViewController.swift
//  FoodTrackerApp
//
//  Created by Tulio Marcos Franca on 22/04/17.
//  Copyright © 2017 0neTech. All rights reserved.
//

// #X - Ordem no ciclo de vida da view controller

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var mealNameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    
    // #2
    override func viewWillAppear(_ animated: Bool) {
        os_log("viewWillAppear", log: OSLog.default, type: .debug)
        print(photoImageView.frame.size.width)
        print(photoImageView.frame.size.width / 2)
    }
    
    // #3 #5
    override func viewWillLayoutSubviews() {
        os_log("viewWillLayoutSubviews", log: OSLog.default, type: .debug)
        print(photoImageView.frame.size.width)
        print(photoImageView.frame.size.width / 2)
        
        layoutViewController()
    }
    
    // #4 #6
    override func viewDidLayoutSubviews() {
        os_log("viewDidLayoutSubviews", log: OSLog.default, type: .debug)
        print(photoImageView.frame.size.width)
        print(photoImageView.frame.size.width / 2)
    }
    
    // #7
    override func viewDidAppear(_ animated: Bool) {
        os_log("viewDidAppear", log: OSLog.default, type: .debug)
        print(photoImageView.frame.size.width)
        print(photoImageView.frame.size.width / 2)
    }
    
    // #1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        os_log("viewDidLoad", log: OSLog.default, type: .debug)
        print(photoImageView.frame.size.width)
        print(photoImageView.frame.size.width / 2)

        //layoutViewController()
        
        // Handle the text field’s user input through delegate callbacks.
        mealNameTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            mealNameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //mealNameLabel.text = textField.text
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = mealNameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating)
        
        
    }

    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        mealNameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: Private methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = mealNameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    // MARK: Layout
    private func layoutViewController() {
        photoImageView.layer.cornerRadius = photoImageView.frame.size.width / 2 //10
        //photoImageView.clipsToBounds = true // Clip to bounds in attributes inspector
        photoImageView.layer.borderWidth = 3
        photoImageView.layer.borderColor = UIColor.orange.cgColor
        
        mealNameTextField.layer.cornerRadius = mealNameTextField.frame.size.height / 2
        mealNameTextField.layer.borderWidth = 3
        mealNameTextField.layer.borderColor = UIColor.orange.cgColor
        
//        ratingControl.layer.cornerRadius = ratingControl.frame.size.height / 2
//        ratingControl.layer.borderWidth = 3
//        ratingControl.layer.borderColor = UIColor.orange.cgColor

    }
    
//    @IBAction func setDefaultLabelText(_ sender: UIButton) {
//        mealNameLabel.text = "Default Text"
//    }
}

