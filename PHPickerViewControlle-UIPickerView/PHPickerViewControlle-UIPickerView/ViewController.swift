//
//  ViewController.swift
//  PHPickerViewControlle-UIPickerView
//
//  Created by Darya on 19.12.23.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, PHPickerViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
  
    @IBOutlet weak var imegeView: UIImageView!
    @IBOutlet weak var pikerView: UIPickerView!
    
    lazy var pHpicker: PHPickerViewController = {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 5
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        return picker
    }()
    
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pikerView.delegate = self
        pikerView.dataSource = self
        imegeView.contentMode = .scaleAspectFill
    }
    
    @IBAction func button (_ sender: UIButton) {
        present(pHpicker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let itemProviders = results.map { $0.itemProvider }
               for item in itemProviders {
                   item.loadObject(ofClass: UIImage.self) { image, error in
                       DispatchQueue.main.async {
                           if let image = image as? UIImage {
                               self.images.append(image)
                               self.pikerView.reloadComponent(0)
                               self.imegeView.image = self.images.first
                           }
                       }
                   }
               }
               
               picker.dismiss(animated: true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
    }
      
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return images.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
          let pickerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
          pickerImage.contentMode = .scaleAspectFill
          pickerImage.clipsToBounds = true
          pickerImage.image = images[row]
          return pickerImage
    }
  
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
          return 100
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
              imegeView.image = images[row]
    }
      
      
  }
