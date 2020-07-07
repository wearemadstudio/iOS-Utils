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

open class ImagePicker: NSObject {

    private let imagePicker: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    init(_ presentationController: UIViewController, _ delegate: ImagePickerDelegate) {
        imagePicker = UIImagePickerController()
        super.init()
        self.presentationController = presentationController
        self.delegate = delegate
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = ["public.image"]
    }
    
    func present(cameraTitle: String = "Camera", photoTitle: String = "Photo", cancelTitle: String = "Cancel") {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if let cameraAction = action(for: .camera, title: cameraTitle) {
            alertController.addAction(cameraAction)
        }
        if let photoLibraryAction = action(for: .photoLibrary, title: photoTitle) {
            alertController.addAction(photoLibraryAction)
        }
        alertController.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
        presentationController?.present(alertController, animated: true)
    }
    
    func openPicker(by type: UIImagePickerController.SourceType) {
        imagePicker.sourceType = type
        presentationController?.present(imagePicker, animated: true)
    }
    
    func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
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

// MARK: - UIImagePickerControllerDelegate
extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissPickerController(picker, didSelect: nil)
    }
        
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return dismissPickerController(picker, didSelect: nil)
        }
        dismissPickerController(picker, didSelect: image)
    }
}
