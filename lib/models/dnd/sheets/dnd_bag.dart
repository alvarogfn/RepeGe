enum DndCurrencyTypes {
  copper(multiplier: 0.01),
  silver(multiplier: 0.10),
  electrum(multiplier: 0.50),
  gold(multiplier: 1.0),
  platinum(multiplier: 10.0);

  const DndCurrencyTypes({required this.multiplier});

  final double multiplier;
}

class DndSheetWallet {
  final int copper;
  final int silver;
  final int electrum;
  final int gold;
  final int platinum;

  const DndSheetWallet({
    this.copper = 0,
    this.silver = 0,
    this.electrum = 0,
    this.gold = 0,
    this.platinum = 0,
  });

  totalMoney(DndCurrencyTypes type) {
    return 0;
  }
}

class DndSheetBag {
  final DndSheetWallet wallet;
  final List<Object> items;

  const DndSheetBag({
    this.wallet = const DndSheetWallet(),
    this.items = const [],
  });
}
