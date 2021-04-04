# General info
Project for detecting tennis ball using OpenCV library and Python.

# Prerequisites
- `Linux` environment,
- installed `OpenCV` >= 2.4 ([tutorial](https://pythonprogramming.net/haar-cascade-object-detection-python-opencv-tutorial/)),
- configured `Python` >= 3.6.

# Run

```
$ git clone https://github.com/radosz99/tennis-ball-detector.git
$ pip3 install -r requirements.txt
$ chmod 777 train_classifier.sh
$ ./train_classifier.sh 12 24 0.25
$ python3 detector.py images data/cascade.xml
```

# Detail info
To detect item was chosen Haar feature-based cascade classifier proposed by Paul Viola and Michael Jones, which is implemented in OpenCV library.  

Procedure of generating classifier consists of two main steps:
1. Generating `.vec` file based on special prepared file with references to images, coordinates and size of tennis balls (`positives`),
2. Training classifier based on `.vec` file and special prepared file with references to images that does not contain tennis balls (`negatives`).

## Vector file composed of positives
Using Google were collected 25 images that contains tennis balls. Then tennis balls has been cut, cropped to 114x114 pixels and saved to `pos_sample/` directory. Unfortunately, this is not enough to get classifier of great quality, cause there is a need to have at least few hundred of `positives`. Then Ubuntu library `libopencv-dev` comes with help by offering `opencv_createsamples` method that allows to create as many `positives` as we want. Refering to documentation:  

"...The scheme of test samples creation is similar to training  samples  creation  since  each  test  sample  is  a  background  image into which a randomly distorted and randomly scaled  instance of the object picture is pasted at a random position..." [[1]](#1).

Using `picture_generatory.py` script 1800 grayscale `negatives` in 200x200 pixels size were collected to `neg/` directory.

```bash
$ pwd

```

# References
<a id="1">[1]</a> 
`libopencv-dev` Ubuntu documentation
http://manpages.ubuntu.com/manpages/xenial/man1/opencv_createsamples.1.html
