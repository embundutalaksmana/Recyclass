# Build Images Classification Using Transfer Learning (MobileNetV2)

Following are the steps for building an image classification using Transfer Learning (MobileNetV2)

## Steps

1. Download Recyclass.zip from this repository
```
!git clone https://github.com/imyanuarginting/Recyclass.git
```
2. Extract the Recyclass.zip file from the repository downloaded previously
```
import os
import zipfile

zip_ref = zipfile.ZipFile('Recyclass/Recyclass.zip', 'r')
zip_ref.extractall("tmp/")
zip_ref.close()

base_dir = 'tmp/Recyclass'
```
3. Import some libraries to check whether TensorFlow supports the format of the images or not
```
from pathlib import Path
import imghdr
```
4. Here is the code to check the format of the images supported by TensorFlow
```
train_dir = os.path.join(base_dir, 'train')
image_extensions = ['.png', '.jpg']

img_type_accepted = ['jpeg', 'png', 'gif', 'bmp', 'jpg']
for filepath in Path(train_dir).rglob("*"):
  if filepath.suffix.lower() in image_extensions:
    img_type = imghdr.what(filepath)
    if img_type is None:
      print(f'{filepath} is not an image')
    elif img_type not in img_type_accepted:
      print(f'{filepath} is a {img_type}, not accepted by TensorFlow')
```
```
val_dir = os.path.join(base_dir, 'val')
image_extensions = ['.png', '.jpg']

img_type_accepted = ['jpeg', 'png', 'gif', 'bmp', 'jpg']
for filepath in Path(val_dir).rglob("*"):
  if filepath.suffix.lower() in image_extensions:
    img_type = imghdr.what(filepath)
    if img_type is None:
      print(f'{filepath} is not an image')
    elif img_type not in img_type_accepted:
      print(f'{filepath} is a {img_type}, not accepted by TensorFlow')
```






## Usage

1. Start the server:
```sheel
python main.py
```


2. Use the following endpoints:

- **POST /upload-photo**: Upload an image for classification. The image should be sent as a form-data request with the key `file`.
- **GET /classification-result**: Get the classification result. This endpoint will return the highest predicted label from the last uploaded image.
- **GET /locations**: Get the location of the Recycling Bank. This endpoint will return a list of Recycling Bank locations by region.
- **GET /articles**: Get the articles base on plastic type. This endpoint will return a list of articles filtered by plastic type.
## Example

Here is an example of how to use the API using cURL:

## Upload Photo [/upload-photo]

### Upload a Photo [POST]
```sheel
curl -X POST -F "file=@image.jpg" http://localhost:8000/upload-photo
```

+ Request (multipart/form-data)

    + Body

            Select a file to upload: _______________

+ Response (application/json)

    + 200 OK

            {
                "error": false,
                "message": "Success to Upload"
            }

    + 400 Bad Request

            {
                "error": true,
                "message": "Image size is too large. Maximum allowed size is 10MB."
            }

    + 400 Bad Request

            {
                "error": true,
                "message": "Unsupported image type. Please use JPEG or PNG format."
            }

## Classification Result [/classification-result]

### Get Classification Result [GET]
```sheel
curl -X GET http://localhost:8000/classification-result
```


+ Response (application/json)

    + 200 OK

            {
                "error": false,
                "result": "HDPE"
            }

    + 404 Not Found

            {
                "error": true,
                "message": "Classification result is not available."
            }

## Locations [/locations/{city}]

### Get City Data [GET]
```sheel
curl -X GET http://localhost:8000/locations/{city}

```


+ Parameters
    + city (string, required) - The name of the city

+ Response (application/json)

    + 200 OK

            {
                "error": false,
                "result": [
                    {
                        "Name": "PT Plasticpay Teknologi Daurulang",
                        "lat": -6.223889302142203,
                        "lon": 106.65502579019379    
                    },
                    {
                        "Name": "Rebricks Indonesia",
                        "lat": -6.264655329030852,
                        "lon": 106.7843817359527
                    },
                    ...
                ]
            }

    + 404 Not Found

            {
                "error": true,
                "message": "Location not found."
            }

## Articles [/articles/{ptype}]

### Get Articles [GET]

```sheel
curl -X GET http://localhost:8000/articles/{ptype}


```


+ Parameters
    + ptype (string, required) - The plastic type

+ Response (application/json)

    + 200 OK

            {
                "error": false,
                "result": [
                    {
                        "url": "https://ecolife.com/recycling/plastic/how-to-recycle-pet-plastic-1/",
                        "img_url": "https://ecolife.com/wp-content/uploads/2022/12/How-to-Recycle-PET.png",
                        "title": "How to Recycle PET (Plastic #1): Step-by-Step Guide",
                        "author": "Sande Tamm",
                        "publication_date": null,
                        "plastic_type": "PET"
                    },
                    {
                        "url": "https://ssfs.recyclist.co/guide/1-plastic-pet/?embeddedguide=true",
                        "img_url": "https://hq2.recyclist.co/wp-content/uploads/sites/2/2015/02/600x600-no1-plastic-300x300.jpg",
                        "title": "South San Francisco Scavenger Recycling Guide",
                        "author": "SSFS",
                        "publication_date": null,
                        "plastic_type": "PET"
                    },
                    ...
                ]
            }

    + 404 Not Found

            {
                "error": true,
                "message": "Wrong Plastic Type"
            }

The response will contain the highest predicted label for the uploaded image.

## Notes

- The API uses TensorFlow and a pre-trained model (`model.h5`) for image classification. Make sure to download the model weights and place them in the same directory as `main.py`.
- The API is built with FastAPI, a modern, fast (high-performance) web framework for building APIs with Python.
- The API assumes that the uploaded images are in RGB format and have a resolution of 224x224 pixels. You may need to preprocess the images accordingly if they don't meet these requirements.

Feel free to modify the API according to your needs. Enjoy classifying images!

# API Classification Result

This API allows you to upload an image, classify it using a pre-trained model, and retrieve the classification result.

## License

This project is licensed under the terms of the Team C23-PS296 - Capstone Project.








