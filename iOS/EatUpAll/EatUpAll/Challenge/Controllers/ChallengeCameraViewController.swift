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
    private var backCamera: AVCaptureDevice?
    private var frontCamera: AVCaptureDevice?
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
        configurePreviewViewController()
        configureCaptureSession()
        configureDevice()
        configureInputOutput()
        configurePreviewLayer()
        startRunningCaptureSession()
    }
    
    private func configureCaptureSession() {
        captureSession.sessionPreset = .photo
    }
    
    private func configureDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .back)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == .back {
                backCamera = device
            } else if device.position == .front {
                frontCamera = device
            }
        }
        currentCamera = backCamera
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
            print(error)
        }
    }
    
    private func configurePreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        backgroundView.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    private func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    private func configurePreviewViewController() {
        previewViewController = ChallengePreviewViewController.loadFromNib()
    }
}
