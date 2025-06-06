import 'dart:math';

class AvataarGenerator {
  static final Random _random = Random();
  
  // Background colors array
  static final List<String> _backgroundColors = [
    'ff6b6b', // Red
    '4ecdc4', // Teal
    '45b7d1', // Blue
    '96ceb4', // Green
    'feca57', // Yellow
    'ff9ff3', // Pink
    'a55eea', // Purple
    'fd79a8', // Rose
    '00b894', // Emerald
    'fdcb6e', // Orange
    '6c5ce7', // Indigo
    'fd7272', // Coral
    '00cec9', // Cyan
    'a29bfe', // Lavender
    'ffc107', // Amber
  ];
  
  // Mouth options for smiles
  static final List<String> _mouthOptions = [
    'smile',
    'twinkle',
    'default',
  ];
  
  // Eye options
  static final List<String> _eyeOptions = [
    'default',
    'happy',
    'wink',
    'close',
  ];
  
  // Hair options
  static final List<String> _hairOptions = [
    'shortHair',
    'longHair',
    'curly',
    'straight',
    'wavy',
  ];
  
  // Clothing options
  static final List<String> _clothingOptions = [
    'blazer',
    'sweater',
    'shirt',
    'hoodie',
    'overall',
  ];
  
  // Accessories options
  static final List<String> _accessoriesOptions = [
    'none',
    'eyepatch',
    'wayfarers',
    'sunglasses',
  ];
  
  /// Generate a random avataaars URL
  static String generateAvatarUrl({String? seed}) {
    final useSeed = seed ?? _generateRandomSeed();
    final backgroundColor = _backgroundColors[_random.nextInt(_backgroundColors.length)];
    final mouth = _mouthOptions[_random.nextInt(_mouthOptions.length)];
    final eyes = _eyeOptions[_random.nextInt(_eyeOptions.length)];
    final hair = _hairOptions[_random.nextInt(_hairOptions.length)];
    final clothing = _clothingOptions[_random.nextInt(_clothingOptions.length)];
    final accessories = _accessoriesOptions[_random.nextInt(_accessoriesOptions.length)];
    
    return 'https://api.dicebear.com/7.x/avataaars/svg?'
        'seed=$useSeed&'
        'backgroundColor=$backgroundColor&'
        'mouth=$mouth&'
        'eyes=$eyes&'
        'hair=$hair&'
        'clothing=$clothing&'
        'accessories=$accessories&'
        'facialHair=none'; // No facial hair as requested
  }
  
  /// Generate a random seed for unique avatars
  static String _generateRandomSeed() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(Iterable.generate(
      8, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }
}