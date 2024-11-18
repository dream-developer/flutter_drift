String validateContent(String? value) {
  final v = (value ?? '');
  final vLen = v.length;
  if (vLen <= 0 || vLen > 100) {
    return '100文字以内で入力してください';
  }
  return '';
}