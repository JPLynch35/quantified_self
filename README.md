# Quantified Self

Quantified Self is a back end Rails-based API meant to track your meals and calorie intake.  The user can utilize the basic CRUD functionality for foods, which have names and calories, in addition to meals which have names and a list of foods. The user can also view their favorite foods, which are the top 3 most eaten items across all meals.

### Production Site  
[https://quantified-self-35.herokuapp.com](https://quantified-self-35.herokuapp.com)

## API Endpoints
### Foods
##### GET /api/v1/foods
Returns a collection of all food objects with id, name, and calorie attributes as shown below.  
```
[
    {
        "id": 1,
        "name": "banana",
        "calories": 150
    },
    {
        "id": 2,
        "name": "apple",
        "calories": 100
    }
]
```
##### GET /api/v1/foods/:id
Returns food object of specific :id with id, name, and calorie attributes.  
##### POST /api/v1/foods
Creates food object, requires name and calorie attributes as shown below.  
```
{ "food": { "name": "Name of food here", "calories": "Calories here"} }
```
##### PATCH /api/v1/foods/:id
Updates food object of specific :id with name and calorie attributes (both required). Format same as post.
##### DELETE /api/v1/foods/:id
Deletes food object of specific :id.  
### Meals
##### GET /api/v1/meals
Returns a collection of all meal objects with id, name, and a collection of food objects as shown below.  
```
[
    {
        "id": 1,
        "name": "breakfast",
        "foods": [
            {
                "id": 1,
                "name": "banana",
                "calories": 150
            },
            {
                "id": 2,
                "name": "apple",
                "calories": 100
            }
        ]
    },
    {
        "id": 2,
        "name": "lunch",
        "foods": [
            {
                "id": 2,
                "name": "apple",
                "calories": 100
            },
            {
                "id": 3,
                "name": "toast",
                "calories": 75
            },
            {
                "id": 4,
                "name": "strawberries",
                "calories": 200
            }
        ]
    }
]
```
##### GET /api/v1/meals/:meal_id/foods
Returns a collection of all food objects associated with specific :meal_id.  Format same as Get Foods.
##### POST /api/v1/meals/:meal_id/foods/:id
Links a valid food object of specific :id to a valid meal object of specific :meal_id. Will return message below if successful.  
```
{
    "message": "Successfully added FOODNAME to MEALNAME"
}
```
##### DELETE /api/v1/meals/:meal_id/foods/:id
Removes a valid food object of specific :id from a valid meal object of specific :meal_id. Will return message below if successful.  
```
{
    "message": "Successfully removed FOODNAME to MEALNAME"
}
```
### Favorites
##### GET /api/v1/favorite_foods
Returns a collection of all favorite food objects with timesEaten and a collection of food objects also containing mealsWhenEaten as shown below.  
```
[
    {
        "timesEaten": 3,
        "foods": [
            {
                "name": "apple",
                "calories": 100,
                "mealsWhenEaten": [
                    "breakfast",
                    "lunch",
                    "dinner"
                ]
            }
        ]
    },
    {
        "timesEaten": 2,
        "foods": [
            {
                "name": "strawberries",
                "calories": 200,
                "mealsWhenEaten": [
                    "lunch",
                    "dinner"
                ]
            },
            {
                "name": "banana",
                "calories": 150,
                "mealsWhenEaten": [
                    "breakfast",
                    "dinner"
                ]
            }
        ]
    }
]
```

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

This application was created in Rails v5.1.6, utilizing Ruby v2.4.1. 

### Installing

Clone the project down locally to your machine.  
```
git clone https://github.com/JPLynch35/quantified_self.git
```  
Inside the project directory, prepare the gems for development with bundler.  
```
bundle install
``` 
Now create the database, prep the migrations, and load the seed data.
```
rake db:{create,migrate,seed}
``` 

## Running the tests

This application is tested with RSpec.  In order to run this test suite, simply call upon RSpec in the terminal while in the project folder.  
```
rspec
```

## Built With

* Ruby 2.4.1- The code language
* Rails 5.1.6- Ruby's web framework

## Authors

* **JP Lynch**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
