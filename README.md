
# Orthonormal Face Recognition

One of the few biometric methods that handles both high accuracy and low intrusiveness is face recognition. Over past 30 years, many different face recognition algorithm was proposed by significant amount of researchers. Compressive Sensing is one of the standard methods of face recognition in holistic approach. However, in research [1], the sparsity assumption which underpins much of this work is not supported by the data was shown. In addition to that, they showed that a simple L2 approach to the face recognition problem is not only significantly more accurate than the state-of-the art approach, it is also more robust, and much faster. The results are demonstrated on the publicly available YaleB face dataset. 

In that research, the minimization function has not got any regularization term[1]. To test how the regularization terms has an effect on face recognition accuracy, here we reimplemneted mention algorithm and also proposed new regularization term which is in L2 norm.

## L2 Orthonormal Face Recognition without Regularization Term

Consider face recognition with *n* number of training face images are collected from *K* number of subjects. Suppose *nk* refers the number of training images which belongs to *kth* subject. It means, *N=∑_(k=1)^K n_k*  . Assume all training images get just a column vector and all column vector are merged in a single matrix *A* in eq(1) where *x_n* refers *nth* face image which is in single column vector *m* refers number of pixel in any image.

*A=[(x_1 .. x_n )]  ∈ R^(m×n)*           (1)

According to L2 Orthonormal Face Recognition algorithm, we can rewrite *x* test image single column vector with linear combination of train image matrix *A*. Suppose the linear combination is shown by *α*, we can define it with eq(2).

*x=A.α*                                     (2)

Note than *α* depends on given test image *x* and it should be calculated for every single test inputs. So, to figure out the transformation vector *α*, L2 orthonormal algorithm tries to minimize error function which uses L2 norm of error defined in eq (3).

*α_x=argmin┬α⁡〖 ‖A.α-x‖ 〗*     (3)

Using the advantages of L2 norm error minimization, we can reach the explicit optimum solution using least square errors via eq (4).

*α_x=(A^T A)^(-1) A^T x*                      (4)

After determination of transformation vector *α_x*, we can use eq (5) to figure out in which training subject group belongs to.

*c^** (x)=argmin┬k⁡〖 ‖A_k.α_x-x‖ 〗           (5)

In above equation, function *c^* (x)* refers the class id of tested *x* image, *k* is id of each class in training set, *A_k* refers all image vector of *kth* image in training set. As you the equations tells, we just briefly need to calculate the sum of squares of differences and find the one which has minimum square error.

## L2 Regularization Terms

In addition to minimization function in eq (3) we added L2 norm of desired vector *α_x* as regularization terms. So the new minimization function becomes as eq (6).

*α_x=argmin┬α⁡〖 ‖A.α-x‖ 〗+λ‖α‖*         (6)

Thanks to all terms in minimization function are in L2 form, we can easily find an optimum solution using least squares again with using eq (7).

*α_x=(A^T A+λI)^(-1) A^T x*    (7)  


## Results
As the given minimization formula tells, classic L2 orthonormal face recognition algorithm in eq (3) tries to find best *α* vector for given *x* test image vector according to reconstruction sum of squares error just using eq(4). It does not pay attention how the found *α* vector is. But L2 regularized version tries to minimize both sum of squares of error but also sum of squares of vector *α*. It means classic algorithm finds more minimum reconstruction error but the *α* vector might be consist of big numbers. But within L2 regularization terms, where it tries to minimize eq(6) where its optimum solution is in eq(7), the sum of square of *α* has *λ* effect on minimization function which means maybe it might found bigger reconstruction error but found *α* has minimum sum of squares on test images. Sum of squares means the vector might consist of negative numbers, it is not problem. But the numbers should be as closed to zero as possible. As a result the difeerences between classical L2 ortohormal face recognition algorithm and L2 regularized version is just using either eq(4) or eq(7). As you can see where *λ=0* both formula are identical.  


In used dataset named CroppedYale, has 58 number of images for every single 38 individuals. All face images in that dataset has 192x168 resolution and cropped well manually. We splitted entire dataset into 2 group as odd order number of images are in train set and even order number images are in test set. Here is some example of dataset.

![Sample image](sampleinput.jpg?raw=true "Title")

Within given code, you can control regularization terms effect by changing the value of `lambda` in main.m script. if you set `lambda=0;` means there is no regularization terms and algorithm works as how mentioned paper described [1]. To run the code briefly run main script by;
```{Matlab}
> main
```
As you can see, the recognition acuracy is around 99%. Here is the score differences between actual class distance and the minimum distance of the all rest classes. As you can see if the score is over zero means the predicted class is true, unless the predicted class is wrong. 

![Sample image](result.bmp?raw=true "Title")

According to our test we took %99.00 accuracy with default `lambda=0`, but it increased to %99.30 using `lambda=2000000`. Please note that this result depends on how you split your dataset into train and test case. if you select different division techniques, the result might sligtly differ.  

Also here is confusion matrix and multi class ROC curves too. Note that we changed x-axis range of ROC curve, just display [0 0.4] in order to make it more clear.

![Sample image](confroc.bmp?raw=true "Title")

## Reference ##
[1]	Shi, Qinfeng, et al. "Is face recognition really a compressive sensing problem?." Computer Vision and Pattern Recognition (CVPR), 2011 IEEE Conference on. IEEE, 2011. 
