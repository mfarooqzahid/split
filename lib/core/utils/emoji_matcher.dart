import 'package:fuzzy/fuzzy.dart'; // Optimized string matching

class EmojiMatcher {
  static final Map<List<String>, String> _keywordToEmoji = {
    // 🥚 Eggs
    ["anda", "anday", "egg", "eggs", "andae"]: "🥚",

    // 🍖 Meat / Chicken
    ["kaleji", "liver", "beef", "gosht", "gosht ka", "bakra", "meat", "mutton"]:
        "🍖",
    ["chicken", "murgh", "murgi", "chickens"]: "🍗",

    // 🍵 Tea / Chai
    ["chai", "tea", "chai saman", "chaaye", "chai patti", "tea bag"]: "☕",

    // 🍕 Fast Food
    ["pizza", "burger", "shawarma", "fries", "zinger", "sandwich"]: "🍕",

    // 🍚 Rice Dishes
    ["biryani", "pulao", "rice", "chawal", "fried rice"]: "🍚",

    // 🍛 Food
    [
      "khana",
      "meal",
      "dinner",
      "lunch",
      "nashta",
      "subah ka nashta",
      "breakfast",
      "fasting meal"
    ]: "🍛",
    ["raat ka khana", "dinner"]: "🍽️",

    // 🥙 Roti / Bread
    [
      "roti",
      "rotian",
      "naan",
      "chapati",
      "tandoori roti",
      "paratha",
      "naan bread"
    ]: "🥙",
    ["roti + chany", "chana", "chickpeas", "chana masala", "halwa puri"]: "🍛",

    // 🥛 Dairy (Milk, Yogurt, etc.)
    ["dahi", "yogurt", "curd", "lassi"]: "🥛",
    ["doodh", "milk", "full cream", "toned milk", "low fat milk"]: "🥛",
    ["cheese", "paneer", "cottage cheese"]: "🧀",

    // 🥬 Vegetables
    ["sabzi", "vegetable", "vegetables", "sabzian", "tarkari", "tarkarian"]:
        "🥬",
    ["baingan", "eggplant", "brinjal"]: "🍆",
    ["aloo", "potato", "batata", "french fries"]: "🥔",
    ["pyaz", "onion", "piaz", "piyaz"]: "🧅",
    ["gajar", "carrot", "carrots"]: "🥕",

    // 🍉 Fruits
    ["aam", "mango", "mangos"]: "🥭",
    ["seb", "apple", "apples"]: "🍏",
    ["kela", "banana", "bananas"]: "🍌",
    ["tarbooz", "watermelon", "melon"]: "🍉",
    ["anar", "pomegranate"]: "🍎",
    ["nashpati", "pear"]: "🍐",
    ["angoor", "grapes"]: "🍇",

    // 🍩 Desserts & Sweets
    ["halwa", "sweets", "dessert", "mithai", "gulab jamun", "rasgulla"]: "🍩",
    ["cake", "pastry", "chocolate cake"]: "🎂",
    ["biscuit", "cookies", "biscuits"]: "🍪",

    // 🛍️ Shopping
    ["shopping", "mall", "market", "bazar", "superstore", "grocery"]: "🛍️",
    [
      "kapray",
      "clothes",
      "clothing",
      "shirt",
      "pant",
      "trouser",
      "jeans",
      "kurta",
      "shalwar kameez"
    ]: "👕",

    // 🏠 Rent & Living
    ["rent", "hostel", "ghar ka kiraya", "home rent", "house rent"]: "🏠",

    // 🎉 Events & Festivals
    ["party", "celebration", "event", "birthday", "birthday party"]: "🎉",
    ["ramadan", "eid", "festival", "iftar", "sahoor"]: "🎊",
    ["shadi", "wedding", "mehndi", "baraat"]: "💍",

    // ✈️ Travel
    [
      "trip",
      "vacation",
      "travel",
      "journey",
      "safar",
      "road trip",
      "train journey"
    ]: "✈️",
    ["ticket", "bus ticket", "airline ticket", "train ticket"]: "🎟️",

    // 💰 Finance & Money
    ["debt", "loan", "karza", "udhaar", "credit", "borrowed money"]: "💳",
    ["salary", "wages", "paycheck", "income"]: "💵",
    ["cash", "paisa", "rupay", "rupees", "money"]: "🏦",

    // ☕ Drinks
    ["coffee", "cappuccino", "latte", "espresso"]: "☕",
    ["cold drink", "soda", "soft drink", "coke", "pepsi", "sprite", "fanta"]:
        "🥤",
    ["juice", "fresh juice", "orange juice", "apple juice"]: "🧃",

    // 🎬 Entertainment
    ["movie", "cinema", "film", "theater", "watch movie"]: "🎬",
    ["game", "gaming", "video game", "esports"]: "🎮",

    // 🤷 Default (If no match found)
    ["default"]: "🤷",
  };

  late final Fuzzy _fuzzySearch;

  EmojiMatcher() {
    // Convert keyword lists into a single list for fuzzy search
    List<String> allKeywords = _keywordToEmoji.keys.expand((e) => e).toList();

    // Initialize Fuzzy search
    _fuzzySearch = Fuzzy(allKeywords, options: FuzzyOptions(threshold: 0.4));
  }

  String findClosestMatch(String userInput) {
    // Use fuzzy search to find the best match
    var result = _fuzzySearch.search(userInput);

    if (result.isNotEmpty) {
      String matchedWord = result.first.item;

      // Find the corresponding emoji
      for (var entry in _keywordToEmoji.entries) {
        if (entry.key.contains(matchedWord)) {
          return entry.value;
        }
      }
    }
    return "🤷"; // Default emoji if no match is found
  }
}
