//
//  ChallengeCameraViewController.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/15.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit
import AVFoundation

final class ChallengeCameraViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    private var previewViewController: ChallengePreviewViewController!
    private var captureSession = AVCaptureSession()
    private var currentCamera: AVCaptureDevice!
    
    private var photoOutput: AVCapturePhotoOutput?
    
    private var cameraPreviewLayer: AVCaptureVideoPreviewLayer?

    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    @IBAction func cameraButtonDidTap(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    @IBAction func dismissButtonDidTap(_ sender: Any) {
        dismissController()
    }
    
    private func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- AVCapturePhotoCaptureDelegate

extension ChallengeCameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(
        _ output: AVCapturePhotoOutput,
        didFinishProcessingPhoto photo: AVCapturePhoto,
        error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            let capturedImage = UIImage(data: imageData)
            previewViewController.modalPresentationStyle = .fullScreen
            previewViewController.configureCapturedImage(capturedImage)
            present(previewViewController, animated: false, completion: nil)
        }
    }
}

// MARK:- Configuration

extension ChallengeCameraViewController {
    private func configure() {
        configureNavigationController()
        configurePreviewViewController()
        configureCaptureSession()
        configureDevice()
        guard currentCamera != nil else {
            dismissController()
            return
        }
        configureInputOutput()
        configurePreviewLayer()
        startRunningCaptureSession()
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureCaptureSession() {
        captureSession.sessionPreset = .photo
    }
    
    private func configureDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .back)
        guard let device = deviceDiscoverySession.devices.first else {
            dismissController()
            return
        }
        currentCamera = device
    }
    
    private func configureInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray(
                [AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])],
                completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            dismissController()
        }
    }
    
    private func configurePreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = view.frame
        backgroundView.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    private func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    private func configurePreviewViewController() {
        previewViewController = ChallengePreviewViewController.loadFromNib()
    }
}
