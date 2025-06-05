import 'package:fuzzy/fuzzy.dart'; // Optimized string matching

class EmojiMatcher {


  static final Map<List<String>, String> _keywordToEmoji = {
  ["anda", "anday", "egg", "eggs", "andae"]: "🥚",
  ["kaleji", "liver", "beef", "gosht", "gosht ka", "bakra", "meat", "mutton"]: "🍖",
  ["chicken", "murgh", "murgi", "chickens"]: "🍗",
  ["chai", "tea", "chai saman", "chaaye", "chai patti", "tea bag"]: "☕",
  ["pizza", "burger", "shawarma", "fries", "zinger", "sandwich"]: "🍕",
  ["biryani", "pulao", "rice", "chawal", "fried rice"]: "🍚",
  ["khana", "meal", "dinner", "lunch", "nashta", "subah ka nashta", "breakfast", "fasting meal"]: "🍛",
  ["raat ka khana", "dinner"]: "🍽️",
  ["roti", "rotian", "naan", "chapati", "tandoori roti", "paratha", "naan bread"]: "🥙",
  ["roti + chany", "chana", "chickpeas", "chana masala", "halwa puri"]: "🍛",
  ["dahi", "yogurt", "curd", "lassi"]: "🥛",
  ["doodh", "milk", "full cream", "toned milk", "low fat milk"]: "🥛",
  ["cheese", "paneer", "cottage cheese"]: "🧀",
  ["sabzi", "vegetable", "vegetables", "sabzian", "tarkari", "tarkarian", "palak"]: "🥬",
  ["baingan", "eggplant", "brinjal"]: "🍆",
  ["aloo", "potato", "batata", "french fries"]: "🥔",
  ["pyaz", "onion", "piaz", "piyaz"]: "🧅",
  ["gajar", "carrot", "carrots"]: "🥕",
  ["tamatar", "tomato", "tomatoes"]: "🍅",
  ["methi", "fenugreek"]: "🌿",
  ["gobi", "cauliflower"]: "🥦",
  ["band gobi", "cabbage"]: "🥬",
  ["shimla mirch", "capsicum", "bell pepper"]: "🫑",
  ["adrak", "ginger"]: "🫚",
  ["lahsun", "garlic"]: "🧄",
  ["aam", "mango", "mangos"]: "🥭",
  ["seb", "apple", "apples"]: "🍏",
  ["kela", "banana", "bananas"]: "🍌",
  ["tarbooz", "watermelon", "melon"]: "🍉",
  ["anar", "pomegranate"]: "🍎",
  ["nashpati", "pear"]: "🍐",
  ["angoor", "grapes"]: "🍇",
  ["lemon", "nimbu"]: "🍋",
  ["santra", "orange", "oranges"]: "🍊",
  ["strawberry", "strawberries"]: "🍓",
  ["pineapple", "ananas"]: "🍍",
  ["halwa", "sweets", "dessert", "mithai", "gulab jamun", "rasgulla"]: "🍩",
  ["cake", "pastry", "chocolate cake"]: "🎂",
  ["biscuit", "cookies", "biscuits"]: "🍪",
  ["bread", "slice bread", "double roti"]: "🍞",
  ["dal", "lentils", "daal", "dal chawal"]: "🍜",
  ["kadhi", "kadi"]: "🍲",
  ["keema"]: "🥩",
  ["chips", "lays", "snack", "nimko"]: "🍿",
  ["namkeen"]: "🥨",
  ["baby milk", "formula"]: "🍼",
  ["diapers", "nappies"]: "🧷",
  ["medicine", "tablet", "syrup", "dawai", "meds"]: "💊",
  ["detergent", "soap", "surf", "cleaning"]: "🧼",
  ["toothpaste", "brush", "toothbrush"]: "🪥",
  ["sanitary pad", "pads"]: "🩸",
  ["ghee", "butter"]: "🧈",
  ["honey", "shehad"]: "🍯",
  ["shopping", "mall", "market", "bazar", "superstore", "grocery"]: "🛍️",
  ["kapray", "clothes", "clothing", "shirt", "pant", "trouser", "jeans", "kurta", "shalwar kameez"]: "👕",
  ["rent", "hostel", "ghar ka kiraya", "home rent", "house rent"]: "🏠",
  ["party", "celebration", "event", "birthday", "birthday party"]: "🎉",
  ["ramadan", "eid", "festival", "iftar", "sahoor"]: "🎊",
  ["shadi", "wedding", "mehndi", "baraat"]: "💍",
  ["trip", "vacation", "travel", "journey", "safar", "road trip", "train journey"]: "✈️",
  ["ticket", "bus ticket", "airline ticket", "train ticket"]: "🎟️",
  ["debt", "loan", "karza", "udhaar", "credit", "borrowed money"]: "💳",
  ["salary", "wages", "paycheck", "income"]: "💵",
  ["cash", "paisa", "rupay", "rupees", "money"]: "🏦",
  ["coffee", "cappuccino", "latte", "espresso"]: "☕",
  ["cold drink", "soda", "soft drink", "coke", "pepsi", "sprite", "fanta"]: "🥤",
  ["juice", "fresh juice", "orange juice", "apple juice"]: "🧃",
  ["movie", "cinema", "film", "theater", "watch movie"]: "🎬",
  ["game", "gaming", "video game", "esports"]: "🎮",
  ["default"]: "📦",
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
    return "📦"; // Default emoji if no match is found
  }
}
