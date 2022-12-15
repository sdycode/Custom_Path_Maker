  checkIsItValidHexString(String hex) {
    if (!(hex.length == 6 || hex.length == 8)) {
      return false;
    }

    int? dd = int.tryParse(hex, radix: 16);

    if (dd == null) {
      return false;
    } else {
      return true;
    }

  }