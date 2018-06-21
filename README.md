# Makeup-ARtist
## Members
R06922025 林家緯

R06922033 陳映紅

## Introduction
Makeup novices often have trouble learning to do makeup with online sources. Inspired by video and web tutorials, we utilize ARKit to develop a makeup tutorial app, which draws auxiliary lines on user’s face. Through the front camera, users can easily apply makeup with the indication of regions and colors on the cell phone screen.

## Approach
We detect the specific points on the face with ARKit face tracking. Then, we draw auxiliary lines on user's face and show step-by-step instructions below. The implementation consists of two parts:
1. Detecting the specific points
    * We track the specific points on the face by finding associating vertices on the ARFaceGeometry.
2. Drawing auxiliary lines
    * Using Bézier curves, we draw smooth auxiliary lines in different shapes.

## Result
We implement tutorials for eyebrow and eyeshadow, including one kind of basic eyebrow and three kinds of different eyeshadows. After selecting the makeup they want, users would see the auxiliary lines and color on the cell phone screen.

## Screenshots
You can choose either eyebrow tutorial or eyeshadow tutorial when entering the app.
After choosing the eyebrow tutorial, the auxiliary lines of the begin, top and the end of your eyebrow will appear. Follow the guide to do your eyebrow.

<img src="https://github.com/c081215/Makeup-ARtist/blob/master/Screenshots/IMG_0511.PNG" width="200">  <img src="https://github.com/c081215/Makeup-ARtist/blob/master/Screenshots/IMG_0513.PNG" width="200">  <img src="https://github.com/c081215/Makeup-ARtist/blob/master/Screenshots/IMG_0515.PNG" width="200">

</br>

We implemented three types of eyeshadows as you can see in the list. Select the one that interested you, and then the eyeshadow guide will start.

<img src="https://github.com/c081215/Makeup-ARtist/blob/master/Screenshots/IMG_0511.PNG" width="200">  <img src="https://github.com/c081215/Makeup-ARtist/blob/master/Screenshots/IMG_0516.PNG" width="200">  <img src="https://github.com/c081215/Makeup-ARtist/blob/master/Screenshots/IMG_0517.PNG" width="200">  <img src="https://github.com/c081215/Makeup-ARtist/blob/master/Screenshots/IMG_0526.PNG" width="200">

## Link of the demo video
[https://drive.google.com/open?id=1jyGLZPSKZBgMY9Hau1Icf5KCbHqHSdmv](https://drive.google.com/open?id=1jyGLZPSKZBgMY9Hau1Icf5KCbHqHSdmv)
