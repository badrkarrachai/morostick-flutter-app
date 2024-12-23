class NumberFormatter {
  static String formatCount(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      double result = number / 1000;
      // If the decimal part is 0, return without decimals
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}K';
    } else {
      double result = number / 1000000;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}M';
    }
  }
}

extension StringExt on String {
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) {
      return this;
    }
    return '${substring(0, maxLength)}$ellipsis';
  }

  String get capitalizeFirst {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get capitalizeEachWord {
    if (isEmpty) return this;
    return split(' ').map((str) => str.capitalizeFirst).join(' ');
  }

  String limitWords(
    int words, {
    String ellipsis = '...',
    bool addEllipsis = true,
    bool preserveWord = true,
  }) {
    if (isEmpty) return this;

    final wordsList = split(' ');
    if (wordsList.length <= words) {
      return this;
    }

    if (preserveWord) {
      return '${wordsList.take(words).join(' ')}${addEllipsis ? ellipsis : ''}';
    }

    // Calculate total characters in first [words] words
    final limitedText = wordsList.take(words).join(' ');
    if (!addEllipsis) return limitedText;

    return '$limitedText$ellipsis';
  }

  String limitCharacters(
    int chars, {
    String ellipsis = '...',
    bool addEllipsis = true,
    bool preserveWord = true,
  }) {
    if (length <= chars) return this;

    if (!preserveWord) {
      return '${substring(0, chars)}${addEllipsis ? ellipsis : ''}';
    }

    // Find the last space within the character limit
    final lastSpace = substring(0, chars).lastIndexOf(' ');
    if (lastSpace == -1) {
      return '${substring(0, chars)}${addEllipsis ? ellipsis : ''}';
    }

    return '${substring(0, lastSpace)}${addEllipsis ? ellipsis : ''}';
  }

  /// Breaks the string into lines without cutting words and returns it as a single string.
  /// Each line does not exceed [maxLength] and is separated by a newline character.
  String breakLines(int maxLength) {
    if (isEmpty || maxLength <= 0) return this;

    final words = split(' ');
    final buffer = StringBuffer();
    var currentLine = '';

    for (final word in words) {
      if ((currentLine + word).length <= maxLength) {
        currentLine += (currentLine.isEmpty ? '' : ' ') + word;
      } else {
        buffer.writeln(currentLine);
        currentLine = word;
      }
    }

    if (currentLine.isNotEmpty) {
      buffer.writeln(currentLine);
    }

    return buffer.toString().trim();
  }
}
