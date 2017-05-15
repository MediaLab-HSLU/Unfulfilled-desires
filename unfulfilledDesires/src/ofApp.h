#pragma once

#include "ofxiOS.h"
#include "ofxXmlSettings.h"
#include "ofxThreadedImage.h"
#define totImgs 10
class ofApp : public ofxiOSApp {
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);

    //loading
    bool loading;
    
    //images
    ofxThreadedImage imgs[totImgs];
    ofxXmlSettings XML;
    ofPoint headPts[totImgs];
    
    int pointCount;
    int lineCount;
    int lastTagNumber;
    
    int imageCounter;
    
    ofPoint touched;
    bool touchedDown;
};


