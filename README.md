
# Orthonormal Face Recognition

One of the few biometric methods that handles both high accuracy and low intrusiveness is face recognition. Over past 30 years, many different face recognition algorithm was proposed by significant amount of researchers. Compressive Sensing is one of the standard methods of face recognition in holistic approach. However, in research [1], the sparsity assumption which underpins much of this work is not supported by the data was shown. In addition to that, they showed that a simple L2 approach to the face recognition problem is not only significantly more accurate than the state-of-the art approach, it is also more robust, and much faster. The results are demonstrated on the publicly available YaleB and AR face datasets. 

In that research, the minimization function has not got any regularization term. To test how the regularization terms has an effect on face recognition accuracy, here we reimplemneted mention algorithm and also proposed new regularization term which is in L2 norm.

In used dataset named CroppedYale, has 58 number of images for every single 38 individuals. All face images in that dataset has 192x168 resolution and cropped well manually. We splitted entire dataset into 2 group as first 29 instances are train and last 29 instances are test. Here is some example of dataset.

![Sample image](sampleinput.jpg?raw=true "Title")

Within given code, you can control regularization terms effect by changing the value of `lambda` in main.m script. if you set `lambda=0;` means there is no regularization terms and algorithm works as how mentioned paper described [1]. To run the code briefly run main script by;
```{Matlab}
> main
```
As you can see, the recognition acuracy is around 95%.


## Reference ##
[1]	Shi, Qinfeng, et al. "Is face recognition really a compressive sensing problem?." Computer Vision and Pattern Recognition (CVPR), 2011 IEEE Conference on. IEEE, 2011. 
