//
//  ImagePicker.swift
//  Podpishis
//
//  Created by Анастасия Зубехина on 23.12.2019.
//  Copyright © 2019 Zirkel. All rights reserved.
//

import UIKit

protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}

public class ImagePicker: NSObject {

    private let imagePicker: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        imagePicker = UIImagePickerController()
        super.init()
        self.presentationController = presentationController
        self.delegate = delegate
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = ["public.image"]
    }
    
    public func present() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if let cameraAction = action(for: .camera, title: "Сделать снимок") {
            alertController.addAction(cameraAction)
        }
        if let photoLibraryAction = action(for: .photoLibrary, title: "Фото") {
            alertController.addAction(photoLibraryAction)
        }
        alertController.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        presentationController?.present(alertController, animated: true)
    }
    
    public func openPicker(by type: UIImagePickerController.SourceType) {
        imagePicker.sourceType = type
        presentationController?.present(imagePicker, animated: true)
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { (_) in
            self.imagePicker.sourceType = type
            self.presentationController?.present(self.imagePicker, animated: true)
        }
    }
    
    private func dismissPickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        delegate?.didSelect(image: image)
    }
}

// MARK: - UIImagePickerControllerDelegate -
extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissPickerController(picker, didSelect: nil)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return dismissPickerController(picker, didSelect: nil)
        }
        dismissPickerController(picker, didSelect: image)
    }
}
