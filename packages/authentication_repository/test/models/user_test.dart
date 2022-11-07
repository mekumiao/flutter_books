import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    const id = 'mock-id';
    const name = 'mock-name';

    test('uses value equality', () {
      expect(
        const User(name: name, id: id),
        equals(const User(name: name, id: id)),
      );
    });

    test('isEmpty returns true for empty user', () {
      expect(User.empty.isEmpty, isTrue);
    });

    test('isEmpty returns false for non-name user', () {
      const user = User(name: name, id: id);
      expect(user.isEmpty, isFalse);
    });

    test('isNotEmpty returns false for empty user', () {
      expect(User.empty.isNotEmpty, isFalse);
    });

    test('isNotEmpty returns true for non-name user', () {
      const user = User(name: name, id: id);
      expect(user.isNotEmpty, isTrue);
    });

    test('isAdmin returns false for non-role user', () {
      const user = User(role: ['user', 'sale'], id: id);
      expect(user.isAdmin, isFalse);
    });

    test('isAdmin returns true for role user', () {
      const user = User(role: ['admin', 'user'], id: id);
      expect(user.isAdmin, isTrue);
    });
  });
}
