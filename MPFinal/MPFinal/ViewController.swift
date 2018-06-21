//
//  ViewController.swift
//  MPFinal
//
//  Created by 陳映紅 on 2018/6/7.
//  Copyright © 2018年 陳映紅. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var stepView: UIView!
    @IBOutlet weak var lastPageButton: UIButton!
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var colorImage: UIImageView!
    @IBOutlet weak var instruction: UILabel!
    
    let instructionList: [String] = ["", "暈染在左眼窩", "暈染在右眼窩",
                                     "暈染在左眼皮", "暈染在右眼皮",
                                     "上色於左眼摺", "上色於右眼摺",
                                     "暈染在左眼頭", "暈染在右眼頭",
                                     "暈染在左眼尾", "暈染在右眼尾",
                                     "上色於左眼頭", "上色於右眼頭",
                                     "上色於左眼尾", "上色於右眼尾",
                                     "上在左眼皮中央", "上在右眼皮中央",
                                     "上色於左下眼皮", "上色於右下眼皮",
                                     "上色於左下眼尾", "上色於右下眼尾",
                                     "找到眉頭", "找到眉峰", "找到眉尾",
                                     "加上眼線和睫\n毛膏就完成囉",
                                     "將所有點連線\n上色就完成囉"]
    
    var id: Int = 0
    var stepCount: Int = 0
    var step: [Int] = []
    var color: [Int] = []
    var current: Int = 0
    var instructIndex: [Int] = []
    var eyeSide: [Int] = []
    
    var faceNode: SCNNode?
    var ballNode: [SCNNode] = []
    var lineNodes: [SCNNode] = []
    
    var leftEyeStart: SCNVector3 = SCNVector3Zero
    var leftEyeEnd: SCNVector3 = SCNVector3Zero
    var leftNose: SCNVector3 = SCNVector3Zero
    var rightEyeStart: SCNVector3 = SCNVector3Zero
    var rightEyeEnd: SCNVector3 = SCNVector3Zero
    var rightNose: SCNVector3 = SCNVector3Zero
    
    var anchor1: SCNVector3 = SCNVector3Zero
    var anchor2: SCNVector3 = SCNVector3Zero
    var shift1: SCNVector3 = SCNVector3Zero
    var shift2: SCNVector3 = SCNVector3Zero
    var control1: SCNVector3 = SCNVector3Zero
    var control2: SCNVector3 = SCNVector3Zero
    var height: Float = 0
    
    var currentType: Int = 1
    var currentEye: Int = 1
    
    // for testing
    var selectedControlPoint: Int = 1
    var additionalHeight: Float = 0
    var additionalShift1: SCNVector3 = SCNVector3Zero
    var additionalShift2: SCNVector3 = SCNVector3Zero
    
    let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initParam(id: id)
        stepView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        if (id == 0) {
            colorImage.image = UIImage(named: "eyebrowColor")
            colorImage.contentMode = .scaleAspectFit
        } else {
            colorImage.image = UIImage(named: "color" + String(id) + "_" + String(color[current]))
            colorImage.contentMode = .scaleAspectFit
        }
        
        currentType = step[current]
        
        instruction.text = instructionList[instructIndex[current]]
        instruction.textAlignment = .center
        
        lastPageButton.setImage(UIImage(named: "lastPage"), for: UIControlState.normal)
        lastPageButton.imageView?.contentMode = .scaleAspectFit
        lastPageButton.addTarget(self, action: #selector(lastStep), for: .touchUpInside)
        
        nextPageButton.setImage(UIImage(named: "nextPage"), for: UIControlState.normal)
        nextPageButton.imageView?.contentMode = .scaleAspectFit
        nextPageButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
    }
    
    func initParam(id: Int) {
        switch id {
        case 0:
            stepCount = 4
            step = [11, 12, 13, 0]
            instructIndex = [21, 22, 23, 25]
        case 1:
            stepCount = 13
            step = [1, 1, 5, 5, 10, 10, 6, 6, 10, 10, 8, 8, 0]
            color = [1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 1, 1, 0]
            eyeSide = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0]
            instructIndex = [1, 2, 9, 10, 19, 20, 11, 12, 19, 20, 15, 16, 24]
        case 2:
            stepCount = 21
            step = [1, 1, 2, 2, 4, 4, 5, 5, 4, 4, 5, 5, 10, 10, 10, 10, 8, 8, 9, 9, 0]
            color = [1, 1, 2, 2, 4, 4, 4, 4, 5, 5, 5, 5, 3, 3, 4, 4, 6, 6, 6, 6, 0]
            eyeSide = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0]
            instructIndex = [1, 2, 3, 4, 7, 8, 9, 10, 7, 8, 9, 10, 19, 20, 19, 20, 15, 16, 17, 18, 24]
        case 3:
            stepCount = 15
            step = [1, 1, 5, 5, 2, 2, 8, 8, 7, 7, 9, 9, 10, 10, 0]
            color = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 3, 3, 5, 5, 0]
            eyeSide = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0]
            instructIndex = [1, 2, 9, 10, 3, 4, 15, 16, 13, 14, 17, 18, 19, 20, 24]
        default:
            stepCount = 0
        }
    }
    
    @objc func lastStep() {
        
        if (current > 0) { current -= 1 }
        
        if (id > 0) {
            if (step[current] > 0) {
                colorImage.isHidden = false
                colorImage.image = UIImage(named: "color" + String(id) + "_" +  String(color[current]))
            } else {
                colorImage.isHidden = true
            }
            
            currentEye = eyeSide[current]
        } else {
            if (step[current] > 0) {
                colorImage.isHidden = false
                colorImage.image = UIImage(named: "eyebrowColor")
            } else {
                colorImage.isHidden = true
            }
        }
        
        currentType = step[current]
        instruction.text = instructionList[instructIndex[current]]
        print(current)
    }
    
    @objc func nextStep() {
        if (current < stepCount - 1) { current += 1 }
        
        if (id > 0) {
            if (step[current] > 0) {
                colorImage.isHidden = false
                colorImage.image = UIImage(named: "color" + String(id) + "_" +  String(color[current]))
            } else {
                colorImage.isHidden = true
            }
            
            currentEye = eyeSide[current]
        } else {
            if (step[current] > 0) {
                colorImage.isHidden = false
                colorImage.image = UIImage(named: "eyebrowColor")
            } else {
                colorImage.isHidden = true
            }
        }
        
        currentType = step[current]
        instruction.text = instructionList[instructIndex[current]]
        print(current)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
         AR experiences typically involve moving the device without
         touch input for some time, so prevent auto screen dimming.
         */
        UIApplication.shared.isIdleTimerDisabled = true
        
        resetTracking()
    }
    
    func resetTracking() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        if (faceNode != nil){
            for child in faceNode!.childNodes {
                child.removeFromParentNode()
            }
        }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    

    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        faceNode = node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        leftEyeStart = SCNVector3(faceAnchor.geometry.vertices[1089])
        leftEyeEnd = SCNVector3(faceAnchor.geometry.vertices[1134])
        rightEyeStart = SCNVector3(faceAnchor.geometry.vertices[1168])
        rightEyeEnd = (SCNVector3(faceAnchor.geometry.vertices[1131]) + SCNVector3(faceAnchor.geometry.vertices[1132]))/2
        leftNose = SCNVector3(faceAnchor.geometry.vertices[140]) + SCNVector3(-0.001, 0, 0)
        rightNose = SCNVector3(faceAnchor.geometry.vertices[760])
        
        for nodes in lineNodes {
            nodes.removeFromParentNode()
        }
        lineNodes = []
        drawLineOnNode(node: node, anchor: faceAnchor, type: currentType, eye: currentEye)
    }
    
    func drawLineOnNode(node: SCNNode, anchor: ARFaceAnchor, type: Int, eye: Int) {
        if (type == 0) {
            return
        }
        guard let eyeBlinkRight = anchor.blendShapes[.eyeBlinkLeft] as? Float,
            let eyeBlinkLeft = anchor.blendShapes[.eyeBlinkRight] as? Float
            else { return }
        if (type <= 3 || type == 9) {
            switch type {
            case 1:
                height = 0.015
                shift1 = SCNVector3(0, 0.012, 0)
                shift2 = SCNVector3(0.005, 0, 0)
            case 2:
                height = 0.01
                shift1 = SCNVector3(0, 0.008, 0)
                shift2 = SCNVector3(0.004, 0, 0)
            case 3:
                height = 0.005
                shift1 = SCNVector3(0, 0.004, 0)
                shift2 = SCNVector3(0.005, 0, 0)
            case 9:
                height = -0.004
                shift1 = SCNVector3(0, -0.002, 0)
                shift2 = SCNVector3(0.005, 0, 0)
            default:
                print("?")
            }
            
            height += additionalHeight
            shift1 = shift1 + additionalShift1
            shift2 = shift2 + additionalShift2
            
            // left
            if (eye == 1 && (eyeBlinkLeft > 0.5 || currentType == 9)) {
                let eyeStart = leftEyeStart
                let eyeEnd = leftEyeEnd
                let segment: Int = 6
                let eyeMid: SCNVector3 = (eyeStart + eyeEnd)/2 + SCNVector3(0, height, 0)
                anchor1 = eyeStart
                anchor2 = eyeMid
                if(type == 9) {
                    anchor2 = anchor2 + SCNVector3(-0.002, 0, 0)
                }
                control1 = anchor1 + shift1
                control2 = anchor2 + shift2
                for i in 0..<segment {
                    let t1 = Float(i * 2) / Float(segment * 2)
                    let t2 = Float(i * 2 + 1) / Float(segment * 2)
                    let p1 = bezier(t: t1)
                    let p2 = bezier(t: t2)
                    let lineNode = createLine(from: p1, to: p2)
                    node.addChildNode(lineNode)
                    lineNodes.append(lineNode)
                }
                
                anchor1 = eyeMid
                anchor2 = eyeEnd
                if(type == 9) {
                    anchor1 = anchor1 + SCNVector3(-0.002, 0, 0)
                    anchor2 = anchor2 + SCNVector3(0, -0.001, 0)
                }
                control1 = anchor1 - shift2
                control2 = anchor2 + shift1
                for i in 0..<segment {
                    let t1 = Float(i * 2) / Float(segment * 2)
                    let t2 = Float(i * 2 + 1) / Float(segment * 2)
                    let p1 = bezier(t: t1)
                    let p2 = bezier(t: t2)
                    let lineNode = createLine(from: p1, to: p2)
                    node.addChildNode(lineNode)
                    lineNodes.append(lineNode)
                }
            }
            
            // right
            if (eye == 2 && (eyeBlinkRight > 0.5 || currentType == 9)) {
                let eyeStart = rightEyeStart
                let eyeEnd = rightEyeEnd
                let segment: Int = 6
                let eyeMid: SCNVector3 = (eyeStart + eyeEnd)/2 + SCNVector3(0, height, 0)
                anchor1 = eyeStart
                anchor2 = eyeMid
                if(type == 9) {
                    anchor2 = anchor2 + SCNVector3(0.002, 0, 0)
                }
                control1 = anchor1 + shift1
                control2 = anchor2 - shift2
                for i in 0..<segment {
                    let t1 = Float(i * 2) / Float(segment * 2)
                    let t2 = Float(i * 2 + 1) / Float(segment * 2)
                    let p1 = bezier(t: t1)
                    let p2 = bezier(t: t2)
                    let lineNode = createLine(from: p1, to: p2)
                    node.addChildNode(lineNode)
                    lineNodes.append(lineNode)
                }
                
                anchor1 = eyeMid
                anchor2 = eyeEnd
                if(type == 9) {
                    anchor1 = anchor1 + SCNVector3(0.002, 0, 0)
                    anchor2 = anchor2 + SCNVector3(0, -0.001, 0)
                }
                control1 = anchor1 + shift2
                control2 = anchor2 + shift1
                for i in 0..<segment {
                    let t1 = Float(i * 2) / Float(segment * 2)
                    let t2 = Float(i * 2 + 1) / Float(segment * 2)
                    let p1 = bezier(t: t1)
                    let p2 = bezier(t: t2)
                    let lineNode = createLine(from: p1, to: p2)
                    node.addChildNode(lineNode)
                    lineNodes.append(lineNode)
                }
            }
        } else if (type < 11) {
            if (eye == 1 && (eyeBlinkLeft > 0.5 || currentType == 10)) {
                var segment: Int = 8
                switch type {
                case 4:
                    anchor1 = leftEyeStart
                    anchor2 = leftEyeStart * Float(2.0/3) + leftEyeEnd * Float(1.0/3)
                    shift1 = SCNVector3(0, 0.016, 0)
                    shift2 = SCNVector3(0, 0.016, 0)
                case 5:
                    anchor1 = leftEyeStart * Float(1.0/3) + leftEyeEnd * Float(2.0/3)
                    anchor2 = leftEyeEnd
                    shift1 = SCNVector3(0.001, 0.014, 0)
                    shift2 = SCNVector3(0.002, 0.012, 0)
                case 6:
                    anchor1 = leftEyeStart
                    anchor2 = leftEyeStart * Float(2.0/3) + leftEyeEnd * Float(1.0/3)
                    shift1 = SCNVector3(-0.001, 0.009, 0)
                    shift2 = SCNVector3(-0.003, 0.007, 0)
                    segment = 6
                case 7:
                    anchor1 = leftEyeStart * Float(1.0/3) + leftEyeEnd * Float(2.0/3)
                    anchor2 = leftEyeEnd
                    shift1 = SCNVector3(0.003, 0.008, 0)
                    shift2 = SCNVector3(0.003, 0.006, 0)
                    segment = 6
                case 8:
                    anchor1 = leftEyeStart * Float(2.0/3) + leftEyeEnd * Float(1.0/3)
                    anchor2 = leftEyeStart * Float(1.0/3) + leftEyeEnd * Float(2.0/3) + SCNVector3(0, -0.003, 0)
                    shift1 = SCNVector3(0.001, 0.016, 0)
                    shift2 = SCNVector3(-0.001, 0.016, 0)
                case 10:
                    anchor1 = leftEyeStart * Float(1.0/3) + leftEyeEnd * Float(2.0/3) + SCNVector3(0, -0.002, 0)
                    anchor2 = leftEyeEnd + SCNVector3(0, -0.001, 0)
                    shift1 = SCNVector3(0.001, -0.006, 0)
                    shift2 = SCNVector3(0, -0.002, 0)
                    segment = 5
                default:
                    print("?")
                }
                shift1 = shift1 + additionalShift1
                shift2 = shift2 + additionalShift2
                control1 = anchor1 + shift1
                control2 = anchor2 + shift2
                for i in 0..<segment {
                    let t1 = Float(i * 2) / Float(segment * 2)
                    let t2 = Float(i * 2 + 1) / Float(segment * 2)
                    let p1 = bezier(t: t1)
                    let p2 = bezier(t: t2)
                    let lineNode = createLine(from: p1, to: p2)
                    node.addChildNode(lineNode)
                    lineNodes.append(lineNode)
                }
            }
            if (eye == 2 && (eyeBlinkRight > 0.5 || currentType == 10)) {
                var segment: Int = 8
                switch type {
                case 4:
                    anchor1 = rightEyeStart
                    anchor2 = rightEyeStart * Float(2.0/3) + rightEyeEnd * Float(1.0/3)
                    shift1 = SCNVector3(0, 0.016, 0)
                    shift2 = SCNVector3(0, 0.016, 0)
                case 5:
                    anchor1 = rightEyeStart * Float(1.0/3) + rightEyeEnd * Float(2.0/3)
                    anchor2 = rightEyeEnd
                    shift1 = SCNVector3(-0.001, 0.014, 0)
                    shift2 = SCNVector3(-0.002, 0.012, 0)
                case 6:
                    anchor1 = rightEyeStart
                    anchor2 = rightEyeStart * Float(2.0/3) + rightEyeEnd * Float(1.0/3)
                    shift1 = SCNVector3(0.001, 0.009, 0)
                    shift2 = SCNVector3(0.003, 0.007, 0)
                    segment = 6
                case 7:
                    anchor1 = rightEyeStart * Float(1.0/3) + rightEyeEnd * Float(2.0/3)
                    anchor2 = rightEyeEnd
                    shift1 = SCNVector3(-0.003, 0.008, 0)
                    shift2 = SCNVector3(-0.003, 0.006, 0)
                    segment = 6
                case 8:
                    anchor1 = rightEyeStart * Float(2.0/3) + rightEyeEnd * Float(1.0/3)
                    anchor2 = rightEyeStart * Float(1.0/3) + rightEyeEnd * Float(2.0/3) + SCNVector3(0, -0.003, 0)
                    shift1 = SCNVector3(-0.001, 0.016, 0)
                    shift2 = SCNVector3(0.001, 0.016, 0)
                case 10:
                    anchor1 = rightEyeStart * Float(1.0/3) + rightEyeEnd * Float(2.0/3) + SCNVector3(0, -0.002, 0)
                    anchor2 = rightEyeEnd + SCNVector3(0, -0.001, 0)
                    shift1 = SCNVector3(-0.001, -0.006, 0)
                    shift2 = SCNVector3(0, -0.002, 0)
                    segment = 5
                default:
                    print("?")
                }
                shift1 = shift1 + additionalShift1
                shift2 = shift2 + additionalShift2
                control1 = anchor1 + shift1
                control2 = anchor2 + shift2
                for i in 0..<segment {
                    let t1 = Float(i * 2) / Float(segment * 2)
                    let t2 = Float(i * 2 + 1) / Float(segment * 2)
                    let p1 = bezier(t: t1)
                    let p2 = bezier(t: t2)
                    let lineNode = createLine(from: p1, to: p2)
                    node.addChildNode(lineNode)
                    lineNodes.append(lineNode)
                }
            }
        } else {
            // left eyebrow
            anchor1 = leftNose
            switch type {
            case 11:
                let length: Float = 0.08
                let direction: SCNVector3 = (leftEyeStart - leftNose).normalized()
                anchor2 = leftNose + direction * length
            case 12:
                let length: Float = 0.1
                let mid: SCNVector3 = (leftEyeStart + leftEyeEnd) / 2 + SCNVector3(-0.003, 0, 0) + additionalShift1
                let direction: SCNVector3 = (mid - leftNose).normalized()
                anchor2 = leftNose + direction * length
            case 13:
                let length: Float = 0.09
                let adjustedEyeEnd: SCNVector3 = leftEyeEnd + SCNVector3(0.006, 0, 0) + additionalShift1
                let direction: SCNVector3 = (adjustedEyeEnd - leftNose).normalized()
                anchor2 = leftNose + direction * length
            default:
                print("?")
            }
            let segment: Int = 12
            for i in 0..<segment {
                let t1 = Float(i * 2) / Float(segment * 2)
                let t2 = Float(i * 2 + 1) / Float(segment * 2)
                let p1 = anchor1 * (1 - t1) + anchor2 * t1
                let p2 = anchor1 * (1 - t2) + anchor2 * t2
                let lineNode = createLine(from: p1, to: p2)
                node.addChildNode(lineNode)
                lineNodes.append(lineNode)
            }
            
            // right eyebrow
            anchor1 = rightNose
            switch type {
            case 11:
                let length: Float = 0.08
                let direction: SCNVector3 = (rightEyeStart - rightNose).normalized()
                anchor2 = rightNose + direction * length
            case 12:
                let length: Float = 0.1
                let mid: SCNVector3 = (rightEyeStart + rightEyeEnd) / 2 + SCNVector3(0.003, 0, 0) + additionalShift1
                let direction: SCNVector3 = (mid - rightNose).normalized()
                anchor2 = rightNose + direction * length
            case 13:
                let length: Float = 0.09
                let adjustedEyeEnd: SCNVector3 = rightEyeEnd + SCNVector3(-0.006, 0, 0) + additionalShift1
                let direction: SCNVector3 = (adjustedEyeEnd - rightNose).normalized()
                anchor2 = rightNose + direction * length
            default:
                print("?")
            }
            for i in 0..<segment {
                let t1 = Float(i * 2) / Float(segment * 2)
                let t2 = Float(i * 2 + 1) / Float(segment * 2)
                let p1 = anchor1 * (1 - t1) + anchor2 * t1
                let p2 = anchor1 * (1 - t2) + anchor2 * t2
                let lineNode = createLine(from: p1, to: p2)
                node.addChildNode(lineNode)
                lineNodes.append(lineNode)
            }
        }
    }
    
    func createLine(from p1: SCNVector3, to p2: SCNVector3) -> SCNNode {
        let direction = p2 - p1
        let line = SCNCylinder.init(radius: 0.0003, height: CGFloat(direction.length()))
        line.firstMaterial?.diffuse.contents = UIColor.white
        let lineNode = SCNNode(geometry: line)
        lineNode.position = (p1 + p2) / 2
        lineNode.eulerAngles = SCNVector3.lineEulerAngles(vector: direction)
        return lineNode
    }
    
    func bezier(t: Float) -> SCNVector3 {
        let points: [SCNVector3] = [anchor1, control1, control2, anchor2]
        
        var accumulatedPoint = SCNVector3Zero
        
        let n = 3
        for i in 0...n {
            var value = pow(1 - t, Float(n - i)) * pow(t, Float(i))
            if (i == 1 || i == 2){
                value *= 3
            }
            accumulatedPoint.x += value * points[i].x
            accumulatedPoint.y += value * points[i].y
            accumulatedPoint.z += value * points[i].z
        }
        
        return accumulatedPoint
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
