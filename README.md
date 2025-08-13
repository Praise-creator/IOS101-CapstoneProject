# IOS101-CapstoneProject

PantryPal
Table of Contents
Overview
Product Spec
Wireframes
Schema


Overview
Description
PantryPal is an app that makes finding unique recipes easy for users. A user can input some ingredients/items they have at home and the app gives recipes that use 1 or more of these ingredients.

App Evaluation

Category:Food
Mobile:Yes
Story:People often have ingredients but don't know what to make. 
Market:Anyone who cooks.
Habit:Can be used anytime a user wants to make a meal
Scope:adding ingredients, removing ingredients, favoriting recipes, detail views


Product Spec
1. User Stories (Required and Optional)
Required Must-have Stories

[x]User can add ingredients to their pantry

[x]User can delete ingredients from their pantry

[x]User can view a list of suggested recipes based on pantry contents

[x]User can view recipe detail with instructions and ingredients

[]User can favorite and unfavorite recipes

[]Favorites tab displays all saved recipes


Optional Nice-to-have Stories

[]User can filter recipes by dietary restrictions (e.g. vegetarian, gluten-free)

[]xUser can filter based on how much time they want to spend cooking

[]Pantry auto-suggests ingredients as user types

[]User can generate a shopping list from missing ingredients

[]Daily/weekly recipe suggestions via notification


2. Screen Archetypes
Pantry Screen
  -User can add/remove ingredients
Recipes Screen
  -Displays recipes based on pantry contents
  -Tapping a recipe goes to detail view
Recipe Detail View
  -Displays full recipe, ingredients, and steps
  -Option to favorite/unfavorite the recipe
Favorites Screen
  -Lists all favorited recipes
  -Tapping an item opens recipe detail view
   
3. Navigation
Tab Navigation (Tab to Screen)

Pantry 
Recipes 
Favorites 

Flow Navigation
Pantry → Recipes
When the user adds ingredients, the app uses them to suggest recipes

Recipes → Recipe Detail View
User taps on a recipe to view instructions and ingredients

Favorites → Recipe Detail View
User revisits saved recipes

...





To Run, 
Go to https://spoonacular.com/food-api/ and get an API key. 
Then go to RecipesViewController file and add the API key where it says to.






Wireframes
<img width="1368" height="1796" alt="image" src="https://github.com/user-attachments/assets/b38793ed-de06-4b62-a850-677f1aff5df4" />
 

Current Working Video:

![Kapture 2025-08-12 at 23 09 24](https://github.com/user-attachments/assets/ca5fe749-0bac-403d-ae59-40ae27e921da)




****
[BONUS] Digital Wireframes & Mockups
[BONUS] Interactive Prototype
Schema
[This section will be completed in Unit 9]

Models
[Add table of models]

Networking
[Add list of network requests by screen ]
[Create basic snippets for each Parse network request]
[OPTIONAL: List endpoints if using existing API such as Yelp]
