//
//  HLQRCodeScannerViewController.swift
//  Hexlink
//
//  Created by Yang Xi on 1/26/23.
//

import Foundation
import AVFoundation
import UIKit


class HLQRCodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureSessionSetupSuccess = setupVideoInit()
        
        let cornerRadius = 10.0
        let previewWidth = view.frame.width * 0.8
        let previewOriginX = view.frame.width * 0.1
        let previewOriginY = view.frame.midY - previewWidth / 2
        let previewFrame = CGRect(origin: CGPoint(x: previewOriginX, y: previewOriginY),
                                  size: CGSize(width: previewWidth, height: previewWidth))

        if (captureSessionSetupSuccess) {
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = previewFrame
            previewLayer.cornerRadius = cornerRadius
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)

            if (captureSession?.isRunning == false) {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.captureSession.startRunning()
                }
            }
        }

        connerBorderLayer(rect: previewFrame, radius: cornerRadius)

        view.layer.backgroundColor = CGColor(red: 160, green: 160, blue: 160, alpha: 0.5)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

//MARK: AVCaptureMetadataOutputObjectsDelegate
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }

        dismiss(animated: true)
    }

//MARK: Helper Methods
    
    func found(code: String) {
        print(code)
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    func setupVideoInit() -> Bool{
        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return false
        }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return false
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return false
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return false
        }
        return true
    }
    
    func connerBorderLayer(rect: CGRect, radius: CGFloat) {
        let path = UIBezierPath()
        let connerLength = rect.width / 5.0
        
//      bottom-right conner
//      bottom
        path.move(to: CGPoint(x: rect.maxX - radius, y: rect.maxY))
//      arch
        path.addLine(to: CGPoint(x: rect.maxX - radius - connerLength, y: rect.maxY))
        path.addArc(withCenter: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius),
                    radius: radius,
                    startAngle: CGFloat(90.0).toRadians(),
                    endAngle: CGFloat(0.0).toRadians(),
                    clockwise: false)
//      right
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY - radius - connerLength))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
        
//      bottom-left conner
//      bottom
        path.move(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + radius + connerLength, y: rect.maxY))
//      arch
        path.addArc(withCenter: CGPoint(x: rect.minX + radius, y: rect.maxY - radius),
                    radius: radius,
                    startAngle: CGFloat(90.0).toRadians(),
                    endAngle: CGFloat(180.0).toRadians(),
                    clockwise: true)
//      left
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY - radius - connerLength))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - radius))

        
//      top-left conner
//      top
        path.move(to: CGPoint(x: rect.minX + radius, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + radius + connerLength, y: rect.minY))
//      arch
        path.addArc(withCenter: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                    radius: radius,
                    startAngle: CGFloat(270.0).toRadians(),
                    endAngle: CGFloat(180.0).toRadians(),
                    clockwise: false)
//      left
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + radius + connerLength))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        
//      top-right conner
        
//      top
        path.move(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - radius - connerLength, y: rect.minY))
//      arch
        path.addArc(withCenter: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                    radius: radius,
                    startAngle: CGFloat(270.0).toRadians(),
                    endAngle: CGFloat(0.0).toRadians(),
                    clockwise: true)
//      right
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY + radius + connerLength))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + radius))
        
        let layer = CAShapeLayer()
        layer.lineWidth = 8;
        layer.path = path.cgPath;
        layer.strokeColor = UIColor(white: 1, alpha: 1).cgColor
        layer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(layer)
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
