import keras
import keras.models
from keras.models import Sequential
from keras.layers.core import Dense, Dropout, Activation
from keras.optimizers import SGD
import numpy as np 
import json

X = np.array([[0,0],[0,1],[1,0],[1,1]])
y = np.array([[0],[1],[1],[0]])

model = Sequential()
model.add(Dense(10, input_dim=2))
model.add(Activation('tanh'))
model.add(Dense(1))
model.add(Activation('sigmoid'))

sgd = SGD(lr=0.1)
model.compile(loss='binary_crossentropy', optimizer=sgd)

model.fit(X, y, nb_epoch=1000, batch_size=1)

model.save('keras_weights.h5') # hdf5 format
model_json_string = model.to_json()
fh = open('keras_model.json','w')
fh.write(model_json_string)
fh.close()

print("trying to save keras model to file")
import coremltools
coreml_model = coremltools.converters.keras.convert(model)
coreml_model.save("keras_model.mlmodel")



