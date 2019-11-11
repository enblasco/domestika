# Domestika
Mobile code challenge

### Prerequisites

xCode Version 11.2 and macOS Catalina

## Views

All views

* [GradientView](https://github.com/enblasco/domestika/blob/master/Domestika/Domestika/Resources/GradientView.swift) - Set gradient background to viewui
* [Login](https://github.com/enblasco/domestika/tree/master/Domestika/Domestika/Login) - Video background demostration
* [CoursesList](https://github.com/enblasco/domestika/tree/master/Domestika/Domestika/CoursesList) - All CoursesList views. Show all courses in carouser and collection view
* [CourseDetail](https://github.com/enblasco/domestika/tree/master/Domestika/Domestika/CourseDetail) - All CourseDetail views. Show course detail using table view an video player

## Models

The models of domestika app

* [Course](https://github.com/enblasco/domestika/tree/master/Domestika/Domestika/Model/Course.swift) - Course model

## Facade

Backend request architecture

* [Parser](https://github.com/enblasco/domestika/tree/master/Domestika/Domestika/Parser) - All parsers models
* [Facade](https://github.com/enblasco/domestika/tree/master/Domestika/Domestika/Facade) -  Prepare session to send post and get calls
* [Command](https://github.com/enblasco/domestika/tree/master/Domestika/Domestika/Command) -  Execute background tasks

## Extensions

* [UIView+fade](https://github.com/enblasco/domestika/blob/master/Domestika/Domestika/Extensions/UIView%2Bfade.swift) - Fade in/out animation
* [UIButton+cornerRadius](https://github.com/enblasco/domestika/blob/master/Domestika/Domestika/Extensions/UIButton%2BcornerRadius.swift) - Corner radius feature 
* [UIPageViewController+goToNextPage](https://github.com/enblasco/domestika/blob/master/Domestika/Domestika/Extensions/UIPageViewController%2BgoToNextPage.swift) - Carouser control
* [UIImageView+downloaded](https://github.com/enblasco/domestika/blob/master/Domestika/Domestika/Extensions/UIImageView%2Bdownloaded.swift) - Download image from url in background task
* [UIView+cornerRadius](https://github.com/enblasco/domestika/blob/master/Domestika/Domestika/Extensions/UIView%2BcornerRadius.swift) - Corner radius feature
* [UIView+dropShadow](https://github.com/enblasco/domestika/blob/master/Domestika/Domestika/Extensions/UIView%2BdropShadow.swift) - Print shadow
* [String+ut8decode](https://github.com/enblasco/domestika/blob/master/Domestika/Domestika/Extensions/String%2But8decode.swift) - decode / encode utf8String
* [Double+rounded](https://github.com/enblasco/domestika/blob/master/Domestika/Domestika/Extensions/Double%2Brounded.swift) - Rounded two decimals


## BaseLibrary

BaseLibrary is its own library created to demonstrate the ability to create libraries with swift.

* The objective is to obtain a library that can be used in any project (scalable) to make requests to an API that returns a JSON and to be able to automatically assign the received properties to the attributes of the corresponding model object.
* The library makes it easy to assign JSON properties to the model object
* It prevents that if the backend changes a value the application generates an error

* [BaseLibrary](https://github.com/enblasco/domestika/tree/master/BaseLibrary/BaseLibrary) - Rounded two decimals



## Authors

* **Enrique Blasco Blanquer** - *Initial work*
