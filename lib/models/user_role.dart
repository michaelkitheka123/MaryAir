enum UserRole {
  customer,
  pilot,
  staff,
  attendant,
  admin;

  String get displayName {
    switch (this) {
      case UserRole.customer:
        return 'Customer';
      case UserRole.pilot:
        return 'Pilot';
      case UserRole.staff:
        return 'Staff';
      case UserRole.attendant:
        return 'Flight Attendant';
      case UserRole.admin:
        return 'Administrator';
    }
  }

  String get description {
    switch (this) {
      case UserRole.customer:
        return 'Book flights and manage reservations';
      case UserRole.pilot:
        return 'Manage flight operations';
      case UserRole.staff:
        return 'Handle customer service';
      case UserRole.attendant:
        return 'Provide in-flight services';
      case UserRole.admin:
        return 'Full system access';
    }
  }
}
