class Meal {
  final String mealTime,
      name,
      imagePath,
      kiloCaloriesBurnt,
      timeTaken,
      mealProtein,
      mealCarbs,
      mealFat;

  Meal({
    this.mealTime,
    this.name,
    this.imagePath,
    this.kiloCaloriesBurnt,
    this.timeTaken,
    this.mealProtein,
    this.mealCarbs,
    this.mealFat,
  });
}

final meals = [
  Meal(
    mealTime: "BREAKFAST",
    name: "Fruit Granola",
    kiloCaloriesBurnt: "271",
    timeTaken: "10",
    imagePath: "assets/fruit_granola.jpg",
    mealProtein: "15g",
    mealCarbs: "216g",
    mealFat: "20g",
  ),
  Meal(
    mealTime: "LUNCH",
    name: "FISH",
    kiloCaloriesBurnt: "706",
    timeTaken: "20",
    imagePath: "assets/121711821-healthy-meal-fried-fish.jpg",
    mealProtein: "27g",
    mealCarbs: "30g",
    mealFat: "200g",
  ),
  Meal(
      mealTime: "DINNER",
      name: "Pesto Pasta",
      kiloCaloriesBurnt: "612",
      timeTaken: "15",
      imagePath: "assets/pesto_pasta.jpg",
      mealProtein: "11g",
      mealCarbs: "230g",
      mealFat: "100g"),
  Meal(
    mealTime: "SNACK",
    name: "Keto Snack",
    kiloCaloriesBurnt: "414",
    timeTaken: "16",
    imagePath: "assets/keto_snack.jpg",
    mealProtein: "21g",
    mealCarbs: "60g",
    mealFat: "150g",
  ),
];
