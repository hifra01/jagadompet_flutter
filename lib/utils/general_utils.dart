String getCategoryFromCategoryId(String categoryId) {
  Map categoryList = {
    'out_food': 'Makanan & minuman',
    'out_daily': 'Kebutuhan sehari-hari',
    'out_education': 'Pendidikan',
    'out_health': 'Kesehatan',
    'out_other': 'Lain-lain'
  };
  return categoryList[categoryId];
}

String getSourceFromSourceId(String sourceId) {
  Map sourceList = {
    'in_salary': 'Gaji',
    'in_prize': 'Hadiah',
    'in_inheritance': 'Warisan',
    'in_investment': 'Investasi',
    'in_other': 'Lain-lain'
  };
  return sourceList[sourceId];
}
