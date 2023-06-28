
# 마이크로프로세서 응용 프로젝트 설명

# 설계 목표: Embedded system에서 제한된 자원을 이용하여 효율적인 ARM 코드 작성


주어진 목표를 위해 C code와 Assembly code를 이용하여 가장 빠르게 동작하는 코드 작성. ○ C와 Assembly를 이용한 영상 데이터 처리


딥러닝에 이용하는 CNN(Convolutional Neural Network의 기본 연산은 2D array data에 대한 convolution 
연산이다. 입력 이미지의 컬러 픽셀 정보는 아래와 같다. 32bit 데이터는 각 8bit의 R,G,B 색상과 Gaussian channel 값 
A로 구성된다.

1. 이미지 데이터 파일을 메모리의 연속 주소공간에 저장하고 이 데이터를 다른 주소 공간에 이차원 배열 형
태로 이동 배치한다. 즉 하나의 이미지 행의 첫 번째 픽셀이 2^n으로 시작하는 메모리 주소에 위치하도록 한
다.

2. 컬러 이미지를 HSL 공간에서 그레이스케일 8bit 이미지로 변환한다. 변환식은 다음과 같다. 
 L=(max(R,G,B)+min(R,G,B))/2

3. HSL공간의 L 데이터에 대해 convolution 연산을 수행한다. 3 x 3 Convolution 연산은 아래 그림과 같이 
수행한다. 가장 자리 셀에 대해서는 0 padding을 한 후 convolution 연산을 수행한다. 이후 RELU activation 
function을 통과시킨다. 이때 kernel, W는 다음과 같다
W=[[0.125, -0.14, 0.05]. [-0.14, 0, -0.075], [0.05, -0.075, 0.125]]  

4. Stride=2의 max pooling을 수행한다.

5. 최초 데이터는 8bit unsigned가 4개 모인 형태이고 1번 과정이후 32bit signed fixed-point 형태로 처리
한다. [100,100]. [100,200], [200,100], [200,200] 위치의 픽셀값을 출력한다. 최종 결과를 다시 연속한 메
모리 주소로 이동후 파일에 저장하고 viewer를 통해 이미지를 확인한다.
