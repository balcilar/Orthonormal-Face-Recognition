
# Orthonormal Face Recognition

One of the few biometric methods that handles both high accuracy and low intrusiveness is face recognition. Over past 30 years, many different face recognition algorithm was proposed by significant amount of researchers. Compressive Sensing is one of the standard methods of face recognition in holistic approach. However, in research [1], the sparsity assumption which underpins much of this work is not supported by the data was shown. In addition to that, they showed that a simple L2 approach to the face recognition problem is not only significantly more accurate than the state-of-the art approach, it is also more robust, and much faster. The results are demonstrated on the publicly available YaleB and AR face datasets. 

In that research, the minimization function has not got any regularization term. To test how the regularization terms has an effect on face recognition accuracy, here we reimplemneted mention algorithm and also proposed new regularization term which is in L2 norm.


## L2 Orthonormal Face Recognition

Consider face recognition with **n** number of training face images are collected from **K** number of subjects. Suppose **n_k** refers the number of training images which belongs to $k^{th}$ subject. Assume all training images get just a column vector and all column vector are merged in a single matrix $A$ in eq(1) where $x_n$ refers $n_{th}$ face image which is in single column vector, $m$ refers number of pixel in any image.

$$A= \begin{bmatrix} x_{1} & .. x_{n} \end{bmatrix} \in $R$^{mxn}] $$

## Reference ##
[1]	Shi, Qinfeng, et al. "Is face recognition really a compressive sensing problem?." Computer Vision and Pattern Recognition (CVPR), 2011 IEEE Conference on. IEEE, 2011. 
