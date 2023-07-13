import os
os.environ["SM_FRAMEWORK"] = "tf.keras"
from PIL import Image 
import urllib.request
from tensorflow import keras
import segmentation_models as sm
from keras import backend as K
from keras.models import load_model
import numpy as np
import matplotlib.image

def give_raw_image(lat, lon):
    # old
    # lat_start = str(lat-0.0020)
    # lat_end = str(lat+0.0020)
    # lon_start = str(lon-0.0023)
    # lon_end = str(lon+0.0023)

    lat_start = str(lat-0.0030)
    lat_end = str(lat+0.0030)
    lon_start = str(lon-0.0031)
    lon_end = str(lon+0.0031)

    url = "https://api.mapbox.com/styles/v1/mapbox/satellite-v9/static/[" + lon_start  + ","+ lat_start  +","+ lon_end  +","+ lat_end  +"]/960x960?access_token=pk.eyJ1Ijoic2F1cmFiaHlhZGF2MTEiLCJhIjoiY2ttb2Nkc3dqMjNlYTMxcWsxbHJjcTRuaiJ9.UOWQ0mcizgwi6WnHwcg0ew"
    output_images_link = url

    # if not os.path.exists('output'):
    #     os.makedirs('output')
    
    img = urllib.request.urlretrieve(output_images_link, 'output/temp.jpg')
    img = Image.open('output/temp.jpg')
    img = img.resize((320, 320))
    # print(img)
    img = np.array(img)
    img = np.expand_dims(img, 0)

    # image = Image.open('/content/44.jpg')
    # image = image.resize((160,160))
    # image = np.array(image)
    # image = np.expand_dims(image, 0)
    return img

def jaccard_coef(y_true, y_pred):
    y_true_flatten = K.flatten(y_true)
    y_pred_flatten = K.flatten(y_pred)
    intersection = K.sum(y_true_flatten * y_pred_flatten)
    final_coef_value = (intersection + 1.0) / (K.sum(y_true_flatten) + K.sum(y_pred_flatten) - intersection + 1.0)
    return final_coef_value

def preProcessImage(img):
    return true

def getTreeDensity(predicted_image):
    # get the number of black pixels
    blackPixels = np.count_nonzero(predicted_image == 0)
    # get the number of white pixels
    whitePixels = np.count_nonzero(predicted_image == 1)
    # calculate the tree density
    tree_density = blackPixels / (blackPixels + whitePixels)
    return tree_density


def predictFromModel(lat, long):
    # get the location image based on this lat and long
    img = give_raw_image(lat, long)
    # calculate total loss
    weights = [0.5, 0.5]
    dice_loss = sm.losses.DiceLoss(class_weights = weights)
    focal_loss = sm.losses.CategoricalFocalLoss()
    total_loss = dice_loss + (1 * focal_loss)
    # load the model
    model = load_model('satellite_segmentation.h5', custom_objects=({'dice_loss_plus_1focal_loss': total_loss, 
                                          'jaccard_coef': jaccard_coef}))
    # model = tensorflow.keras.models.load_mode('satellite_segmentation.h5', compile=False)
    # model.compile(custom_objects=({'dice_loss_plus_1focal_loss': total_loss, 
    #                                       'jaccard_coef': jaccard_coef}))
    # predict the output

    output = model.predict(img)
    predicted_image = np.argmax(output, axis=3)
    predicted_image = predicted_image[0,:,:]

    print(predicted_image.shape)
    print(type(predicted_image))

    # im_save = Image.fromarray(predicted_image)
    # im_save.save('output/predicted_image.jpg')

    matplotlib.image.imsave('output/predicted_image.jpg', predicted_image)

    tree_density = getTreeDensity(predicted_image)
    # return the output
    return tree_density