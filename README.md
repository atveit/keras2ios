
[Source](https://amundtveit.com/2017/06/07/keras-deep-learning-with-apples-coremltools-on-ios-11-part-1/ "Permalink to Keras Deep Learning with Apple’s CoreMLTools on iOS 11 – Part 1 – Amund Tveit's Blog")

# Keras Deep Learning with Apple’s CoreMLTools on iOS 11 – Part 1 – Amund Tveit's Blog

This is a basic example of train and use a basic [Keras][1] neural network model (XOR) on iPhone using [Apple's][2] coremltools on iOS11. Note that showing the integration starting from a Keras model to having it running in the iOS app is the main point and not the particular choice of model, in principle a similar approach could be used for any kind of Deep Learning model, e.g. generator part of [Generative Adversarial Networks][3], a [Recurrent Neural Network][4] (or LSTM) or a [Convolutional Neural Network][5].

For easy portability I chose to run the Keras part inside docker (_i.e. could e.g. use [nvidia-docker][6] for a larger model that would need a GPU to train e.g. in the cloud or on a desktop or a [powerful laptop][7]_). The current choice of Keras backend was TensorFlow, but believe it should also work for other backends (e.g. CNTK, Theano or MXNet). The code for this blog post is available at [github.com/atveit/keras2ios][8]

Best regards,

[Amund Tveit][9]

## 1\. Building and training Keras Model for XOR problem – PYTHON

### 1.1 Training data for XOR

# 0 xor 0 = 0 # 0 xor 1 = 1 # 1 xor 0 = 1 # 1 xor 1 = 0 X = np.array([[0,0],[0,1],[1,0],[1,1]]) y = np.array([[0],[1],[1],[0]])

| ----- |
|   | 

# 0 xor 0 = 0

# 0 xor 1 = 1

# 1 xor 0 = 1

# 1 xor 1 = 0

X = np.array([[0,0],[0,1],[1,0],[1,1]])

y = np.array([[0],[1],[1],[0]])

 | 

### 1.2 Keras XOR Neural Network Model

model = Sequential() model.add(Dense(8, input_dim=2)) # fully connected layer with 8 hidden nodes and input dimension of 2 model.add(Activation('tanh')) model.add(Dense(1)) model.add(Activation('sigmoid')) # 1 output, either 0 or 1

| ----- |
|   | 

model = Sequential()

model.add(Dense(8, input_dim=2)) # fully connected layer with 8 hidden nodes and input dimension of 2

model.add(Activation('tanh'))

model.add(Dense(1))

model.add(Activation('sigmoid')) # 1 output, either 0 or 1

 | 

### 1.3 Train the Keras model with Stochastic Gradient Descent (SGD)

sgd = SGD(lr=0.1) model.compile(loss='binary_crossentropy', optimizer=sgd) model.fit(X, y, nb_epoch=1000, batch_size=1) 

| ----- |
|   | 

sgd = SGD(lr=0.1)

model.compile(loss='binary_crossentropy', optimizer=sgd)

model.fit(X, y, nb_epoch=1000, batch_size=1)

 | 

### 1.4 Use Apple's coreml tool to convert the Keras model to coreml model

import coremltools coreml_model = coremltools.converters.keras.convert(model) coreml_model.save("keras_model.mlmodel")

| ----- |
|   | 

import coremltools

coreml_model = coremltools.converters.keras.convert(model)

coreml_model.save("keras_model.mlmodel")

 | 

## 2\. Using the converted Keras model on iPhone – SWIFT

### 2.1 Create new Xcode Swift project and add keras_model.mlmodel

![kerasxcode][10]

### 2.2 Inspect keras_model.mlmodel by clicking on it in xcode

![mlmodelinspect][11]

### 2.3 Update ViewController.swift with prediction function

func xor_with_keras(x:NSNumber,y:NSNumber) -> String{ // input data is a float32 array with 2 elements guard let input_data = try? MLMultiArray(shape:[2], dataType:MLMultiArrayDataType.float32) else { fatalError("Unexpected runtime error. MLMultiArray") } input_data[0] = x input_data[1] = y let i = keras_modelInput(input1: input_data) // actual prediction guard let xor_prediction = try? model.prediction(input: i) else { fatalError("Unexpected runtime error. model.prediction") } let result = String(describing: xor_prediction.output1[0]) print(input_data[0].stringValue + " XOR " + input_data[1].stringValue + " = " + result) return result }

| ----- |
| 

1

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

20

21

 | 

  func xor_with_keras(x:NSNumber,y:NSNumber) -> String{

        // input data is a float32 array with 2 elements

        guard let input_data = try? MLMultiArray(shape:[2], dataType:MLMultiArrayDataType.float32) else {

            fatalError("Unexpected runtime error. MLMultiArray")

        }

        

        input_data[0] = x

        input_data[1] = y

        let i = keras_modelInput(input1: input_data)

        

        // actual prediction

        guard let xor_prediction = try? model.prediction(input: i) else {

            fatalError("Unexpected runtime error. model.prediction")

        }

        

        let result = String(describing: xor_prediction.output1[0])

        

        print(input_data[0].stringValue + " XOR "  + input_data[1].stringValue + " = " + result)

        return result

        

    }

 | 

### 2.4 Run app with Keras model on iPhone and look at debug output

### ![run output][12]

0 xor 0 = 1 xor 1 = 0 (if rounding down), and 1 xor 0 = 0 xor 1 = 1 (if rounding up)

LGTM!

## Sign up for Deep Learning newsletter!

[1]: https://keras.io
[2]: https://developer.apple.com/machine-learning/
[3]: https://ai.amundtveit.com/keyword/generative%20adversarial%20networks
[4]: https://ai.amundtveit.com/keyword/recurrent%20neural%20networks
[5]: https://ai.amundtveit.com/keyword/convolutional%20neural%20networks
[6]: https://github.com/NVIDIA/nvidia-docker
[7]: https://amundtveit.com/2017/02/28/deep-learning-on-a-laptop-with-nvidia-gtx-1070-gpu-part-1/
[8]: https://github.com/atveit/keras2ios
[9]: https://amundtveit.com/about/
[10]: https://amundtveit.com/wp-content/uploads/2017/06/Screen-Shot-2017-06-08-at-00.05.38-1.png
[11]: https://amundtveit.com/wp-content/uploads/2017/06/Screen-Shot-2017-06-08-at-00.15.13.png
[12]: https://amundtveit.com/wp-content/uploads/2017/06/Screen-Shot-2017-06-08-at-00.18.08.png

  
