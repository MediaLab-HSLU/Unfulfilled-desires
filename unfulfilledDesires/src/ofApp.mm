#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofSetFrameRate(60);
    //we load our settings file
    
    if( XML.loadFile(ofxiOSGetDocumentsDirectory() + "mySettings.xml") ){
        cout << "mySettings.xml loaded from documents folder!"<< endl;
    }else if( XML.loadFile("mySettings.xml") ){
        cout << "mySettings.xml loaded from data folder!"<< endl;
    }else{
        cout << "unable to load mySettings.xml check data/ folder" << endl;
    }
    
    
    //we initalize some of our variables
    lastTagNumber	= 0;
    pointCount		= 0;
    lineCount		= 0;
    
    
    //-------
    //this is a more advanced use of ofXMLSettings
    //we are going to be reading tags within the <HEAD><PT> tags
    int numHeadTags = XML.getNumTags("HEAD:PT");
    
    //if there is at least one <HEAD> tag we can read the list of points (which contains the coordinates for the heads of our portraits)
    if(numHeadTags > 0){
        
        //we push into the last tag
        //this temporarirly treats the tag as
        //the document root.
        XML.pushTag("HEAD", numHeadTags-1);
        
        //we see how many points we have stored in <PT> tags
        int numPtTags = XML.getNumTags("PT");
        
        if(numPtTags > 0){
            
            //We then read the paths of the images and the x y values into our array
            
            for(int i = 0; i < totImgs; i++){
                
                //load images
                string path = "images/"+XML.getValue("PT:PATH", "", i);
                imgs[i].loadImage(path);
                
                //load head coordinates
                int x = XML.getValue("PT:X", 0, i);
                int y = XML.getValue("PT:Y", 0, i);
                headPts[i].set(x, y);
                cout << headPts[i] << endl;
                pointCount++;
            }
        
        }
        //this pops us out of the tag
        //sets the root back to the xml document
        XML.popTag();
    }
    
    imageCounter = 0; //an index to go through our imafes
    touchedDown = false; //a boolean to trigger touch down/up
}

//--------------------------------------------------------------
void ofApp::update(){
    }

//--------------------------------------------------------------
void ofApp::draw(){
    //white background
    ofBackground(255);
   
    //who the image when the thumb is on the screen
    if(touchedDown) {
        ofSetColor(255);
        imgs[imageCounter].draw(touched.x-headPts[imageCounter].x, touched.y-headPts[imageCounter].y);
    }
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    touched = touch;
    touchedDown= true;
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    touched = touch;
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    imageCounter++;
    if(imageCounter >= totImgs)imageCounter = 0;
    touchedDown = false;

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}
