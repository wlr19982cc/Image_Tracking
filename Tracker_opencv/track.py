import cv2
import sys

if __name__ == '__main__' :

    tracker = cv2.TrackerCSRT_create()

    # Read video
    video = cv2.VideoCapture("4.mp4")

    if not video.isOpened():
        print ("Could not open video")
        sys.exit()

    # Read first frame
    ok, frame = video.read()
    if not ok:
        print ('Cannot read video file')
        sys.exit()

    bbox = cv2.selectROI(frame, False)

    # Initialize tracker with first frame and bounding box
    ok = tracker.init(frame, bbox)
    num = 0
    while True:
        # Read a new frame
        ok, frame = video.read()
        if not ok:
            break

        # Update tracker
        ok, bbox = tracker.update(frame)

        # Draw bounding box
        if ok:
            # Tracking success
            p1 = (int(bbox[0]), int(bbox[1]))
            p2 = (int(bbox[0] + bbox[2]), int(bbox[1] + bbox[3]))
            cv2.rectangle(frame, p1, p2, (255,0,0), 2, 1)
        else :
            # Tracking failure
            cv2.putText(frame, "Tracking failure detected", (100,80), cv2.FONT_HERSHEY_SIMPLEX, 0.75,(0,0,255),2)

        # Display result
        cv2.imshow("Tracking", frame)
        file_name = "e:/track/4/image"+str(num)+".png"
        cv2.imwrite(file_name, frame)
        num += 1
        # Exit if ESC pressed
        k = cv2.waitKey(1) & 0xff
        if k == 27 : break