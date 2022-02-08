 String setCelValue(String cellValue) {
  switch (cellValue) {
    case 'id':
      return 'ردیف';
    case 'timeOut':
      return 'زمان خروج';
    case 'dateOut':
      return 'تاریخ خروج';
    case 'timeIn':
      return 'زمان ورود';
    case 'dateIn':
      return 'تاریخ ورود';
    case 'ship':
      return 'شماره حواله';
    case 'farahmand':
      return 'سبد فرهمند';
    case 'prePack':
      return 'سبد پری پک';
    case 'driverName':
      return 'نام و نام خانوادگی عامل';
    default:
      return '';
  }
}