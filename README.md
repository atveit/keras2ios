# keras2ios
Keras to iOS with CoreMLTools

# Usage
  ./build.sh # to build docker image with all python lib requirements
  ./pyrun.sh keras2ios # train Keras model and convert with coremltools

# Output from run (the tail)
...
Epoch 998/1000
4/4 [==============================] - 0s - loss: 0.0045     
Epoch 999/1000
4/4 [==============================] - 0s - loss: 0.0045     
Epoch 1000/1000
4/4 [==============================] - 0s - loss: 0.0045     
trying to save keras model to file
0 : dense_input_1, <keras.engine.topology.InputLayer object at 0x7ff5cd910890>
1 : dense_1, <keras.layers.core.Dense object at 0x7ff5cd910810>
2 : activation_1, <keras.layers.core.Activation object at 0x7ff5cd93d890>
3 : dense_2, <keras.layers.core.Dense object at 0x7ff5cd93d8d0>
4 : activation_2, <keras.layers.core.Activation object at 0x7ff5cd8e9ed0>

