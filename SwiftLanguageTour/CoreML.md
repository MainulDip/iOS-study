### Machine Learning Apple Ecosystem:
Some into into ML in Apple Ecosystem:

### What is ML: 
The field of study that gives computers the ability to learn without being explicitly programmed. - "Arthur Samuel"
- Types of ML: Supervised and UnSupervised
### Supervised: 
Teach Computer in a supervised env, (feed trancing data with label). A Model is built on a set of the data by training. In the end, model behaves as a classifier, that differentiate or can detect what something is, and what not.

Model Types: 
 - Continuous (Regression Model): Any Form of Data, like height, weight. Where there is no threshold, those output can be anything.
 - Discrete (Classification Model): Threshold Data (Cap), like Grades (A+, A, B, C), also like, image classification/detection

### Unsupervised:
Let computer group/sort data into several groups based on their structure without any labeling.
- Clustering: Arrange data in different clusters/groups


### Reinforcement Learning (Force to Learn):
Its a training method based on rewarding desired behaviors and punishing undesired ones. In general, a reinforcement learning agent -- the entity being trained -- is able to perceive and interpret its environment, take actions and learn through trial and error.
### CoreML:
Its to make integration ML functionality in ios Projects. Used from Classification or Regression. CoreML provides 2 things.
- Load a  Pre-Trained (static) Model: Models trained on Caffee/torch/Keras converted into a open slandered .ml model files format. So classes inside that model can be used in xcode.
- Make Prediction: models can be used to predict different things

NB: 
- in CoreML the model cannot be dynamic ( cannot collect user data and train model further ). thus the model is static. dev can update model but that is not inside iOS.
- in CoreML, the model cannot be encrypted (.ml model file basically hosts JSON code inside ). So source Codes are human readable.