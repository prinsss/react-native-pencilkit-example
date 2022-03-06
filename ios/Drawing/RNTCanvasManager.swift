//
//  RNTCanvasManager.swift
//  Drawing
//
//  Created by Prin S. on 2022/3/6.
//

import UIKit
import PencilKit

@available(iOS 14.0, *)
@objc(RNTCanvasManager)
class RNTCanvasManager: RCTViewManager {
  var drawingData = Data()
  var drawingChanged: (Data) -> Void = {_ in}

  lazy var canvas: PKCanvasView = {
    let view = PKCanvasView()
    view.drawingPolicy = .anyInput
    view.minimumZoomScale = 1
    view.maximumZoomScale = 1
    view.translatesAutoresizingMaskIntoConstraints = false
    view.delegate = self
    return view
  }()

  lazy var toolPicker: PKToolPicker = {
    let toolPicker = PKToolPicker()
    return toolPicker
  }()

  @objc
  func setDrawingData(_ base64: String,
                      resolver resolve: RCTPromiseResolveBlock,
                      rejecter reject: RCTPromiseRejectBlock) {
    print("setDrawingData", base64)

    if (base64 == "") {
      self.canvas.drawing = PKDrawing()
      print("Drawing cleared")
      resolve(true)
      return
    }

    guard let dataDecoded = Data(base64Encoded: base64) else {
      reject("E_DECODING", "Error while decoding", nil);
      return
    }

    do {
      self.canvas.drawing = try PKDrawing.init(data: dataDecoded)
      print("New drawing loaded")
      resolve(true)
    } catch {
      reject("E_DRAWING_INIT", "Error while loading drawing object", nil);
    }
  }

  @objc
  func getDrawingData(_ resolve: RCTPromiseResolveBlock,
                      rejecter reject: RCTPromiseRejectBlock) {
    print("getDrawingData", drawingData)
    resolve(drawingData.base64EncodedString())
  }

  @objc
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }

  override func view() -> UIView! {
    toolPicker.setVisible(true, forFirstResponder: canvas)
    toolPicker.addObserver(canvas)

    drawingChanged = { data in
      self.drawingData = data
      print("drawingData updated")
    }

    // if let drawing = try? PKDrawing(data: drawingData) {
    //   canvas.drawing = drawing
    // }

    return canvas
  }
}

// MARK: Canvas View Delegate
@available(iOS 14.0, *)
extension RNTCanvasManager: PKCanvasViewDelegate, PKToolPickerObserver {

  func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
    print("canvasViewDrawingDidChange")
    drawingChanged(canvasView.drawing.dataRepresentation())
  }

  func toolPickerSelectedToolDidChange(_ toolPicker: PKToolPicker) {
    print("toolPickerSelectedToolDidChange")
  }

  func toolPickerIsRulerActiveDidChange(_ toolPicker: PKToolPicker) {
    print("toolPickerIsRulerActiveDidChange")
  }

  func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
    print("toolPickerVisibilityDidChange")
  }

  func toolPickerFramesObscuredDidChange(_ toolPicker: PKToolPicker) {
    print("toolPickerFramesObscuredDidChange")
  }
}
