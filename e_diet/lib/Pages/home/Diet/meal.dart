class Meal {
  final String mealTime, name, imagePath, kiloCaloriesBurnt, timeTaken;

  Meal({
    this.mealTime,
    this.name,
    this.imagePath,
    this.kiloCaloriesBurnt,
    this.timeTaken,
  });
}

final meals = [
  Meal(
    mealTime: "BREAKFAST",
    name: "Fruit Granola",
    kiloCaloriesBurnt: "271",
    timeTaken: "10",
    imagePath: "assets/fruit_granola.jpg",
  ),
  Meal(
    mealTime: "LUNCH",
    name: "FISH",
    kiloCaloriesBurnt: "706",
    timeTaken: "20",
    imagePath: "assets/121711821-healthy-meal-fried-fish.jpg",
  ),
  Meal(
    mealTime: "DINNER",
    name: "Pesto Pasta",
    kiloCaloriesBurnt: "612",
    timeTaken: "15",
    imagePath: "assets/pesto_pasta.jpg",
  ),
  Meal(
    mealTime: "SNACK",
    name: "Keto Snack",
    kiloCaloriesBurnt: "414",
    timeTaken: "16",
    imagePath: "assets/keto_snack.jpg",
  ),
];
