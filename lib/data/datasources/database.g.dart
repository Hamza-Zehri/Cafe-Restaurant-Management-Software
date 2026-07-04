// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
mixin _$DealDaoMixin on DatabaseAccessor<AppDatabase> {
  $DealsTable get deals => attachedDatabase.deals;
  $MenuGroupsTable get menuGroups => attachedDatabase.menuGroups;
  $MenuItemsTable get menuItems => attachedDatabase.menuItems;
  $DealItemsTable get dealItems => attachedDatabase.dealItems;
  $BackupHistoriesTable get backupHistories => attachedDatabase.backupHistories;
}
mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
}
mixin _$TableDaoMixin on DatabaseAccessor<AppDatabase> {
  $FloorsTable get floors => attachedDatabase.floors;
  $RestaurantTablesTable get restaurantTables =>
      attachedDatabase.restaurantTables;
}
mixin _$MenuDaoMixin on DatabaseAccessor<AppDatabase> {
  $MenuGroupsTable get menuGroups => attachedDatabase.menuGroups;
  $MenuItemsTable get menuItems => attachedDatabase.menuItems;
}
mixin _$OrderDaoMixin on DatabaseAccessor<AppDatabase> {
  $FloorsTable get floors => attachedDatabase.floors;
  $RestaurantTablesTable get restaurantTables =>
      attachedDatabase.restaurantTables;
  $UsersTable get users => attachedDatabase.users;
  $OrdersTable get orders => attachedDatabase.orders;
  $MenuGroupsTable get menuGroups => attachedDatabase.menuGroups;
  $MenuItemsTable get menuItems => attachedDatabase.menuItems;
  $DealsTable get deals => attachedDatabase.deals;
  $OrderItemsTable get orderItems => attachedDatabase.orderItems;
}
mixin _$InvoiceDaoMixin on DatabaseAccessor<AppDatabase> {
  $FloorsTable get floors => attachedDatabase.floors;
  $RestaurantTablesTable get restaurantTables =>
      attachedDatabase.restaurantTables;
  $UsersTable get users => attachedDatabase.users;
  $OrdersTable get orders => attachedDatabase.orders;
  $InvoicesTable get invoices => attachedDatabase.invoices;
}
mixin _$CustomerDaoMixin on DatabaseAccessor<AppDatabase> {
  $CustomersTable get customers => attachedDatabase.customers;
  $CreditLedgerTable get creditLedger => attachedDatabase.creditLedger;
}
mixin _$RegisterDaoMixin on DatabaseAccessor<AppDatabase> {
  $CashRegistersTable get cashRegisters => attachedDatabase.cashRegisters;
  $ExpensesTable get expenses => attachedDatabase.expenses;
}
mixin _$HRDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $AttendanceTable get attendance => attachedDatabase.attendance;
  $SalaryPaymentsTable get salaryPayments => attachedDatabase.salaryPayments;
}
mixin _$SettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AppSettingsTable get appSettings => attachedDatabase.appSettings;
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _passwordHashMeta =
      const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
      'password_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _salaryMeta = const VerificationMeta('salary');
  @override
  late final GeneratedColumn<double> salary = GeneratedColumn<double>(
      'salary', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _wageTypeMeta =
      const VerificationMeta('wageType');
  @override
  late final GeneratedColumn<String> wageType = GeneratedColumn<String>(
      'wage_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('monthly'));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _permissionsJsonMeta =
      const VerificationMeta('permissionsJson');
  @override
  late final GeneratedColumn<String> permissionsJson = GeneratedColumn<String>(
      'permissions_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        email,
        passwordHash,
        role,
        phone,
        photoPath,
        salary,
        wageType,
        isActive,
        permissionsJson,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
          _passwordHashMeta,
          passwordHash.isAcceptableOrUnknown(
              data['password_hash']!, _passwordHashMeta));
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('salary')) {
      context.handle(_salaryMeta,
          salary.isAcceptableOrUnknown(data['salary']!, _salaryMeta));
    }
    if (data.containsKey('wage_type')) {
      context.handle(_wageTypeMeta,
          wageType.isAcceptableOrUnknown(data['wage_type']!, _wageTypeMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('permissions_json')) {
      context.handle(
          _permissionsJsonMeta,
          permissionsJson.isAcceptableOrUnknown(
              data['permissions_json']!, _permissionsJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      passwordHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_hash'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      salary: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}salary'])!,
      wageType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wage_type'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      permissionsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}permissions_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String email;
  final String passwordHash;
  final String role;
  final String? phone;
  final String? photoPath;
  final double salary;
  final String wageType;
  final bool isActive;
  final String permissionsJson;
  final DateTime createdAt;
  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.passwordHash,
      required this.role,
      this.phone,
      this.photoPath,
      required this.salary,
      required this.wageType,
      required this.isActive,
      required this.permissionsJson,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['password_hash'] = Variable<String>(passwordHash);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['salary'] = Variable<double>(salary);
    map['wage_type'] = Variable<String>(wageType);
    map['is_active'] = Variable<bool>(isActive);
    map['permissions_json'] = Variable<String>(permissionsJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      passwordHash: Value(passwordHash),
      role: Value(role),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      salary: Value(salary),
      wageType: Value(wageType),
      isActive: Value(isActive),
      permissionsJson: Value(permissionsJson),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      role: serializer.fromJson<String>(json['role']),
      phone: serializer.fromJson<String?>(json['phone']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      salary: serializer.fromJson<double>(json['salary']),
      wageType: serializer.fromJson<String>(json['wageType']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      permissionsJson: serializer.fromJson<String>(json['permissionsJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'role': serializer.toJson<String>(role),
      'phone': serializer.toJson<String?>(phone),
      'photoPath': serializer.toJson<String?>(photoPath),
      'salary': serializer.toJson<double>(salary),
      'wageType': serializer.toJson<String>(wageType),
      'isActive': serializer.toJson<bool>(isActive),
      'permissionsJson': serializer.toJson<String>(permissionsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith(
          {int? id,
          String? name,
          String? email,
          String? passwordHash,
          String? role,
          Value<String?> phone = const Value.absent(),
          Value<String?> photoPath = const Value.absent(),
          double? salary,
          String? wageType,
          bool? isActive,
          String? permissionsJson,
          DateTime? createdAt}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        role: role ?? this.role,
        phone: phone.present ? phone.value : this.phone,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        salary: salary ?? this.salary,
        wageType: wageType ?? this.wageType,
        isActive: isActive ?? this.isActive,
        permissionsJson: permissionsJson ?? this.permissionsJson,
        createdAt: createdAt ?? this.createdAt,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      role: data.role.present ? data.role.value : this.role,
      phone: data.phone.present ? data.phone.value : this.phone,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      salary: data.salary.present ? data.salary.value : this.salary,
      wageType: data.wageType.present ? data.wageType.value : this.wageType,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      permissionsJson: data.permissionsJson.present
          ? data.permissionsJson.value
          : this.permissionsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('phone: $phone, ')
          ..write('photoPath: $photoPath, ')
          ..write('salary: $salary, ')
          ..write('wageType: $wageType, ')
          ..write('isActive: $isActive, ')
          ..write('permissionsJson: $permissionsJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, passwordHash, role, phone,
      photoPath, salary, wageType, isActive, permissionsJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.role == this.role &&
          other.phone == this.phone &&
          other.photoPath == this.photoPath &&
          other.salary == this.salary &&
          other.wageType == this.wageType &&
          other.isActive == this.isActive &&
          other.permissionsJson == this.permissionsJson &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> passwordHash;
  final Value<String> role;
  final Value<String?> phone;
  final Value<String?> photoPath;
  final Value<double> salary;
  final Value<String> wageType;
  final Value<bool> isActive;
  final Value<String> permissionsJson;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.role = const Value.absent(),
    this.phone = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.salary = const Value.absent(),
    this.wageType = const Value.absent(),
    this.isActive = const Value.absent(),
    this.permissionsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    required String passwordHash,
    required String role,
    this.phone = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.salary = const Value.absent(),
    this.wageType = const Value.absent(),
    this.isActive = const Value.absent(),
    this.permissionsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : name = Value(name),
        email = Value(email),
        passwordHash = Value(passwordHash),
        role = Value(role);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<String>? role,
    Expression<String>? phone,
    Expression<String>? photoPath,
    Expression<double>? salary,
    Expression<String>? wageType,
    Expression<bool>? isActive,
    Expression<String>? permissionsJson,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (role != null) 'role': role,
      if (phone != null) 'phone': phone,
      if (photoPath != null) 'photo_path': photoPath,
      if (salary != null) 'salary': salary,
      if (wageType != null) 'wage_type': wageType,
      if (isActive != null) 'is_active': isActive,
      if (permissionsJson != null) 'permissions_json': permissionsJson,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? email,
      Value<String>? passwordHash,
      Value<String>? role,
      Value<String?>? phone,
      Value<String?>? photoPath,
      Value<double>? salary,
      Value<String>? wageType,
      Value<bool>? isActive,
      Value<String>? permissionsJson,
      Value<DateTime>? createdAt}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      photoPath: photoPath ?? this.photoPath,
      salary: salary ?? this.salary,
      wageType: wageType ?? this.wageType,
      isActive: isActive ?? this.isActive,
      permissionsJson: permissionsJson ?? this.permissionsJson,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (salary.present) {
      map['salary'] = Variable<double>(salary.value);
    }
    if (wageType.present) {
      map['wage_type'] = Variable<String>(wageType.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (permissionsJson.present) {
      map['permissions_json'] = Variable<String>(permissionsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('phone: $phone, ')
          ..write('photoPath: $photoPath, ')
          ..write('salary: $salary, ')
          ..write('wageType: $wageType, ')
          ..write('isActive: $isActive, ')
          ..write('permissionsJson: $permissionsJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FloorsTable extends Floors with TableInfo<$FloorsTable, Floor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FloorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, name, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'floors';
  @override
  VerificationContext validateIntegrity(Insertable<Floor> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Floor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Floor(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $FloorsTable createAlias(String alias) {
    return $FloorsTable(attachedDatabase, alias);
  }
}

class Floor extends DataClass implements Insertable<Floor> {
  final int id;
  final String name;
  final int sortOrder;
  const Floor({required this.id, required this.name, required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  FloorsCompanion toCompanion(bool nullToAbsent) {
    return FloorsCompanion(
      id: Value(id),
      name: Value(name),
      sortOrder: Value(sortOrder),
    );
  }

  factory Floor.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Floor(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Floor copyWith({int? id, String? name, int? sortOrder}) => Floor(
        id: id ?? this.id,
        name: name ?? this.name,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  Floor copyWithCompanion(FloorsCompanion data) {
    return Floor(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Floor(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Floor &&
          other.id == this.id &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder);
}

class FloorsCompanion extends UpdateCompanion<Floor> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> sortOrder;
  const FloorsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  FloorsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.sortOrder = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Floor> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  FloorsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? sortOrder}) {
    return FloorsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FloorsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $RestaurantTablesTable extends RestaurantTables
    with TableInfo<$RestaurantTablesTable, RestaurantTable> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RestaurantTablesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _floorIdMeta =
      const VerificationMeta('floorId');
  @override
  late final GeneratedColumn<int> floorId = GeneratedColumn<int>(
      'floor_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES floors (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _capacityMeta =
      const VerificationMeta('capacity');
  @override
  late final GeneratedColumn<int> capacity = GeneratedColumn<int>(
      'capacity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(4));
  static const VerificationMeta _shapeMeta = const VerificationMeta('shape');
  @override
  late final GeneratedColumn<String> shape = GeneratedColumn<String>(
      'shape', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('rectangle'));
  static const VerificationMeta _posXMeta = const VerificationMeta('posX');
  @override
  late final GeneratedColumn<double> posX = GeneratedColumn<double>(
      'pos_x', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(50.0));
  static const VerificationMeta _posYMeta = const VerificationMeta('posY');
  @override
  late final GeneratedColumn<double> posY = GeneratedColumn<double>(
      'pos_y', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(50.0));
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double> width = GeneratedColumn<double>(
      'width', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(120.0));
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(90.0));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('available'));
  static const VerificationMeta _activeOrderIdMeta =
      const VerificationMeta('activeOrderId');
  @override
  late final GeneratedColumn<int> activeOrderId = GeneratedColumn<int>(
      'active_order_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _waiterNameMeta =
      const VerificationMeta('waiterName');
  @override
  late final GeneratedColumn<String> waiterName = GeneratedColumn<String>(
      'waiter_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _guestCountMeta =
      const VerificationMeta('guestCount');
  @override
  late final GeneratedColumn<int> guestCount = GeneratedColumn<int>(
      'guest_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _runningTotalMeta =
      const VerificationMeta('runningTotal');
  @override
  late final GeneratedColumn<double> runningTotal = GeneratedColumn<double>(
      'running_total', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _orderStartTimeMeta =
      const VerificationMeta('orderStartTime');
  @override
  late final GeneratedColumn<DateTime> orderStartTime =
      GeneratedColumn<DateTime>('order_start_time', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        floorId,
        name,
        capacity,
        shape,
        posX,
        posY,
        width,
        height,
        status,
        activeOrderId,
        waiterName,
        guestCount,
        runningTotal,
        orderStartTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'restaurant_tables';
  @override
  VerificationContext validateIntegrity(Insertable<RestaurantTable> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('floor_id')) {
      context.handle(_floorIdMeta,
          floorId.isAcceptableOrUnknown(data['floor_id']!, _floorIdMeta));
    } else if (isInserting) {
      context.missing(_floorIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('capacity')) {
      context.handle(_capacityMeta,
          capacity.isAcceptableOrUnknown(data['capacity']!, _capacityMeta));
    }
    if (data.containsKey('shape')) {
      context.handle(
          _shapeMeta, shape.isAcceptableOrUnknown(data['shape']!, _shapeMeta));
    }
    if (data.containsKey('pos_x')) {
      context.handle(
          _posXMeta, posX.isAcceptableOrUnknown(data['pos_x']!, _posXMeta));
    }
    if (data.containsKey('pos_y')) {
      context.handle(
          _posYMeta, posY.isAcceptableOrUnknown(data['pos_y']!, _posYMeta));
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('active_order_id')) {
      context.handle(
          _activeOrderIdMeta,
          activeOrderId.isAcceptableOrUnknown(
              data['active_order_id']!, _activeOrderIdMeta));
    }
    if (data.containsKey('waiter_name')) {
      context.handle(
          _waiterNameMeta,
          waiterName.isAcceptableOrUnknown(
              data['waiter_name']!, _waiterNameMeta));
    }
    if (data.containsKey('guest_count')) {
      context.handle(
          _guestCountMeta,
          guestCount.isAcceptableOrUnknown(
              data['guest_count']!, _guestCountMeta));
    }
    if (data.containsKey('running_total')) {
      context.handle(
          _runningTotalMeta,
          runningTotal.isAcceptableOrUnknown(
              data['running_total']!, _runningTotalMeta));
    }
    if (data.containsKey('order_start_time')) {
      context.handle(
          _orderStartTimeMeta,
          orderStartTime.isAcceptableOrUnknown(
              data['order_start_time']!, _orderStartTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RestaurantTable map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RestaurantTable(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      floorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}floor_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      capacity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}capacity'])!,
      shape: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shape'])!,
      posX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}pos_x'])!,
      posY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}pos_y'])!,
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}width'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      activeOrderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}active_order_id']),
      waiterName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}waiter_name']),
      guestCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}guest_count'])!,
      runningTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}running_total'])!,
      orderStartTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}order_start_time']),
    );
  }

  @override
  $RestaurantTablesTable createAlias(String alias) {
    return $RestaurantTablesTable(attachedDatabase, alias);
  }
}

class RestaurantTable extends DataClass implements Insertable<RestaurantTable> {
  final int id;
  final int floorId;
  final String name;
  final int capacity;
  final String shape;
  final double posX;
  final double posY;
  final double width;
  final double height;
  final String status;
  final int? activeOrderId;
  final String? waiterName;
  final int guestCount;
  final double runningTotal;
  final DateTime? orderStartTime;
  const RestaurantTable(
      {required this.id,
      required this.floorId,
      required this.name,
      required this.capacity,
      required this.shape,
      required this.posX,
      required this.posY,
      required this.width,
      required this.height,
      required this.status,
      this.activeOrderId,
      this.waiterName,
      required this.guestCount,
      required this.runningTotal,
      this.orderStartTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['floor_id'] = Variable<int>(floorId);
    map['name'] = Variable<String>(name);
    map['capacity'] = Variable<int>(capacity);
    map['shape'] = Variable<String>(shape);
    map['pos_x'] = Variable<double>(posX);
    map['pos_y'] = Variable<double>(posY);
    map['width'] = Variable<double>(width);
    map['height'] = Variable<double>(height);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || activeOrderId != null) {
      map['active_order_id'] = Variable<int>(activeOrderId);
    }
    if (!nullToAbsent || waiterName != null) {
      map['waiter_name'] = Variable<String>(waiterName);
    }
    map['guest_count'] = Variable<int>(guestCount);
    map['running_total'] = Variable<double>(runningTotal);
    if (!nullToAbsent || orderStartTime != null) {
      map['order_start_time'] = Variable<DateTime>(orderStartTime);
    }
    return map;
  }

  RestaurantTablesCompanion toCompanion(bool nullToAbsent) {
    return RestaurantTablesCompanion(
      id: Value(id),
      floorId: Value(floorId),
      name: Value(name),
      capacity: Value(capacity),
      shape: Value(shape),
      posX: Value(posX),
      posY: Value(posY),
      width: Value(width),
      height: Value(height),
      status: Value(status),
      activeOrderId: activeOrderId == null && nullToAbsent
          ? const Value.absent()
          : Value(activeOrderId),
      waiterName: waiterName == null && nullToAbsent
          ? const Value.absent()
          : Value(waiterName),
      guestCount: Value(guestCount),
      runningTotal: Value(runningTotal),
      orderStartTime: orderStartTime == null && nullToAbsent
          ? const Value.absent()
          : Value(orderStartTime),
    );
  }

  factory RestaurantTable.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RestaurantTable(
      id: serializer.fromJson<int>(json['id']),
      floorId: serializer.fromJson<int>(json['floorId']),
      name: serializer.fromJson<String>(json['name']),
      capacity: serializer.fromJson<int>(json['capacity']),
      shape: serializer.fromJson<String>(json['shape']),
      posX: serializer.fromJson<double>(json['posX']),
      posY: serializer.fromJson<double>(json['posY']),
      width: serializer.fromJson<double>(json['width']),
      height: serializer.fromJson<double>(json['height']),
      status: serializer.fromJson<String>(json['status']),
      activeOrderId: serializer.fromJson<int?>(json['activeOrderId']),
      waiterName: serializer.fromJson<String?>(json['waiterName']),
      guestCount: serializer.fromJson<int>(json['guestCount']),
      runningTotal: serializer.fromJson<double>(json['runningTotal']),
      orderStartTime: serializer.fromJson<DateTime?>(json['orderStartTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'floorId': serializer.toJson<int>(floorId),
      'name': serializer.toJson<String>(name),
      'capacity': serializer.toJson<int>(capacity),
      'shape': serializer.toJson<String>(shape),
      'posX': serializer.toJson<double>(posX),
      'posY': serializer.toJson<double>(posY),
      'width': serializer.toJson<double>(width),
      'height': serializer.toJson<double>(height),
      'status': serializer.toJson<String>(status),
      'activeOrderId': serializer.toJson<int?>(activeOrderId),
      'waiterName': serializer.toJson<String?>(waiterName),
      'guestCount': serializer.toJson<int>(guestCount),
      'runningTotal': serializer.toJson<double>(runningTotal),
      'orderStartTime': serializer.toJson<DateTime?>(orderStartTime),
    };
  }

  RestaurantTable copyWith(
          {int? id,
          int? floorId,
          String? name,
          int? capacity,
          String? shape,
          double? posX,
          double? posY,
          double? width,
          double? height,
          String? status,
          Value<int?> activeOrderId = const Value.absent(),
          Value<String?> waiterName = const Value.absent(),
          int? guestCount,
          double? runningTotal,
          Value<DateTime?> orderStartTime = const Value.absent()}) =>
      RestaurantTable(
        id: id ?? this.id,
        floorId: floorId ?? this.floorId,
        name: name ?? this.name,
        capacity: capacity ?? this.capacity,
        shape: shape ?? this.shape,
        posX: posX ?? this.posX,
        posY: posY ?? this.posY,
        width: width ?? this.width,
        height: height ?? this.height,
        status: status ?? this.status,
        activeOrderId:
            activeOrderId.present ? activeOrderId.value : this.activeOrderId,
        waiterName: waiterName.present ? waiterName.value : this.waiterName,
        guestCount: guestCount ?? this.guestCount,
        runningTotal: runningTotal ?? this.runningTotal,
        orderStartTime:
            orderStartTime.present ? orderStartTime.value : this.orderStartTime,
      );
  RestaurantTable copyWithCompanion(RestaurantTablesCompanion data) {
    return RestaurantTable(
      id: data.id.present ? data.id.value : this.id,
      floorId: data.floorId.present ? data.floorId.value : this.floorId,
      name: data.name.present ? data.name.value : this.name,
      capacity: data.capacity.present ? data.capacity.value : this.capacity,
      shape: data.shape.present ? data.shape.value : this.shape,
      posX: data.posX.present ? data.posX.value : this.posX,
      posY: data.posY.present ? data.posY.value : this.posY,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      status: data.status.present ? data.status.value : this.status,
      activeOrderId: data.activeOrderId.present
          ? data.activeOrderId.value
          : this.activeOrderId,
      waiterName:
          data.waiterName.present ? data.waiterName.value : this.waiterName,
      guestCount:
          data.guestCount.present ? data.guestCount.value : this.guestCount,
      runningTotal: data.runningTotal.present
          ? data.runningTotal.value
          : this.runningTotal,
      orderStartTime: data.orderStartTime.present
          ? data.orderStartTime.value
          : this.orderStartTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RestaurantTable(')
          ..write('id: $id, ')
          ..write('floorId: $floorId, ')
          ..write('name: $name, ')
          ..write('capacity: $capacity, ')
          ..write('shape: $shape, ')
          ..write('posX: $posX, ')
          ..write('posY: $posY, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('status: $status, ')
          ..write('activeOrderId: $activeOrderId, ')
          ..write('waiterName: $waiterName, ')
          ..write('guestCount: $guestCount, ')
          ..write('runningTotal: $runningTotal, ')
          ..write('orderStartTime: $orderStartTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      floorId,
      name,
      capacity,
      shape,
      posX,
      posY,
      width,
      height,
      status,
      activeOrderId,
      waiterName,
      guestCount,
      runningTotal,
      orderStartTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RestaurantTable &&
          other.id == this.id &&
          other.floorId == this.floorId &&
          other.name == this.name &&
          other.capacity == this.capacity &&
          other.shape == this.shape &&
          other.posX == this.posX &&
          other.posY == this.posY &&
          other.width == this.width &&
          other.height == this.height &&
          other.status == this.status &&
          other.activeOrderId == this.activeOrderId &&
          other.waiterName == this.waiterName &&
          other.guestCount == this.guestCount &&
          other.runningTotal == this.runningTotal &&
          other.orderStartTime == this.orderStartTime);
}

class RestaurantTablesCompanion extends UpdateCompanion<RestaurantTable> {
  final Value<int> id;
  final Value<int> floorId;
  final Value<String> name;
  final Value<int> capacity;
  final Value<String> shape;
  final Value<double> posX;
  final Value<double> posY;
  final Value<double> width;
  final Value<double> height;
  final Value<String> status;
  final Value<int?> activeOrderId;
  final Value<String?> waiterName;
  final Value<int> guestCount;
  final Value<double> runningTotal;
  final Value<DateTime?> orderStartTime;
  const RestaurantTablesCompanion({
    this.id = const Value.absent(),
    this.floorId = const Value.absent(),
    this.name = const Value.absent(),
    this.capacity = const Value.absent(),
    this.shape = const Value.absent(),
    this.posX = const Value.absent(),
    this.posY = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.status = const Value.absent(),
    this.activeOrderId = const Value.absent(),
    this.waiterName = const Value.absent(),
    this.guestCount = const Value.absent(),
    this.runningTotal = const Value.absent(),
    this.orderStartTime = const Value.absent(),
  });
  RestaurantTablesCompanion.insert({
    this.id = const Value.absent(),
    required int floorId,
    required String name,
    this.capacity = const Value.absent(),
    this.shape = const Value.absent(),
    this.posX = const Value.absent(),
    this.posY = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.status = const Value.absent(),
    this.activeOrderId = const Value.absent(),
    this.waiterName = const Value.absent(),
    this.guestCount = const Value.absent(),
    this.runningTotal = const Value.absent(),
    this.orderStartTime = const Value.absent(),
  })  : floorId = Value(floorId),
        name = Value(name);
  static Insertable<RestaurantTable> custom({
    Expression<int>? id,
    Expression<int>? floorId,
    Expression<String>? name,
    Expression<int>? capacity,
    Expression<String>? shape,
    Expression<double>? posX,
    Expression<double>? posY,
    Expression<double>? width,
    Expression<double>? height,
    Expression<String>? status,
    Expression<int>? activeOrderId,
    Expression<String>? waiterName,
    Expression<int>? guestCount,
    Expression<double>? runningTotal,
    Expression<DateTime>? orderStartTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (floorId != null) 'floor_id': floorId,
      if (name != null) 'name': name,
      if (capacity != null) 'capacity': capacity,
      if (shape != null) 'shape': shape,
      if (posX != null) 'pos_x': posX,
      if (posY != null) 'pos_y': posY,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (status != null) 'status': status,
      if (activeOrderId != null) 'active_order_id': activeOrderId,
      if (waiterName != null) 'waiter_name': waiterName,
      if (guestCount != null) 'guest_count': guestCount,
      if (runningTotal != null) 'running_total': runningTotal,
      if (orderStartTime != null) 'order_start_time': orderStartTime,
    });
  }

  RestaurantTablesCompanion copyWith(
      {Value<int>? id,
      Value<int>? floorId,
      Value<String>? name,
      Value<int>? capacity,
      Value<String>? shape,
      Value<double>? posX,
      Value<double>? posY,
      Value<double>? width,
      Value<double>? height,
      Value<String>? status,
      Value<int?>? activeOrderId,
      Value<String?>? waiterName,
      Value<int>? guestCount,
      Value<double>? runningTotal,
      Value<DateTime?>? orderStartTime}) {
    return RestaurantTablesCompanion(
      id: id ?? this.id,
      floorId: floorId ?? this.floorId,
      name: name ?? this.name,
      capacity: capacity ?? this.capacity,
      shape: shape ?? this.shape,
      posX: posX ?? this.posX,
      posY: posY ?? this.posY,
      width: width ?? this.width,
      height: height ?? this.height,
      status: status ?? this.status,
      activeOrderId: activeOrderId ?? this.activeOrderId,
      waiterName: waiterName ?? this.waiterName,
      guestCount: guestCount ?? this.guestCount,
      runningTotal: runningTotal ?? this.runningTotal,
      orderStartTime: orderStartTime ?? this.orderStartTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (floorId.present) {
      map['floor_id'] = Variable<int>(floorId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (capacity.present) {
      map['capacity'] = Variable<int>(capacity.value);
    }
    if (shape.present) {
      map['shape'] = Variable<String>(shape.value);
    }
    if (posX.present) {
      map['pos_x'] = Variable<double>(posX.value);
    }
    if (posY.present) {
      map['pos_y'] = Variable<double>(posY.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (activeOrderId.present) {
      map['active_order_id'] = Variable<int>(activeOrderId.value);
    }
    if (waiterName.present) {
      map['waiter_name'] = Variable<String>(waiterName.value);
    }
    if (guestCount.present) {
      map['guest_count'] = Variable<int>(guestCount.value);
    }
    if (runningTotal.present) {
      map['running_total'] = Variable<double>(runningTotal.value);
    }
    if (orderStartTime.present) {
      map['order_start_time'] = Variable<DateTime>(orderStartTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestaurantTablesCompanion(')
          ..write('id: $id, ')
          ..write('floorId: $floorId, ')
          ..write('name: $name, ')
          ..write('capacity: $capacity, ')
          ..write('shape: $shape, ')
          ..write('posX: $posX, ')
          ..write('posY: $posY, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('status: $status, ')
          ..write('activeOrderId: $activeOrderId, ')
          ..write('waiterName: $waiterName, ')
          ..write('guestCount: $guestCount, ')
          ..write('runningTotal: $runningTotal, ')
          ..write('orderStartTime: $orderStartTime')
          ..write(')'))
        .toString();
  }
}

class $MenuGroupsTable extends MenuGroups
    with TableInfo<$MenuGroupsTable, MenuGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconPathMeta =
      const VerificationMeta('iconPath');
  @override
  late final GeneratedColumn<String> iconPath = GeneratedColumn<String>(
      'icon_path', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('#1A56DB'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, iconPath, colorHex, sortOrder, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_groups';
  @override
  VerificationContext validateIntegrity(Insertable<MenuGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_path')) {
      context.handle(_iconPathMeta,
          iconPath.isAcceptableOrUnknown(data['icon_path']!, _iconPathMeta));
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenuGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuGroup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      iconPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_path'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $MenuGroupsTable createAlias(String alias) {
    return $MenuGroupsTable(attachedDatabase, alias);
  }
}

class MenuGroup extends DataClass implements Insertable<MenuGroup> {
  final int id;
  final String name;
  final String iconPath;
  final String colorHex;
  final int sortOrder;
  final bool isActive;
  const MenuGroup(
      {required this.id,
      required this.name,
      required this.iconPath,
      required this.colorHex,
      required this.sortOrder,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon_path'] = Variable<String>(iconPath);
    map['color_hex'] = Variable<String>(colorHex);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  MenuGroupsCompanion toCompanion(bool nullToAbsent) {
    return MenuGroupsCompanion(
      id: Value(id),
      name: Value(name),
      iconPath: Value(iconPath),
      colorHex: Value(colorHex),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
    );
  }

  factory MenuGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuGroup(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconPath: serializer.fromJson<String>(json['iconPath']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'iconPath': serializer.toJson<String>(iconPath),
      'colorHex': serializer.toJson<String>(colorHex),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  MenuGroup copyWith(
          {int? id,
          String? name,
          String? iconPath,
          String? colorHex,
          int? sortOrder,
          bool? isActive}) =>
      MenuGroup(
        id: id ?? this.id,
        name: name ?? this.name,
        iconPath: iconPath ?? this.iconPath,
        colorHex: colorHex ?? this.colorHex,
        sortOrder: sortOrder ?? this.sortOrder,
        isActive: isActive ?? this.isActive,
      );
  MenuGroup copyWithCompanion(MenuGroupsCompanion data) {
    return MenuGroup(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      iconPath: data.iconPath.present ? data.iconPath.value : this.iconPath,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuGroup(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconPath: $iconPath, ')
          ..write('colorHex: $colorHex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, iconPath, colorHex, sortOrder, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuGroup &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconPath == this.iconPath &&
          other.colorHex == this.colorHex &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive);
}

class MenuGroupsCompanion extends UpdateCompanion<MenuGroup> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> iconPath;
  final Value<String> colorHex;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  const MenuGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconPath = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  MenuGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.iconPath = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : name = Value(name);
  static Insertable<MenuGroup> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? iconPath,
    Expression<String>? colorHex,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconPath != null) 'icon_path': iconPath,
      if (colorHex != null) 'color_hex': colorHex,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
    });
  }

  MenuGroupsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? iconPath,
      Value<String>? colorHex,
      Value<int>? sortOrder,
      Value<bool>? isActive}) {
    return MenuGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconPath: iconPath ?? this.iconPath,
      colorHex: colorHex ?? this.colorHex,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconPath.present) {
      map['icon_path'] = Variable<String>(iconPath.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenuGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconPath: $iconPath, ')
          ..write('colorHex: $colorHex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $MenuItemsTable extends MenuItems
    with TableInfo<$MenuItemsTable, MenuItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenuItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
      'group_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES menu_groups (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _costPriceMeta =
      const VerificationMeta('costPrice');
  @override
  late final GeneratedColumn<double> costPrice = GeneratedColumn<double>(
      'cost_price', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _preparationMinutesMeta =
      const VerificationMeta('preparationMinutes');
  @override
  late final GeneratedColumn<int> preparationMinutes = GeneratedColumn<int>(
      'preparation_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(10));
  static const VerificationMeta _isAvailableMeta =
      const VerificationMeta('isAvailable');
  @override
  late final GeneratedColumn<bool> isAvailable = GeneratedColumn<bool>(
      'is_available', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_available" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _stockCountMeta =
      const VerificationMeta('stockCount');
  @override
  late final GeneratedColumn<int> stockCount = GeneratedColumn<int>(
      'stock_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(-1));
  static const VerificationMeta _taxPercentMeta =
      const VerificationMeta('taxPercent');
  @override
  late final GeneratedColumn<double> taxPercent = GeneratedColumn<double>(
      'tax_percent', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        groupId,
        name,
        price,
        costPrice,
        description,
        imagePath,
        preparationMinutes,
        isAvailable,
        stockCount,
        taxPercent,
        sortOrder
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menu_items';
  @override
  VerificationContext validateIntegrity(Insertable<MenuItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('cost_price')) {
      context.handle(_costPriceMeta,
          costPrice.isAcceptableOrUnknown(data['cost_price']!, _costPriceMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('preparation_minutes')) {
      context.handle(
          _preparationMinutesMeta,
          preparationMinutes.isAcceptableOrUnknown(
              data['preparation_minutes']!, _preparationMinutesMeta));
    }
    if (data.containsKey('is_available')) {
      context.handle(
          _isAvailableMeta,
          isAvailable.isAcceptableOrUnknown(
              data['is_available']!, _isAvailableMeta));
    }
    if (data.containsKey('stock_count')) {
      context.handle(
          _stockCountMeta,
          stockCount.isAcceptableOrUnknown(
              data['stock_count']!, _stockCountMeta));
    }
    if (data.containsKey('tax_percent')) {
      context.handle(
          _taxPercentMeta,
          taxPercent.isAcceptableOrUnknown(
              data['tax_percent']!, _taxPercentMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenuItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenuItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      costPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cost_price'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      preparationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}preparation_minutes'])!,
      isAvailable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_available'])!,
      stockCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock_count'])!,
      taxPercent: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tax_percent'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $MenuItemsTable createAlias(String alias) {
    return $MenuItemsTable(attachedDatabase, alias);
  }
}

class MenuItem extends DataClass implements Insertable<MenuItem> {
  final int id;
  final int groupId;
  final String name;
  final double price;
  final double costPrice;
  final String? description;
  final String? imagePath;
  final int preparationMinutes;
  final bool isAvailable;
  final int stockCount;
  final double taxPercent;
  final int sortOrder;
  const MenuItem(
      {required this.id,
      required this.groupId,
      required this.name,
      required this.price,
      required this.costPrice,
      this.description,
      this.imagePath,
      required this.preparationMinutes,
      required this.isAvailable,
      required this.stockCount,
      required this.taxPercent,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_id'] = Variable<int>(groupId);
    map['name'] = Variable<String>(name);
    map['price'] = Variable<double>(price);
    map['cost_price'] = Variable<double>(costPrice);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['preparation_minutes'] = Variable<int>(preparationMinutes);
    map['is_available'] = Variable<bool>(isAvailable);
    map['stock_count'] = Variable<int>(stockCount);
    map['tax_percent'] = Variable<double>(taxPercent);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  MenuItemsCompanion toCompanion(bool nullToAbsent) {
    return MenuItemsCompanion(
      id: Value(id),
      groupId: Value(groupId),
      name: Value(name),
      price: Value(price),
      costPrice: Value(costPrice),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      preparationMinutes: Value(preparationMinutes),
      isAvailable: Value(isAvailable),
      stockCount: Value(stockCount),
      taxPercent: Value(taxPercent),
      sortOrder: Value(sortOrder),
    );
  }

  factory MenuItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenuItem(
      id: serializer.fromJson<int>(json['id']),
      groupId: serializer.fromJson<int>(json['groupId']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<double>(json['price']),
      costPrice: serializer.fromJson<double>(json['costPrice']),
      description: serializer.fromJson<String?>(json['description']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      preparationMinutes: serializer.fromJson<int>(json['preparationMinutes']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
      stockCount: serializer.fromJson<int>(json['stockCount']),
      taxPercent: serializer.fromJson<double>(json['taxPercent']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupId': serializer.toJson<int>(groupId),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<double>(price),
      'costPrice': serializer.toJson<double>(costPrice),
      'description': serializer.toJson<String?>(description),
      'imagePath': serializer.toJson<String?>(imagePath),
      'preparationMinutes': serializer.toJson<int>(preparationMinutes),
      'isAvailable': serializer.toJson<bool>(isAvailable),
      'stockCount': serializer.toJson<int>(stockCount),
      'taxPercent': serializer.toJson<double>(taxPercent),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  MenuItem copyWith(
          {int? id,
          int? groupId,
          String? name,
          double? price,
          double? costPrice,
          Value<String?> description = const Value.absent(),
          Value<String?> imagePath = const Value.absent(),
          int? preparationMinutes,
          bool? isAvailable,
          int? stockCount,
          double? taxPercent,
          int? sortOrder}) =>
      MenuItem(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        name: name ?? this.name,
        price: price ?? this.price,
        costPrice: costPrice ?? this.costPrice,
        description: description.present ? description.value : this.description,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        preparationMinutes: preparationMinutes ?? this.preparationMinutes,
        isAvailable: isAvailable ?? this.isAvailable,
        stockCount: stockCount ?? this.stockCount,
        taxPercent: taxPercent ?? this.taxPercent,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  MenuItem copyWithCompanion(MenuItemsCompanion data) {
    return MenuItem(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      name: data.name.present ? data.name.value : this.name,
      price: data.price.present ? data.price.value : this.price,
      costPrice: data.costPrice.present ? data.costPrice.value : this.costPrice,
      description:
          data.description.present ? data.description.value : this.description,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      preparationMinutes: data.preparationMinutes.present
          ? data.preparationMinutes.value
          : this.preparationMinutes,
      isAvailable:
          data.isAvailable.present ? data.isAvailable.value : this.isAvailable,
      stockCount:
          data.stockCount.present ? data.stockCount.value : this.stockCount,
      taxPercent:
          data.taxPercent.present ? data.taxPercent.value : this.taxPercent,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenuItem(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('costPrice: $costPrice, ')
          ..write('description: $description, ')
          ..write('imagePath: $imagePath, ')
          ..write('preparationMinutes: $preparationMinutes, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('stockCount: $stockCount, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      groupId,
      name,
      price,
      costPrice,
      description,
      imagePath,
      preparationMinutes,
      isAvailable,
      stockCount,
      taxPercent,
      sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenuItem &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.name == this.name &&
          other.price == this.price &&
          other.costPrice == this.costPrice &&
          other.description == this.description &&
          other.imagePath == this.imagePath &&
          other.preparationMinutes == this.preparationMinutes &&
          other.isAvailable == this.isAvailable &&
          other.stockCount == this.stockCount &&
          other.taxPercent == this.taxPercent &&
          other.sortOrder == this.sortOrder);
}

class MenuItemsCompanion extends UpdateCompanion<MenuItem> {
  final Value<int> id;
  final Value<int> groupId;
  final Value<String> name;
  final Value<double> price;
  final Value<double> costPrice;
  final Value<String?> description;
  final Value<String?> imagePath;
  final Value<int> preparationMinutes;
  final Value<bool> isAvailable;
  final Value<int> stockCount;
  final Value<double> taxPercent;
  final Value<int> sortOrder;
  const MenuItemsCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.costPrice = const Value.absent(),
    this.description = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.preparationMinutes = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.stockCount = const Value.absent(),
    this.taxPercent = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  MenuItemsCompanion.insert({
    this.id = const Value.absent(),
    required int groupId,
    required String name,
    required double price,
    this.costPrice = const Value.absent(),
    this.description = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.preparationMinutes = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.stockCount = const Value.absent(),
    this.taxPercent = const Value.absent(),
    this.sortOrder = const Value.absent(),
  })  : groupId = Value(groupId),
        name = Value(name),
        price = Value(price);
  static Insertable<MenuItem> custom({
    Expression<int>? id,
    Expression<int>? groupId,
    Expression<String>? name,
    Expression<double>? price,
    Expression<double>? costPrice,
    Expression<String>? description,
    Expression<String>? imagePath,
    Expression<int>? preparationMinutes,
    Expression<bool>? isAvailable,
    Expression<int>? stockCount,
    Expression<double>? taxPercent,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (costPrice != null) 'cost_price': costPrice,
      if (description != null) 'description': description,
      if (imagePath != null) 'image_path': imagePath,
      if (preparationMinutes != null) 'preparation_minutes': preparationMinutes,
      if (isAvailable != null) 'is_available': isAvailable,
      if (stockCount != null) 'stock_count': stockCount,
      if (taxPercent != null) 'tax_percent': taxPercent,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  MenuItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? groupId,
      Value<String>? name,
      Value<double>? price,
      Value<double>? costPrice,
      Value<String?>? description,
      Value<String?>? imagePath,
      Value<int>? preparationMinutes,
      Value<bool>? isAvailable,
      Value<int>? stockCount,
      Value<double>? taxPercent,
      Value<int>? sortOrder}) {
    return MenuItemsCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      price: price ?? this.price,
      costPrice: costPrice ?? this.costPrice,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      preparationMinutes: preparationMinutes ?? this.preparationMinutes,
      isAvailable: isAvailable ?? this.isAvailable,
      stockCount: stockCount ?? this.stockCount,
      taxPercent: taxPercent ?? this.taxPercent,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (costPrice.present) {
      map['cost_price'] = Variable<double>(costPrice.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (preparationMinutes.present) {
      map['preparation_minutes'] = Variable<int>(preparationMinutes.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    if (stockCount.present) {
      map['stock_count'] = Variable<int>(stockCount.value);
    }
    if (taxPercent.present) {
      map['tax_percent'] = Variable<double>(taxPercent.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenuItemsCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('costPrice: $costPrice, ')
          ..write('description: $description, ')
          ..write('imagePath: $imagePath, ')
          ..write('preparationMinutes: $preparationMinutes, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('stockCount: $stockCount, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _orderNumberMeta =
      const VerificationMeta('orderNumber');
  @override
  late final GeneratedColumn<String> orderNumber = GeneratedColumn<String>(
      'order_number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _tableIdMeta =
      const VerificationMeta('tableId');
  @override
  late final GeneratedColumn<int> tableId = GeneratedColumn<int>(
      'table_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES restaurant_tables (id)'));
  static const VerificationMeta _tableNameColMeta =
      const VerificationMeta('tableNameCol');
  @override
  late final GeneratedColumn<String> tableNameCol = GeneratedColumn<String>(
      'table_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _waiterIdMeta =
      const VerificationMeta('waiterId');
  @override
  late final GeneratedColumn<int> waiterId = GeneratedColumn<int>(
      'waiter_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _waiterNameMeta =
      const VerificationMeta('waiterName');
  @override
  late final GeneratedColumn<String> waiterName = GeneratedColumn<String>(
      'waiter_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('open'));
  static const VerificationMeta _discountPercentMeta =
      const VerificationMeta('discountPercent');
  @override
  late final GeneratedColumn<double> discountPercent = GeneratedColumn<double>(
      'discount_percent', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _discountAmountMeta =
      const VerificationMeta('discountAmount');
  @override
  late final GeneratedColumn<double> discountAmount = GeneratedColumn<double>(
      'discount_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _taxPercentMeta =
      const VerificationMeta('taxPercent');
  @override
  late final GeneratedColumn<double> taxPercent = GeneratedColumn<double>(
      'tax_percent', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _serviceChargePercentMeta =
      const VerificationMeta('serviceChargePercent');
  @override
  late final GeneratedColumn<double> serviceChargePercent =
      GeneratedColumn<double>('service_charge_percent', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _kitchenTicketCountMeta =
      const VerificationMeta('kitchenTicketCount');
  @override
  late final GeneratedColumn<int> kitchenTicketCount = GeneratedColumn<int>(
      'kitchen_ticket_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _guestCountMeta =
      const VerificationMeta('guestCount');
  @override
  late final GeneratedColumn<int> guestCount = GeneratedColumn<int>(
      'guest_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
      'paid_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        orderNumber,
        tableId,
        tableNameCol,
        waiterId,
        waiterName,
        status,
        discountPercent,
        discountAmount,
        taxPercent,
        serviceChargePercent,
        notes,
        kitchenTicketCount,
        guestCount,
        createdAt,
        paidAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<Order> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_number')) {
      context.handle(
          _orderNumberMeta,
          orderNumber.isAcceptableOrUnknown(
              data['order_number']!, _orderNumberMeta));
    } else if (isInserting) {
      context.missing(_orderNumberMeta);
    }
    if (data.containsKey('table_id')) {
      context.handle(_tableIdMeta,
          tableId.isAcceptableOrUnknown(data['table_id']!, _tableIdMeta));
    } else if (isInserting) {
      context.missing(_tableIdMeta);
    }
    if (data.containsKey('table_name')) {
      context.handle(
          _tableNameColMeta,
          tableNameCol.isAcceptableOrUnknown(
              data['table_name']!, _tableNameColMeta));
    } else if (isInserting) {
      context.missing(_tableNameColMeta);
    }
    if (data.containsKey('waiter_id')) {
      context.handle(_waiterIdMeta,
          waiterId.isAcceptableOrUnknown(data['waiter_id']!, _waiterIdMeta));
    } else if (isInserting) {
      context.missing(_waiterIdMeta);
    }
    if (data.containsKey('waiter_name')) {
      context.handle(
          _waiterNameMeta,
          waiterName.isAcceptableOrUnknown(
              data['waiter_name']!, _waiterNameMeta));
    } else if (isInserting) {
      context.missing(_waiterNameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
          _discountPercentMeta,
          discountPercent.isAcceptableOrUnknown(
              data['discount_percent']!, _discountPercentMeta));
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
          _discountAmountMeta,
          discountAmount.isAcceptableOrUnknown(
              data['discount_amount']!, _discountAmountMeta));
    }
    if (data.containsKey('tax_percent')) {
      context.handle(
          _taxPercentMeta,
          taxPercent.isAcceptableOrUnknown(
              data['tax_percent']!, _taxPercentMeta));
    }
    if (data.containsKey('service_charge_percent')) {
      context.handle(
          _serviceChargePercentMeta,
          serviceChargePercent.isAcceptableOrUnknown(
              data['service_charge_percent']!, _serviceChargePercentMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('kitchen_ticket_count')) {
      context.handle(
          _kitchenTicketCountMeta,
          kitchenTicketCount.isAcceptableOrUnknown(
              data['kitchen_ticket_count']!, _kitchenTicketCountMeta));
    }
    if (data.containsKey('guest_count')) {
      context.handle(
          _guestCountMeta,
          guestCount.isAcceptableOrUnknown(
              data['guest_count']!, _guestCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('paid_at')) {
      context.handle(_paidAtMeta,
          paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      orderNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_number'])!,
      tableId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}table_id'])!,
      tableNameCol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}table_name'])!,
      waiterId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}waiter_id'])!,
      waiterName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}waiter_name'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      discountPercent: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}discount_percent'])!,
      discountAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}discount_amount'])!,
      taxPercent: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tax_percent'])!,
      serviceChargePercent: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}service_charge_percent'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      kitchenTicketCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}kitchen_ticket_count'])!,
      guestCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}guest_count'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      paidAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}paid_at']),
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final int id;
  final String orderNumber;
  final int tableId;
  final String tableNameCol;
  final int waiterId;
  final String waiterName;
  final String status;
  final double discountPercent;
  final double discountAmount;
  final double taxPercent;
  final double serviceChargePercent;
  final String notes;
  final int kitchenTicketCount;
  final int guestCount;
  final DateTime createdAt;
  final DateTime? paidAt;
  const Order(
      {required this.id,
      required this.orderNumber,
      required this.tableId,
      required this.tableNameCol,
      required this.waiterId,
      required this.waiterName,
      required this.status,
      required this.discountPercent,
      required this.discountAmount,
      required this.taxPercent,
      required this.serviceChargePercent,
      required this.notes,
      required this.kitchenTicketCount,
      required this.guestCount,
      required this.createdAt,
      this.paidAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_number'] = Variable<String>(orderNumber);
    map['table_id'] = Variable<int>(tableId);
    map['table_name'] = Variable<String>(tableNameCol);
    map['waiter_id'] = Variable<int>(waiterId);
    map['waiter_name'] = Variable<String>(waiterName);
    map['status'] = Variable<String>(status);
    map['discount_percent'] = Variable<double>(discountPercent);
    map['discount_amount'] = Variable<double>(discountAmount);
    map['tax_percent'] = Variable<double>(taxPercent);
    map['service_charge_percent'] = Variable<double>(serviceChargePercent);
    map['notes'] = Variable<String>(notes);
    map['kitchen_ticket_count'] = Variable<int>(kitchenTicketCount);
    map['guest_count'] = Variable<int>(guestCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || paidAt != null) {
      map['paid_at'] = Variable<DateTime>(paidAt);
    }
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      orderNumber: Value(orderNumber),
      tableId: Value(tableId),
      tableNameCol: Value(tableNameCol),
      waiterId: Value(waiterId),
      waiterName: Value(waiterName),
      status: Value(status),
      discountPercent: Value(discountPercent),
      discountAmount: Value(discountAmount),
      taxPercent: Value(taxPercent),
      serviceChargePercent: Value(serviceChargePercent),
      notes: Value(notes),
      kitchenTicketCount: Value(kitchenTicketCount),
      guestCount: Value(guestCount),
      createdAt: Value(createdAt),
      paidAt:
          paidAt == null && nullToAbsent ? const Value.absent() : Value(paidAt),
    );
  }

  factory Order.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<int>(json['id']),
      orderNumber: serializer.fromJson<String>(json['orderNumber']),
      tableId: serializer.fromJson<int>(json['tableId']),
      tableNameCol: serializer.fromJson<String>(json['tableNameCol']),
      waiterId: serializer.fromJson<int>(json['waiterId']),
      waiterName: serializer.fromJson<String>(json['waiterName']),
      status: serializer.fromJson<String>(json['status']),
      discountPercent: serializer.fromJson<double>(json['discountPercent']),
      discountAmount: serializer.fromJson<double>(json['discountAmount']),
      taxPercent: serializer.fromJson<double>(json['taxPercent']),
      serviceChargePercent:
          serializer.fromJson<double>(json['serviceChargePercent']),
      notes: serializer.fromJson<String>(json['notes']),
      kitchenTicketCount: serializer.fromJson<int>(json['kitchenTicketCount']),
      guestCount: serializer.fromJson<int>(json['guestCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      paidAt: serializer.fromJson<DateTime?>(json['paidAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderNumber': serializer.toJson<String>(orderNumber),
      'tableId': serializer.toJson<int>(tableId),
      'tableNameCol': serializer.toJson<String>(tableNameCol),
      'waiterId': serializer.toJson<int>(waiterId),
      'waiterName': serializer.toJson<String>(waiterName),
      'status': serializer.toJson<String>(status),
      'discountPercent': serializer.toJson<double>(discountPercent),
      'discountAmount': serializer.toJson<double>(discountAmount),
      'taxPercent': serializer.toJson<double>(taxPercent),
      'serviceChargePercent': serializer.toJson<double>(serviceChargePercent),
      'notes': serializer.toJson<String>(notes),
      'kitchenTicketCount': serializer.toJson<int>(kitchenTicketCount),
      'guestCount': serializer.toJson<int>(guestCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'paidAt': serializer.toJson<DateTime?>(paidAt),
    };
  }

  Order copyWith(
          {int? id,
          String? orderNumber,
          int? tableId,
          String? tableNameCol,
          int? waiterId,
          String? waiterName,
          String? status,
          double? discountPercent,
          double? discountAmount,
          double? taxPercent,
          double? serviceChargePercent,
          String? notes,
          int? kitchenTicketCount,
          int? guestCount,
          DateTime? createdAt,
          Value<DateTime?> paidAt = const Value.absent()}) =>
      Order(
        id: id ?? this.id,
        orderNumber: orderNumber ?? this.orderNumber,
        tableId: tableId ?? this.tableId,
        tableNameCol: tableNameCol ?? this.tableNameCol,
        waiterId: waiterId ?? this.waiterId,
        waiterName: waiterName ?? this.waiterName,
        status: status ?? this.status,
        discountPercent: discountPercent ?? this.discountPercent,
        discountAmount: discountAmount ?? this.discountAmount,
        taxPercent: taxPercent ?? this.taxPercent,
        serviceChargePercent: serviceChargePercent ?? this.serviceChargePercent,
        notes: notes ?? this.notes,
        kitchenTicketCount: kitchenTicketCount ?? this.kitchenTicketCount,
        guestCount: guestCount ?? this.guestCount,
        createdAt: createdAt ?? this.createdAt,
        paidAt: paidAt.present ? paidAt.value : this.paidAt,
      );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      orderNumber:
          data.orderNumber.present ? data.orderNumber.value : this.orderNumber,
      tableId: data.tableId.present ? data.tableId.value : this.tableId,
      tableNameCol: data.tableNameCol.present
          ? data.tableNameCol.value
          : this.tableNameCol,
      waiterId: data.waiterId.present ? data.waiterId.value : this.waiterId,
      waiterName:
          data.waiterName.present ? data.waiterName.value : this.waiterName,
      status: data.status.present ? data.status.value : this.status,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      taxPercent:
          data.taxPercent.present ? data.taxPercent.value : this.taxPercent,
      serviceChargePercent: data.serviceChargePercent.present
          ? data.serviceChargePercent.value
          : this.serviceChargePercent,
      notes: data.notes.present ? data.notes.value : this.notes,
      kitchenTicketCount: data.kitchenTicketCount.present
          ? data.kitchenTicketCount.value
          : this.kitchenTicketCount,
      guestCount:
          data.guestCount.present ? data.guestCount.value : this.guestCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('tableId: $tableId, ')
          ..write('tableNameCol: $tableNameCol, ')
          ..write('waiterId: $waiterId, ')
          ..write('waiterName: $waiterName, ')
          ..write('status: $status, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('serviceChargePercent: $serviceChargePercent, ')
          ..write('notes: $notes, ')
          ..write('kitchenTicketCount: $kitchenTicketCount, ')
          ..write('guestCount: $guestCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('paidAt: $paidAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      orderNumber,
      tableId,
      tableNameCol,
      waiterId,
      waiterName,
      status,
      discountPercent,
      discountAmount,
      taxPercent,
      serviceChargePercent,
      notes,
      kitchenTicketCount,
      guestCount,
      createdAt,
      paidAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.orderNumber == this.orderNumber &&
          other.tableId == this.tableId &&
          other.tableNameCol == this.tableNameCol &&
          other.waiterId == this.waiterId &&
          other.waiterName == this.waiterName &&
          other.status == this.status &&
          other.discountPercent == this.discountPercent &&
          other.discountAmount == this.discountAmount &&
          other.taxPercent == this.taxPercent &&
          other.serviceChargePercent == this.serviceChargePercent &&
          other.notes == this.notes &&
          other.kitchenTicketCount == this.kitchenTicketCount &&
          other.guestCount == this.guestCount &&
          other.createdAt == this.createdAt &&
          other.paidAt == this.paidAt);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<int> id;
  final Value<String> orderNumber;
  final Value<int> tableId;
  final Value<String> tableNameCol;
  final Value<int> waiterId;
  final Value<String> waiterName;
  final Value<String> status;
  final Value<double> discountPercent;
  final Value<double> discountAmount;
  final Value<double> taxPercent;
  final Value<double> serviceChargePercent;
  final Value<String> notes;
  final Value<int> kitchenTicketCount;
  final Value<int> guestCount;
  final Value<DateTime> createdAt;
  final Value<DateTime?> paidAt;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.orderNumber = const Value.absent(),
    this.tableId = const Value.absent(),
    this.tableNameCol = const Value.absent(),
    this.waiterId = const Value.absent(),
    this.waiterName = const Value.absent(),
    this.status = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.taxPercent = const Value.absent(),
    this.serviceChargePercent = const Value.absent(),
    this.notes = const Value.absent(),
    this.kitchenTicketCount = const Value.absent(),
    this.guestCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.paidAt = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    required String orderNumber,
    required int tableId,
    required String tableNameCol,
    required int waiterId,
    required String waiterName,
    this.status = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.taxPercent = const Value.absent(),
    this.serviceChargePercent = const Value.absent(),
    this.notes = const Value.absent(),
    this.kitchenTicketCount = const Value.absent(),
    this.guestCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.paidAt = const Value.absent(),
  })  : orderNumber = Value(orderNumber),
        tableId = Value(tableId),
        tableNameCol = Value(tableNameCol),
        waiterId = Value(waiterId),
        waiterName = Value(waiterName);
  static Insertable<Order> custom({
    Expression<int>? id,
    Expression<String>? orderNumber,
    Expression<int>? tableId,
    Expression<String>? tableNameCol,
    Expression<int>? waiterId,
    Expression<String>? waiterName,
    Expression<String>? status,
    Expression<double>? discountPercent,
    Expression<double>? discountAmount,
    Expression<double>? taxPercent,
    Expression<double>? serviceChargePercent,
    Expression<String>? notes,
    Expression<int>? kitchenTicketCount,
    Expression<int>? guestCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? paidAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderNumber != null) 'order_number': orderNumber,
      if (tableId != null) 'table_id': tableId,
      if (tableNameCol != null) 'table_name': tableNameCol,
      if (waiterId != null) 'waiter_id': waiterId,
      if (waiterName != null) 'waiter_name': waiterName,
      if (status != null) 'status': status,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (taxPercent != null) 'tax_percent': taxPercent,
      if (serviceChargePercent != null)
        'service_charge_percent': serviceChargePercent,
      if (notes != null) 'notes': notes,
      if (kitchenTicketCount != null)
        'kitchen_ticket_count': kitchenTicketCount,
      if (guestCount != null) 'guest_count': guestCount,
      if (createdAt != null) 'created_at': createdAt,
      if (paidAt != null) 'paid_at': paidAt,
    });
  }

  OrdersCompanion copyWith(
      {Value<int>? id,
      Value<String>? orderNumber,
      Value<int>? tableId,
      Value<String>? tableNameCol,
      Value<int>? waiterId,
      Value<String>? waiterName,
      Value<String>? status,
      Value<double>? discountPercent,
      Value<double>? discountAmount,
      Value<double>? taxPercent,
      Value<double>? serviceChargePercent,
      Value<String>? notes,
      Value<int>? kitchenTicketCount,
      Value<int>? guestCount,
      Value<DateTime>? createdAt,
      Value<DateTime?>? paidAt}) {
    return OrdersCompanion(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      tableId: tableId ?? this.tableId,
      tableNameCol: tableNameCol ?? this.tableNameCol,
      waiterId: waiterId ?? this.waiterId,
      waiterName: waiterName ?? this.waiterName,
      status: status ?? this.status,
      discountPercent: discountPercent ?? this.discountPercent,
      discountAmount: discountAmount ?? this.discountAmount,
      taxPercent: taxPercent ?? this.taxPercent,
      serviceChargePercent: serviceChargePercent ?? this.serviceChargePercent,
      notes: notes ?? this.notes,
      kitchenTicketCount: kitchenTicketCount ?? this.kitchenTicketCount,
      guestCount: guestCount ?? this.guestCount,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt ?? this.paidAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderNumber.present) {
      map['order_number'] = Variable<String>(orderNumber.value);
    }
    if (tableId.present) {
      map['table_id'] = Variable<int>(tableId.value);
    }
    if (tableNameCol.present) {
      map['table_name'] = Variable<String>(tableNameCol.value);
    }
    if (waiterId.present) {
      map['waiter_id'] = Variable<int>(waiterId.value);
    }
    if (waiterName.present) {
      map['waiter_name'] = Variable<String>(waiterName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<double>(discountPercent.value);
    }
    if (discountAmount.present) {
      map['discount_amount'] = Variable<double>(discountAmount.value);
    }
    if (taxPercent.present) {
      map['tax_percent'] = Variable<double>(taxPercent.value);
    }
    if (serviceChargePercent.present) {
      map['service_charge_percent'] =
          Variable<double>(serviceChargePercent.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (kitchenTicketCount.present) {
      map['kitchen_ticket_count'] = Variable<int>(kitchenTicketCount.value);
    }
    if (guestCount.present) {
      map['guest_count'] = Variable<int>(guestCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('tableId: $tableId, ')
          ..write('tableNameCol: $tableNameCol, ')
          ..write('waiterId: $waiterId, ')
          ..write('waiterName: $waiterName, ')
          ..write('status: $status, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('taxPercent: $taxPercent, ')
          ..write('serviceChargePercent: $serviceChargePercent, ')
          ..write('notes: $notes, ')
          ..write('kitchenTicketCount: $kitchenTicketCount, ')
          ..write('guestCount: $guestCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('paidAt: $paidAt')
          ..write(')'))
        .toString();
  }
}

class $DealsTable extends Deals with TableInfo<$DealsTable, Deal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DealsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, code, price, description, isActive, imagePath, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deals';
  @override
  VerificationContext validateIntegrity(Insertable<Deal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Deal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Deal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DealsTable createAlias(String alias) {
    return $DealsTable(attachedDatabase, alias);
  }
}

class Deal extends DataClass implements Insertable<Deal> {
  final int id;
  final String name;
  final String? code;
  final double price;
  final String? description;
  final bool isActive;
  final String? imagePath;
  final DateTime createdAt;
  const Deal(
      {required this.id,
      required this.name,
      this.code,
      required this.price,
      this.description,
      required this.isActive,
      this.imagePath,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DealsCompanion toCompanion(bool nullToAbsent) {
    return DealsCompanion(
      id: Value(id),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      price: Value(price),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isActive: Value(isActive),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      createdAt: Value(createdAt),
    );
  }

  factory Deal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Deal(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      price: serializer.fromJson<double>(json['price']),
      description: serializer.fromJson<String?>(json['description']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'price': serializer.toJson<double>(price),
      'description': serializer.toJson<String?>(description),
      'isActive': serializer.toJson<bool>(isActive),
      'imagePath': serializer.toJson<String?>(imagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Deal copyWith(
          {int? id,
          String? name,
          Value<String?> code = const Value.absent(),
          double? price,
          Value<String?> description = const Value.absent(),
          bool? isActive,
          Value<String?> imagePath = const Value.absent(),
          DateTime? createdAt}) =>
      Deal(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code.present ? code.value : this.code,
        price: price ?? this.price,
        description: description.present ? description.value : this.description,
        isActive: isActive ?? this.isActive,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        createdAt: createdAt ?? this.createdAt,
      );
  Deal copyWithCompanion(DealsCompanion data) {
    return Deal(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      price: data.price.present ? data.price.value : this.price,
      description:
          data.description.present ? data.description.value : this.description,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Deal(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('price: $price, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, code, price, description, isActive, imagePath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Deal &&
          other.id == this.id &&
          other.name == this.name &&
          other.code == this.code &&
          other.price == this.price &&
          other.description == this.description &&
          other.isActive == this.isActive &&
          other.imagePath == this.imagePath &&
          other.createdAt == this.createdAt);
}

class DealsCompanion extends UpdateCompanion<Deal> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> code;
  final Value<double> price;
  final Value<String?> description;
  final Value<bool> isActive;
  final Value<String?> imagePath;
  final Value<DateTime> createdAt;
  const DealsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.price = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DealsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.code = const Value.absent(),
    required double price,
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : name = Value(name),
        price = Value(price);
  static Insertable<Deal> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? code,
    Expression<double>? price,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<String>? imagePath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (price != null) 'price': price,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (imagePath != null) 'image_path': imagePath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DealsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? code,
      Value<double>? price,
      Value<String?>? description,
      Value<bool>? isActive,
      Value<String?>? imagePath,
      Value<DateTime>? createdAt}) {
    return DealsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      price: price ?? this.price,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DealsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('price: $price, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $OrderItemsTable extends OrderItems
    with TableInfo<$OrderItemsTable, OrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
      'order_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES orders (id) ON DELETE CASCADE'));
  static const VerificationMeta _menuItemIdMeta =
      const VerificationMeta('menuItemId');
  @override
  late final GeneratedColumn<int> menuItemId = GeneratedColumn<int>(
      'menu_item_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES menu_items (id)'));
  static const VerificationMeta _menuItemNameMeta =
      const VerificationMeta('menuItemName');
  @override
  late final GeneratedColumn<String> menuItemName = GeneratedColumn<String>(
      'menu_item_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitPriceMeta =
      const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _modifiersJsonMeta =
      const VerificationMeta('modifiersJson');
  @override
  late final GeneratedColumn<String> modifiersJson = GeneratedColumn<String>(
      'modifiers_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _isVoidedMeta =
      const VerificationMeta('isVoided');
  @override
  late final GeneratedColumn<bool> isVoided = GeneratedColumn<bool>(
      'is_voided', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_voided" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _sentToKitchenAtMeta =
      const VerificationMeta('sentToKitchenAt');
  @override
  late final GeneratedColumn<DateTime> sentToKitchenAt =
      GeneratedColumn<DateTime>('sent_to_kitchen_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dealIdMeta = const VerificationMeta('dealId');
  @override
  late final GeneratedColumn<int> dealId = GeneratedColumn<int>(
      'deal_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES deals (id)'));
  static const VerificationMeta _dealItemsJsonMeta =
      const VerificationMeta('dealItemsJson');
  @override
  late final GeneratedColumn<String> dealItemsJson = GeneratedColumn<String>(
      'deal_items_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        orderId,
        menuItemId,
        menuItemName,
        unitPrice,
        quantity,
        notes,
        status,
        modifiersJson,
        isVoided,
        sentToKitchenAt,
        dealId,
        dealItemsJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_items';
  @override
  VerificationContext validateIntegrity(Insertable<OrderItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('menu_item_id')) {
      context.handle(
          _menuItemIdMeta,
          menuItemId.isAcceptableOrUnknown(
              data['menu_item_id']!, _menuItemIdMeta));
    } else if (isInserting) {
      context.missing(_menuItemIdMeta);
    }
    if (data.containsKey('menu_item_name')) {
      context.handle(
          _menuItemNameMeta,
          menuItemName.isAcceptableOrUnknown(
              data['menu_item_name']!, _menuItemNameMeta));
    } else if (isInserting) {
      context.missing(_menuItemNameMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('modifiers_json')) {
      context.handle(
          _modifiersJsonMeta,
          modifiersJson.isAcceptableOrUnknown(
              data['modifiers_json']!, _modifiersJsonMeta));
    }
    if (data.containsKey('is_voided')) {
      context.handle(_isVoidedMeta,
          isVoided.isAcceptableOrUnknown(data['is_voided']!, _isVoidedMeta));
    }
    if (data.containsKey('sent_to_kitchen_at')) {
      context.handle(
          _sentToKitchenAtMeta,
          sentToKitchenAt.isAcceptableOrUnknown(
              data['sent_to_kitchen_at']!, _sentToKitchenAtMeta));
    }
    if (data.containsKey('deal_id')) {
      context.handle(_dealIdMeta,
          dealId.isAcceptableOrUnknown(data['deal_id']!, _dealIdMeta));
    }
    if (data.containsKey('deal_items_json')) {
      context.handle(
          _dealItemsJsonMeta,
          dealItemsJson.isAcceptableOrUnknown(
              data['deal_items_json']!, _dealItemsJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_id'])!,
      menuItemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}menu_item_id'])!,
      menuItemName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}menu_item_name'])!,
      unitPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      modifiersJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}modifiers_json'])!,
      isVoided: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_voided'])!,
      sentToKitchenAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}sent_to_kitchen_at']),
      dealId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deal_id']),
      dealItemsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deal_items_json']),
    );
  }

  @override
  $OrderItemsTable createAlias(String alias) {
    return $OrderItemsTable(attachedDatabase, alias);
  }
}

class OrderItem extends DataClass implements Insertable<OrderItem> {
  final int id;
  final int orderId;
  final int menuItemId;
  final String menuItemName;
  final double unitPrice;
  final int quantity;
  final String notes;
  final String status;
  final String modifiersJson;
  final bool isVoided;
  final DateTime? sentToKitchenAt;
  final int? dealId;
  final String? dealItemsJson;
  const OrderItem(
      {required this.id,
      required this.orderId,
      required this.menuItemId,
      required this.menuItemName,
      required this.unitPrice,
      required this.quantity,
      required this.notes,
      required this.status,
      required this.modifiersJson,
      required this.isVoided,
      this.sentToKitchenAt,
      this.dealId,
      this.dealItemsJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['menu_item_id'] = Variable<int>(menuItemId);
    map['menu_item_name'] = Variable<String>(menuItemName);
    map['unit_price'] = Variable<double>(unitPrice);
    map['quantity'] = Variable<int>(quantity);
    map['notes'] = Variable<String>(notes);
    map['status'] = Variable<String>(status);
    map['modifiers_json'] = Variable<String>(modifiersJson);
    map['is_voided'] = Variable<bool>(isVoided);
    if (!nullToAbsent || sentToKitchenAt != null) {
      map['sent_to_kitchen_at'] = Variable<DateTime>(sentToKitchenAt);
    }
    if (!nullToAbsent || dealId != null) {
      map['deal_id'] = Variable<int>(dealId);
    }
    if (!nullToAbsent || dealItemsJson != null) {
      map['deal_items_json'] = Variable<String>(dealItemsJson);
    }
    return map;
  }

  OrderItemsCompanion toCompanion(bool nullToAbsent) {
    return OrderItemsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      menuItemId: Value(menuItemId),
      menuItemName: Value(menuItemName),
      unitPrice: Value(unitPrice),
      quantity: Value(quantity),
      notes: Value(notes),
      status: Value(status),
      modifiersJson: Value(modifiersJson),
      isVoided: Value(isVoided),
      sentToKitchenAt: sentToKitchenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(sentToKitchenAt),
      dealId:
          dealId == null && nullToAbsent ? const Value.absent() : Value(dealId),
      dealItemsJson: dealItemsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(dealItemsJson),
    );
  }

  factory OrderItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderItem(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      menuItemId: serializer.fromJson<int>(json['menuItemId']),
      menuItemName: serializer.fromJson<String>(json['menuItemName']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      quantity: serializer.fromJson<int>(json['quantity']),
      notes: serializer.fromJson<String>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      modifiersJson: serializer.fromJson<String>(json['modifiersJson']),
      isVoided: serializer.fromJson<bool>(json['isVoided']),
      sentToKitchenAt: serializer.fromJson<DateTime?>(json['sentToKitchenAt']),
      dealId: serializer.fromJson<int?>(json['dealId']),
      dealItemsJson: serializer.fromJson<String?>(json['dealItemsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'menuItemId': serializer.toJson<int>(menuItemId),
      'menuItemName': serializer.toJson<String>(menuItemName),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'quantity': serializer.toJson<int>(quantity),
      'notes': serializer.toJson<String>(notes),
      'status': serializer.toJson<String>(status),
      'modifiersJson': serializer.toJson<String>(modifiersJson),
      'isVoided': serializer.toJson<bool>(isVoided),
      'sentToKitchenAt': serializer.toJson<DateTime?>(sentToKitchenAt),
      'dealId': serializer.toJson<int?>(dealId),
      'dealItemsJson': serializer.toJson<String?>(dealItemsJson),
    };
  }

  OrderItem copyWith(
          {int? id,
          int? orderId,
          int? menuItemId,
          String? menuItemName,
          double? unitPrice,
          int? quantity,
          String? notes,
          String? status,
          String? modifiersJson,
          bool? isVoided,
          Value<DateTime?> sentToKitchenAt = const Value.absent(),
          Value<int?> dealId = const Value.absent(),
          Value<String?> dealItemsJson = const Value.absent()}) =>
      OrderItem(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        menuItemId: menuItemId ?? this.menuItemId,
        menuItemName: menuItemName ?? this.menuItemName,
        unitPrice: unitPrice ?? this.unitPrice,
        quantity: quantity ?? this.quantity,
        notes: notes ?? this.notes,
        status: status ?? this.status,
        modifiersJson: modifiersJson ?? this.modifiersJson,
        isVoided: isVoided ?? this.isVoided,
        sentToKitchenAt: sentToKitchenAt.present
            ? sentToKitchenAt.value
            : this.sentToKitchenAt,
        dealId: dealId.present ? dealId.value : this.dealId,
        dealItemsJson:
            dealItemsJson.present ? dealItemsJson.value : this.dealItemsJson,
      );
  OrderItem copyWithCompanion(OrderItemsCompanion data) {
    return OrderItem(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      menuItemId:
          data.menuItemId.present ? data.menuItemId.value : this.menuItemId,
      menuItemName: data.menuItemName.present
          ? data.menuItemName.value
          : this.menuItemName,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      modifiersJson: data.modifiersJson.present
          ? data.modifiersJson.value
          : this.modifiersJson,
      isVoided: data.isVoided.present ? data.isVoided.value : this.isVoided,
      sentToKitchenAt: data.sentToKitchenAt.present
          ? data.sentToKitchenAt.value
          : this.sentToKitchenAt,
      dealId: data.dealId.present ? data.dealId.value : this.dealId,
      dealItemsJson: data.dealItemsJson.present
          ? data.dealItemsJson.value
          : this.dealItemsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderItem(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('menuItemId: $menuItemId, ')
          ..write('menuItemName: $menuItemName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('quantity: $quantity, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('modifiersJson: $modifiersJson, ')
          ..write('isVoided: $isVoided, ')
          ..write('sentToKitchenAt: $sentToKitchenAt, ')
          ..write('dealId: $dealId, ')
          ..write('dealItemsJson: $dealItemsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      orderId,
      menuItemId,
      menuItemName,
      unitPrice,
      quantity,
      notes,
      status,
      modifiersJson,
      isVoided,
      sentToKitchenAt,
      dealId,
      dealItemsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderItem &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.menuItemId == this.menuItemId &&
          other.menuItemName == this.menuItemName &&
          other.unitPrice == this.unitPrice &&
          other.quantity == this.quantity &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.modifiersJson == this.modifiersJson &&
          other.isVoided == this.isVoided &&
          other.sentToKitchenAt == this.sentToKitchenAt &&
          other.dealId == this.dealId &&
          other.dealItemsJson == this.dealItemsJson);
}

class OrderItemsCompanion extends UpdateCompanion<OrderItem> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<int> menuItemId;
  final Value<String> menuItemName;
  final Value<double> unitPrice;
  final Value<int> quantity;
  final Value<String> notes;
  final Value<String> status;
  final Value<String> modifiersJson;
  final Value<bool> isVoided;
  final Value<DateTime?> sentToKitchenAt;
  final Value<int?> dealId;
  final Value<String?> dealItemsJson;
  const OrderItemsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.menuItemId = const Value.absent(),
    this.menuItemName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.modifiersJson = const Value.absent(),
    this.isVoided = const Value.absent(),
    this.sentToKitchenAt = const Value.absent(),
    this.dealId = const Value.absent(),
    this.dealItemsJson = const Value.absent(),
  });
  OrderItemsCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required int menuItemId,
    required String menuItemName,
    required double unitPrice,
    required int quantity,
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.modifiersJson = const Value.absent(),
    this.isVoided = const Value.absent(),
    this.sentToKitchenAt = const Value.absent(),
    this.dealId = const Value.absent(),
    this.dealItemsJson = const Value.absent(),
  })  : orderId = Value(orderId),
        menuItemId = Value(menuItemId),
        menuItemName = Value(menuItemName),
        unitPrice = Value(unitPrice),
        quantity = Value(quantity);
  static Insertable<OrderItem> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<int>? menuItemId,
    Expression<String>? menuItemName,
    Expression<double>? unitPrice,
    Expression<int>? quantity,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<String>? modifiersJson,
    Expression<bool>? isVoided,
    Expression<DateTime>? sentToKitchenAt,
    Expression<int>? dealId,
    Expression<String>? dealItemsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (menuItemId != null) 'menu_item_id': menuItemId,
      if (menuItemName != null) 'menu_item_name': menuItemName,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (quantity != null) 'quantity': quantity,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (modifiersJson != null) 'modifiers_json': modifiersJson,
      if (isVoided != null) 'is_voided': isVoided,
      if (sentToKitchenAt != null) 'sent_to_kitchen_at': sentToKitchenAt,
      if (dealId != null) 'deal_id': dealId,
      if (dealItemsJson != null) 'deal_items_json': dealItemsJson,
    });
  }

  OrderItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? orderId,
      Value<int>? menuItemId,
      Value<String>? menuItemName,
      Value<double>? unitPrice,
      Value<int>? quantity,
      Value<String>? notes,
      Value<String>? status,
      Value<String>? modifiersJson,
      Value<bool>? isVoided,
      Value<DateTime?>? sentToKitchenAt,
      Value<int?>? dealId,
      Value<String?>? dealItemsJson}) {
    return OrderItemsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      menuItemId: menuItemId ?? this.menuItemId,
      menuItemName: menuItemName ?? this.menuItemName,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      modifiersJson: modifiersJson ?? this.modifiersJson,
      isVoided: isVoided ?? this.isVoided,
      sentToKitchenAt: sentToKitchenAt ?? this.sentToKitchenAt,
      dealId: dealId ?? this.dealId,
      dealItemsJson: dealItemsJson ?? this.dealItemsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (menuItemId.present) {
      map['menu_item_id'] = Variable<int>(menuItemId.value);
    }
    if (menuItemName.present) {
      map['menu_item_name'] = Variable<String>(menuItemName.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (modifiersJson.present) {
      map['modifiers_json'] = Variable<String>(modifiersJson.value);
    }
    if (isVoided.present) {
      map['is_voided'] = Variable<bool>(isVoided.value);
    }
    if (sentToKitchenAt.present) {
      map['sent_to_kitchen_at'] = Variable<DateTime>(sentToKitchenAt.value);
    }
    if (dealId.present) {
      map['deal_id'] = Variable<int>(dealId.value);
    }
    if (dealItemsJson.present) {
      map['deal_items_json'] = Variable<String>(dealItemsJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderItemsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('menuItemId: $menuItemId, ')
          ..write('menuItemName: $menuItemName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('quantity: $quantity, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('modifiersJson: $modifiersJson, ')
          ..write('isVoided: $isVoided, ')
          ..write('sentToKitchenAt: $sentToKitchenAt, ')
          ..write('dealId: $dealId, ')
          ..write('dealItemsJson: $dealItemsJson')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _invoiceNumberMeta =
      const VerificationMeta('invoiceNumber');
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
      'invoice_number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
      'order_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES orders (id)'));
  static const VerificationMeta _orderNumberMeta =
      const VerificationMeta('orderNumber');
  @override
  late final GeneratedColumn<String> orderNumber = GeneratedColumn<String>(
      'order_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tableNameColMeta =
      const VerificationMeta('tableNameCol');
  @override
  late final GeneratedColumn<String> tableNameCol = GeneratedColumn<String>(
      'table_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _waiterNameMeta =
      const VerificationMeta('waiterName');
  @override
  late final GeneratedColumn<String> waiterName = GeneratedColumn<String>(
      'waiter_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _discountValueMeta =
      const VerificationMeta('discountValue');
  @override
  late final GeneratedColumn<double> discountValue = GeneratedColumn<double>(
      'discount_value', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _taxValueMeta =
      const VerificationMeta('taxValue');
  @override
  late final GeneratedColumn<double> taxValue = GeneratedColumn<double>(
      'tax_value', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _serviceChargeValueMeta =
      const VerificationMeta('serviceChargeValue');
  @override
  late final GeneratedColumn<double> serviceChargeValue =
      GeneratedColumn<double>('service_charge_value', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  static const VerificationMeta _grandTotalMeta =
      const VerificationMeta('grandTotal');
  @override
  late final GeneratedColumn<double> grandTotal = GeneratedColumn<double>(
      'grand_total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _amountPaidMeta =
      const VerificationMeta('amountPaid');
  @override
  late final GeneratedColumn<double> amountPaid = GeneratedColumn<double>(
      'amount_paid', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _changeAmountMeta =
      const VerificationMeta('changeAmount');
  @override
  late final GeneratedColumn<double> changeAmount = GeneratedColumn<double>(
      'change_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('cash'));
  static const VerificationMeta _paymentSplitsJsonMeta =
      const VerificationMeta('paymentSplitsJson');
  @override
  late final GeneratedColumn<String> paymentSplitsJson =
      GeneratedColumn<String>('payment_splits_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('proforma'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isVoidedMeta =
      const VerificationMeta('isVoided');
  @override
  late final GeneratedColumn<bool> isVoided = GeneratedColumn<bool>(
      'is_voided', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_voided" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        invoiceNumber,
        orderId,
        orderNumber,
        tableNameCol,
        waiterName,
        subtotal,
        discountValue,
        taxValue,
        serviceChargeValue,
        grandTotal,
        amountPaid,
        changeAmount,
        paymentMethod,
        paymentSplitsJson,
        status,
        customerId,
        isVoided,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(Insertable<Invoice> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
          _invoiceNumberMeta,
          invoiceNumber.isAcceptableOrUnknown(
              data['invoice_number']!, _invoiceNumberMeta));
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('order_number')) {
      context.handle(
          _orderNumberMeta,
          orderNumber.isAcceptableOrUnknown(
              data['order_number']!, _orderNumberMeta));
    } else if (isInserting) {
      context.missing(_orderNumberMeta);
    }
    if (data.containsKey('table_name')) {
      context.handle(
          _tableNameColMeta,
          tableNameCol.isAcceptableOrUnknown(
              data['table_name']!, _tableNameColMeta));
    } else if (isInserting) {
      context.missing(_tableNameColMeta);
    }
    if (data.containsKey('waiter_name')) {
      context.handle(
          _waiterNameMeta,
          waiterName.isAcceptableOrUnknown(
              data['waiter_name']!, _waiterNameMeta));
    } else if (isInserting) {
      context.missing(_waiterNameMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('discount_value')) {
      context.handle(
          _discountValueMeta,
          discountValue.isAcceptableOrUnknown(
              data['discount_value']!, _discountValueMeta));
    }
    if (data.containsKey('tax_value')) {
      context.handle(_taxValueMeta,
          taxValue.isAcceptableOrUnknown(data['tax_value']!, _taxValueMeta));
    }
    if (data.containsKey('service_charge_value')) {
      context.handle(
          _serviceChargeValueMeta,
          serviceChargeValue.isAcceptableOrUnknown(
              data['service_charge_value']!, _serviceChargeValueMeta));
    }
    if (data.containsKey('grand_total')) {
      context.handle(
          _grandTotalMeta,
          grandTotal.isAcceptableOrUnknown(
              data['grand_total']!, _grandTotalMeta));
    } else if (isInserting) {
      context.missing(_grandTotalMeta);
    }
    if (data.containsKey('amount_paid')) {
      context.handle(
          _amountPaidMeta,
          amountPaid.isAcceptableOrUnknown(
              data['amount_paid']!, _amountPaidMeta));
    } else if (isInserting) {
      context.missing(_amountPaidMeta);
    }
    if (data.containsKey('change_amount')) {
      context.handle(
          _changeAmountMeta,
          changeAmount.isAcceptableOrUnknown(
              data['change_amount']!, _changeAmountMeta));
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    }
    if (data.containsKey('payment_splits_json')) {
      context.handle(
          _paymentSplitsJsonMeta,
          paymentSplitsJson.isAcceptableOrUnknown(
              data['payment_splits_json']!, _paymentSplitsJsonMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('is_voided')) {
      context.handle(_isVoidedMeta,
          isVoided.isAcceptableOrUnknown(data['is_voided']!, _isVoidedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      invoiceNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invoice_number'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_id'])!,
      orderNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_number'])!,
      tableNameCol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}table_name'])!,
      waiterName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}waiter_name'])!,
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      discountValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}discount_value'])!,
      taxValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tax_value'])!,
      serviceChargeValue: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}service_charge_value'])!,
      grandTotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}grand_total'])!,
      amountPaid: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount_paid'])!,
      changeAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}change_amount'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method'])!,
      paymentSplitsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}payment_splits_json'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id']),
      isVoided: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_voided'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int id;
  final String invoiceNumber;
  final int orderId;
  final String orderNumber;
  final String tableNameCol;
  final String waiterName;
  final double subtotal;
  final double discountValue;
  final double taxValue;
  final double serviceChargeValue;
  final double grandTotal;
  final double amountPaid;
  final double changeAmount;
  final String paymentMethod;
  final String paymentSplitsJson;
  final String status;
  final int? customerId;
  final bool isVoided;
  final DateTime createdAt;
  const Invoice(
      {required this.id,
      required this.invoiceNumber,
      required this.orderId,
      required this.orderNumber,
      required this.tableNameCol,
      required this.waiterName,
      required this.subtotal,
      required this.discountValue,
      required this.taxValue,
      required this.serviceChargeValue,
      required this.grandTotal,
      required this.amountPaid,
      required this.changeAmount,
      required this.paymentMethod,
      required this.paymentSplitsJson,
      required this.status,
      this.customerId,
      required this.isVoided,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    map['order_id'] = Variable<int>(orderId);
    map['order_number'] = Variable<String>(orderNumber);
    map['table_name'] = Variable<String>(tableNameCol);
    map['waiter_name'] = Variable<String>(waiterName);
    map['subtotal'] = Variable<double>(subtotal);
    map['discount_value'] = Variable<double>(discountValue);
    map['tax_value'] = Variable<double>(taxValue);
    map['service_charge_value'] = Variable<double>(serviceChargeValue);
    map['grand_total'] = Variable<double>(grandTotal);
    map['amount_paid'] = Variable<double>(amountPaid);
    map['change_amount'] = Variable<double>(changeAmount);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['payment_splits_json'] = Variable<String>(paymentSplitsJson);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    map['is_voided'] = Variable<bool>(isVoided);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      invoiceNumber: Value(invoiceNumber),
      orderId: Value(orderId),
      orderNumber: Value(orderNumber),
      tableNameCol: Value(tableNameCol),
      waiterName: Value(waiterName),
      subtotal: Value(subtotal),
      discountValue: Value(discountValue),
      taxValue: Value(taxValue),
      serviceChargeValue: Value(serviceChargeValue),
      grandTotal: Value(grandTotal),
      amountPaid: Value(amountPaid),
      changeAmount: Value(changeAmount),
      paymentMethod: Value(paymentMethod),
      paymentSplitsJson: Value(paymentSplitsJson),
      status: Value(status),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      isVoided: Value(isVoided),
      createdAt: Value(createdAt),
    );
  }

  factory Invoice.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      orderId: serializer.fromJson<int>(json['orderId']),
      orderNumber: serializer.fromJson<String>(json['orderNumber']),
      tableNameCol: serializer.fromJson<String>(json['tableNameCol']),
      waiterName: serializer.fromJson<String>(json['waiterName']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      discountValue: serializer.fromJson<double>(json['discountValue']),
      taxValue: serializer.fromJson<double>(json['taxValue']),
      serviceChargeValue:
          serializer.fromJson<double>(json['serviceChargeValue']),
      grandTotal: serializer.fromJson<double>(json['grandTotal']),
      amountPaid: serializer.fromJson<double>(json['amountPaid']),
      changeAmount: serializer.fromJson<double>(json['changeAmount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      paymentSplitsJson: serializer.fromJson<String>(json['paymentSplitsJson']),
      status: serializer.fromJson<String>(json['status']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      isVoided: serializer.fromJson<bool>(json['isVoided']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'orderId': serializer.toJson<int>(orderId),
      'orderNumber': serializer.toJson<String>(orderNumber),
      'tableNameCol': serializer.toJson<String>(tableNameCol),
      'waiterName': serializer.toJson<String>(waiterName),
      'subtotal': serializer.toJson<double>(subtotal),
      'discountValue': serializer.toJson<double>(discountValue),
      'taxValue': serializer.toJson<double>(taxValue),
      'serviceChargeValue': serializer.toJson<double>(serviceChargeValue),
      'grandTotal': serializer.toJson<double>(grandTotal),
      'amountPaid': serializer.toJson<double>(amountPaid),
      'changeAmount': serializer.toJson<double>(changeAmount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'paymentSplitsJson': serializer.toJson<String>(paymentSplitsJson),
      'status': serializer.toJson<String>(status),
      'customerId': serializer.toJson<int?>(customerId),
      'isVoided': serializer.toJson<bool>(isVoided),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Invoice copyWith(
          {int? id,
          String? invoiceNumber,
          int? orderId,
          String? orderNumber,
          String? tableNameCol,
          String? waiterName,
          double? subtotal,
          double? discountValue,
          double? taxValue,
          double? serviceChargeValue,
          double? grandTotal,
          double? amountPaid,
          double? changeAmount,
          String? paymentMethod,
          String? paymentSplitsJson,
          String? status,
          Value<int?> customerId = const Value.absent(),
          bool? isVoided,
          DateTime? createdAt}) =>
      Invoice(
        id: id ?? this.id,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        orderId: orderId ?? this.orderId,
        orderNumber: orderNumber ?? this.orderNumber,
        tableNameCol: tableNameCol ?? this.tableNameCol,
        waiterName: waiterName ?? this.waiterName,
        subtotal: subtotal ?? this.subtotal,
        discountValue: discountValue ?? this.discountValue,
        taxValue: taxValue ?? this.taxValue,
        serviceChargeValue: serviceChargeValue ?? this.serviceChargeValue,
        grandTotal: grandTotal ?? this.grandTotal,
        amountPaid: amountPaid ?? this.amountPaid,
        changeAmount: changeAmount ?? this.changeAmount,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        paymentSplitsJson: paymentSplitsJson ?? this.paymentSplitsJson,
        status: status ?? this.status,
        customerId: customerId.present ? customerId.value : this.customerId,
        isVoided: isVoided ?? this.isVoided,
        createdAt: createdAt ?? this.createdAt,
      );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      orderNumber:
          data.orderNumber.present ? data.orderNumber.value : this.orderNumber,
      tableNameCol: data.tableNameCol.present
          ? data.tableNameCol.value
          : this.tableNameCol,
      waiterName:
          data.waiterName.present ? data.waiterName.value : this.waiterName,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      discountValue: data.discountValue.present
          ? data.discountValue.value
          : this.discountValue,
      taxValue: data.taxValue.present ? data.taxValue.value : this.taxValue,
      serviceChargeValue: data.serviceChargeValue.present
          ? data.serviceChargeValue.value
          : this.serviceChargeValue,
      grandTotal:
          data.grandTotal.present ? data.grandTotal.value : this.grandTotal,
      amountPaid:
          data.amountPaid.present ? data.amountPaid.value : this.amountPaid,
      changeAmount: data.changeAmount.present
          ? data.changeAmount.value
          : this.changeAmount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      paymentSplitsJson: data.paymentSplitsJson.present
          ? data.paymentSplitsJson.value
          : this.paymentSplitsJson,
      status: data.status.present ? data.status.value : this.status,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      isVoided: data.isVoided.present ? data.isVoided.value : this.isVoided,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('orderId: $orderId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('tableNameCol: $tableNameCol, ')
          ..write('waiterName: $waiterName, ')
          ..write('subtotal: $subtotal, ')
          ..write('discountValue: $discountValue, ')
          ..write('taxValue: $taxValue, ')
          ..write('serviceChargeValue: $serviceChargeValue, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('changeAmount: $changeAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentSplitsJson: $paymentSplitsJson, ')
          ..write('status: $status, ')
          ..write('customerId: $customerId, ')
          ..write('isVoided: $isVoided, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      invoiceNumber,
      orderId,
      orderNumber,
      tableNameCol,
      waiterName,
      subtotal,
      discountValue,
      taxValue,
      serviceChargeValue,
      grandTotal,
      amountPaid,
      changeAmount,
      paymentMethod,
      paymentSplitsJson,
      status,
      customerId,
      isVoided,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.invoiceNumber == this.invoiceNumber &&
          other.orderId == this.orderId &&
          other.orderNumber == this.orderNumber &&
          other.tableNameCol == this.tableNameCol &&
          other.waiterName == this.waiterName &&
          other.subtotal == this.subtotal &&
          other.discountValue == this.discountValue &&
          other.taxValue == this.taxValue &&
          other.serviceChargeValue == this.serviceChargeValue &&
          other.grandTotal == this.grandTotal &&
          other.amountPaid == this.amountPaid &&
          other.changeAmount == this.changeAmount &&
          other.paymentMethod == this.paymentMethod &&
          other.paymentSplitsJson == this.paymentSplitsJson &&
          other.status == this.status &&
          other.customerId == this.customerId &&
          other.isVoided == this.isVoided &&
          other.createdAt == this.createdAt);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<String> invoiceNumber;
  final Value<int> orderId;
  final Value<String> orderNumber;
  final Value<String> tableNameCol;
  final Value<String> waiterName;
  final Value<double> subtotal;
  final Value<double> discountValue;
  final Value<double> taxValue;
  final Value<double> serviceChargeValue;
  final Value<double> grandTotal;
  final Value<double> amountPaid;
  final Value<double> changeAmount;
  final Value<String> paymentMethod;
  final Value<String> paymentSplitsJson;
  final Value<String> status;
  final Value<int?> customerId;
  final Value<bool> isVoided;
  final Value<DateTime> createdAt;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.orderId = const Value.absent(),
    this.orderNumber = const Value.absent(),
    this.tableNameCol = const Value.absent(),
    this.waiterName = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discountValue = const Value.absent(),
    this.taxValue = const Value.absent(),
    this.serviceChargeValue = const Value.absent(),
    this.grandTotal = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.changeAmount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paymentSplitsJson = const Value.absent(),
    this.status = const Value.absent(),
    this.customerId = const Value.absent(),
    this.isVoided = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required String invoiceNumber,
    required int orderId,
    required String orderNumber,
    required String tableNameCol,
    required String waiterName,
    required double subtotal,
    this.discountValue = const Value.absent(),
    this.taxValue = const Value.absent(),
    this.serviceChargeValue = const Value.absent(),
    required double grandTotal,
    required double amountPaid,
    this.changeAmount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paymentSplitsJson = const Value.absent(),
    this.status = const Value.absent(),
    this.customerId = const Value.absent(),
    this.isVoided = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : invoiceNumber = Value(invoiceNumber),
        orderId = Value(orderId),
        orderNumber = Value(orderNumber),
        tableNameCol = Value(tableNameCol),
        waiterName = Value(waiterName),
        subtotal = Value(subtotal),
        grandTotal = Value(grandTotal),
        amountPaid = Value(amountPaid);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<String>? invoiceNumber,
    Expression<int>? orderId,
    Expression<String>? orderNumber,
    Expression<String>? tableNameCol,
    Expression<String>? waiterName,
    Expression<double>? subtotal,
    Expression<double>? discountValue,
    Expression<double>? taxValue,
    Expression<double>? serviceChargeValue,
    Expression<double>? grandTotal,
    Expression<double>? amountPaid,
    Expression<double>? changeAmount,
    Expression<String>? paymentMethod,
    Expression<String>? paymentSplitsJson,
    Expression<String>? status,
    Expression<int>? customerId,
    Expression<bool>? isVoided,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (orderId != null) 'order_id': orderId,
      if (orderNumber != null) 'order_number': orderNumber,
      if (tableNameCol != null) 'table_name': tableNameCol,
      if (waiterName != null) 'waiter_name': waiterName,
      if (subtotal != null) 'subtotal': subtotal,
      if (discountValue != null) 'discount_value': discountValue,
      if (taxValue != null) 'tax_value': taxValue,
      if (serviceChargeValue != null)
        'service_charge_value': serviceChargeValue,
      if (grandTotal != null) 'grand_total': grandTotal,
      if (amountPaid != null) 'amount_paid': amountPaid,
      if (changeAmount != null) 'change_amount': changeAmount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (paymentSplitsJson != null) 'payment_splits_json': paymentSplitsJson,
      if (status != null) 'status': status,
      if (customerId != null) 'customer_id': customerId,
      if (isVoided != null) 'is_voided': isVoided,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InvoicesCompanion copyWith(
      {Value<int>? id,
      Value<String>? invoiceNumber,
      Value<int>? orderId,
      Value<String>? orderNumber,
      Value<String>? tableNameCol,
      Value<String>? waiterName,
      Value<double>? subtotal,
      Value<double>? discountValue,
      Value<double>? taxValue,
      Value<double>? serviceChargeValue,
      Value<double>? grandTotal,
      Value<double>? amountPaid,
      Value<double>? changeAmount,
      Value<String>? paymentMethod,
      Value<String>? paymentSplitsJson,
      Value<String>? status,
      Value<int?>? customerId,
      Value<bool>? isVoided,
      Value<DateTime>? createdAt}) {
    return InvoicesCompanion(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      orderId: orderId ?? this.orderId,
      orderNumber: orderNumber ?? this.orderNumber,
      tableNameCol: tableNameCol ?? this.tableNameCol,
      waiterName: waiterName ?? this.waiterName,
      subtotal: subtotal ?? this.subtotal,
      discountValue: discountValue ?? this.discountValue,
      taxValue: taxValue ?? this.taxValue,
      serviceChargeValue: serviceChargeValue ?? this.serviceChargeValue,
      grandTotal: grandTotal ?? this.grandTotal,
      amountPaid: amountPaid ?? this.amountPaid,
      changeAmount: changeAmount ?? this.changeAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentSplitsJson: paymentSplitsJson ?? this.paymentSplitsJson,
      status: status ?? this.status,
      customerId: customerId ?? this.customerId,
      isVoided: isVoided ?? this.isVoided,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (orderNumber.present) {
      map['order_number'] = Variable<String>(orderNumber.value);
    }
    if (tableNameCol.present) {
      map['table_name'] = Variable<String>(tableNameCol.value);
    }
    if (waiterName.present) {
      map['waiter_name'] = Variable<String>(waiterName.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (discountValue.present) {
      map['discount_value'] = Variable<double>(discountValue.value);
    }
    if (taxValue.present) {
      map['tax_value'] = Variable<double>(taxValue.value);
    }
    if (serviceChargeValue.present) {
      map['service_charge_value'] = Variable<double>(serviceChargeValue.value);
    }
    if (grandTotal.present) {
      map['grand_total'] = Variable<double>(grandTotal.value);
    }
    if (amountPaid.present) {
      map['amount_paid'] = Variable<double>(amountPaid.value);
    }
    if (changeAmount.present) {
      map['change_amount'] = Variable<double>(changeAmount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (paymentSplitsJson.present) {
      map['payment_splits_json'] = Variable<String>(paymentSplitsJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (isVoided.present) {
      map['is_voided'] = Variable<bool>(isVoided.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('orderId: $orderId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('tableNameCol: $tableNameCol, ')
          ..write('waiterName: $waiterName, ')
          ..write('subtotal: $subtotal, ')
          ..write('discountValue: $discountValue, ')
          ..write('taxValue: $taxValue, ')
          ..write('serviceChargeValue: $serviceChargeValue, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('changeAmount: $changeAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentSplitsJson: $paymentSplitsJson, ')
          ..write('status: $status, ')
          ..write('customerId: $customerId, ')
          ..write('isVoided: $isVoided, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _creditLimitMeta =
      const VerificationMeta('creditLimit');
  @override
  late final GeneratedColumn<double> creditLimit = GeneratedColumn<double>(
      'credit_limit', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _balanceMeta =
      const VerificationMeta('balance');
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
      'balance', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _loyaltyPointsMeta =
      const VerificationMeta('loyaltyPoints');
  @override
  late final GeneratedColumn<int> loyaltyPoints = GeneratedColumn<int>(
      'loyalty_points', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        phone,
        address,
        creditLimit,
        balance,
        loyaltyPoints,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('credit_limit')) {
      context.handle(
          _creditLimitMeta,
          creditLimit.isAcceptableOrUnknown(
              data['credit_limit']!, _creditLimitMeta));
    }
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    }
    if (data.containsKey('loyalty_points')) {
      context.handle(
          _loyaltyPointsMeta,
          loyaltyPoints.isAcceptableOrUnknown(
              data['loyalty_points']!, _loyaltyPointsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      creditLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}credit_limit'])!,
      balance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}balance'])!,
      loyaltyPoints: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}loyalty_points'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String name;
  final String phone;
  final String? address;
  final double creditLimit;
  final double balance;
  final int loyaltyPoints;
  final DateTime createdAt;
  const Customer(
      {required this.id,
      required this.name,
      required this.phone,
      this.address,
      required this.creditLimit,
      required this.balance,
      required this.loyaltyPoints,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['credit_limit'] = Variable<double>(creditLimit);
    map['balance'] = Variable<double>(balance);
    map['loyalty_points'] = Variable<int>(loyaltyPoints);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      phone: Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      creditLimit: Value(creditLimit),
      balance: Value(balance),
      loyaltyPoints: Value(loyaltyPoints),
      createdAt: Value(createdAt),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      creditLimit: serializer.fromJson<double>(json['creditLimit']),
      balance: serializer.fromJson<double>(json['balance']),
      loyaltyPoints: serializer.fromJson<int>(json['loyaltyPoints']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'address': serializer.toJson<String?>(address),
      'creditLimit': serializer.toJson<double>(creditLimit),
      'balance': serializer.toJson<double>(balance),
      'loyaltyPoints': serializer.toJson<int>(loyaltyPoints),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Customer copyWith(
          {int? id,
          String? name,
          String? phone,
          Value<String?> address = const Value.absent(),
          double? creditLimit,
          double? balance,
          int? loyaltyPoints,
          DateTime? createdAt}) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        address: address.present ? address.value : this.address,
        creditLimit: creditLimit ?? this.creditLimit,
        balance: balance ?? this.balance,
        loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
        createdAt: createdAt ?? this.createdAt,
      );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      creditLimit:
          data.creditLimit.present ? data.creditLimit.value : this.creditLimit,
      balance: data.balance.present ? data.balance.value : this.balance,
      loyaltyPoints: data.loyaltyPoints.present
          ? data.loyaltyPoints.value
          : this.loyaltyPoints,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('balance: $balance, ')
          ..write('loyaltyPoints: $loyaltyPoints, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, phone, address, creditLimit, balance, loyaltyPoints, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.creditLimit == this.creditLimit &&
          other.balance == this.balance &&
          other.loyaltyPoints == this.loyaltyPoints &&
          other.createdAt == this.createdAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String?> address;
  final Value<double> creditLimit;
  final Value<double> balance;
  final Value<int> loyaltyPoints;
  final Value<DateTime> createdAt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.balance = const Value.absent(),
    this.loyaltyPoints = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String phone,
    this.address = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.balance = const Value.absent(),
    this.loyaltyPoints = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : name = Value(name),
        phone = Value(phone);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<double>? creditLimit,
    Expression<double>? balance,
    Expression<int>? loyaltyPoints,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (creditLimit != null) 'credit_limit': creditLimit,
      if (balance != null) 'balance': balance,
      if (loyaltyPoints != null) 'loyalty_points': loyaltyPoints,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CustomersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? phone,
      Value<String?>? address,
      Value<double>? creditLimit,
      Value<double>? balance,
      Value<int>? loyaltyPoints,
      Value<DateTime>? createdAt}) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      creditLimit: creditLimit ?? this.creditLimit,
      balance: balance ?? this.balance,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (creditLimit.present) {
      map['credit_limit'] = Variable<double>(creditLimit.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (loyaltyPoints.present) {
      map['loyalty_points'] = Variable<int>(loyaltyPoints.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('balance: $balance, ')
          ..write('loyaltyPoints: $loyaltyPoints, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CreditLedgerTable extends CreditLedger
    with TableInfo<$CreditLedgerTable, CreditLedgerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditLedgerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _balanceAfterMeta =
      const VerificationMeta('balanceAfter');
  @override
  late final GeneratedColumn<double> balanceAfter = GeneratedColumn<double>(
      'balance_after', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _invoiceIdMeta =
      const VerificationMeta('invoiceId');
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
      'invoice_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        customerId,
        type,
        amount,
        balanceAfter,
        description,
        invoiceId,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_ledger';
  @override
  VerificationContext validateIntegrity(Insertable<CreditLedgerData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('balance_after')) {
      context.handle(
          _balanceAfterMeta,
          balanceAfter.isAcceptableOrUnknown(
              data['balance_after']!, _balanceAfterMeta));
    } else if (isInserting) {
      context.missing(_balanceAfterMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(_invoiceIdMeta,
          invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditLedgerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditLedgerData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      balanceAfter: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}balance_after'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      invoiceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}invoice_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CreditLedgerTable createAlias(String alias) {
    return $CreditLedgerTable(attachedDatabase, alias);
  }
}

class CreditLedgerData extends DataClass
    implements Insertable<CreditLedgerData> {
  final int id;
  final int customerId;
  final String type;
  final double amount;
  final double balanceAfter;
  final String description;
  final int? invoiceId;
  final DateTime createdAt;
  const CreditLedgerData(
      {required this.id,
      required this.customerId,
      required this.type,
      required this.amount,
      required this.balanceAfter,
      required this.description,
      this.invoiceId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<double>(amount);
    map['balance_after'] = Variable<double>(balanceAfter);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || invoiceId != null) {
      map['invoice_id'] = Variable<int>(invoiceId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CreditLedgerCompanion toCompanion(bool nullToAbsent) {
    return CreditLedgerCompanion(
      id: Value(id),
      customerId: Value(customerId),
      type: Value(type),
      amount: Value(amount),
      balanceAfter: Value(balanceAfter),
      description: Value(description),
      invoiceId: invoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceId),
      createdAt: Value(createdAt),
    );
  }

  factory CreditLedgerData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditLedgerData(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<double>(json['amount']),
      balanceAfter: serializer.fromJson<double>(json['balanceAfter']),
      description: serializer.fromJson<String>(json['description']),
      invoiceId: serializer.fromJson<int?>(json['invoiceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<double>(amount),
      'balanceAfter': serializer.toJson<double>(balanceAfter),
      'description': serializer.toJson<String>(description),
      'invoiceId': serializer.toJson<int?>(invoiceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CreditLedgerData copyWith(
          {int? id,
          int? customerId,
          String? type,
          double? amount,
          double? balanceAfter,
          String? description,
          Value<int?> invoiceId = const Value.absent(),
          DateTime? createdAt}) =>
      CreditLedgerData(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        balanceAfter: balanceAfter ?? this.balanceAfter,
        description: description ?? this.description,
        invoiceId: invoiceId.present ? invoiceId.value : this.invoiceId,
        createdAt: createdAt ?? this.createdAt,
      );
  CreditLedgerData copyWithCompanion(CreditLedgerCompanion data) {
    return CreditLedgerData(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      balanceAfter: data.balanceAfter.present
          ? data.balanceAfter.value
          : this.balanceAfter,
      description:
          data.description.present ? data.description.value : this.description,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditLedgerData(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('balanceAfter: $balanceAfter, ')
          ..write('description: $description, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, customerId, type, amount, balanceAfter,
      description, invoiceId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditLedgerData &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.balanceAfter == this.balanceAfter &&
          other.description == this.description &&
          other.invoiceId == this.invoiceId &&
          other.createdAt == this.createdAt);
}

class CreditLedgerCompanion extends UpdateCompanion<CreditLedgerData> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<String> type;
  final Value<double> amount;
  final Value<double> balanceAfter;
  final Value<String> description;
  final Value<int?> invoiceId;
  final Value<DateTime> createdAt;
  const CreditLedgerCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.balanceAfter = const Value.absent(),
    this.description = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CreditLedgerCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required String type,
    required double amount,
    required double balanceAfter,
    this.description = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : customerId = Value(customerId),
        type = Value(type),
        amount = Value(amount),
        balanceAfter = Value(balanceAfter);
  static Insertable<CreditLedgerData> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<String>? type,
    Expression<double>? amount,
    Expression<double>? balanceAfter,
    Expression<String>? description,
    Expression<int>? invoiceId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (balanceAfter != null) 'balance_after': balanceAfter,
      if (description != null) 'description': description,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CreditLedgerCompanion copyWith(
      {Value<int>? id,
      Value<int>? customerId,
      Value<String>? type,
      Value<double>? amount,
      Value<double>? balanceAfter,
      Value<String>? description,
      Value<int?>? invoiceId,
      Value<DateTime>? createdAt}) {
    return CreditLedgerCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      description: description ?? this.description,
      invoiceId: invoiceId ?? this.invoiceId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (balanceAfter.present) {
      map['balance_after'] = Variable<double>(balanceAfter.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditLedgerCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('balanceAfter: $balanceAfter, ')
          ..write('description: $description, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InventoryItemsTable extends InventoryItems
    with TableInfo<$InventoryItemsTable, InventoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentStockMeta =
      const VerificationMeta('currentStock');
  @override
  late final GeneratedColumn<double> currentStock = GeneratedColumn<double>(
      'current_stock', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _minStockMeta =
      const VerificationMeta('minStock');
  @override
  late final GeneratedColumn<double> minStock = GeneratedColumn<double>(
      'min_stock', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _costPerUnitMeta =
      const VerificationMeta('costPerUnit');
  @override
  late final GeneratedColumn<double> costPerUnit = GeneratedColumn<double>(
      'cost_per_unit', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _supplierIdMeta =
      const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
      'supplier_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _expiryDateMeta =
      const VerificationMeta('expiryDate');
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
      'expiry_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        unit,
        currentStock,
        minStock,
        costPerUnit,
        supplierId,
        expiryDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_items';
  @override
  VerificationContext validateIntegrity(Insertable<InventoryItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('current_stock')) {
      context.handle(
          _currentStockMeta,
          currentStock.isAcceptableOrUnknown(
              data['current_stock']!, _currentStockMeta));
    }
    if (data.containsKey('min_stock')) {
      context.handle(_minStockMeta,
          minStock.isAcceptableOrUnknown(data['min_stock']!, _minStockMeta));
    }
    if (data.containsKey('cost_per_unit')) {
      context.handle(
          _costPerUnitMeta,
          costPerUnit.isAcceptableOrUnknown(
              data['cost_per_unit']!, _costPerUnitMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
          _expiryDateMeta,
          expiryDate.isAcceptableOrUnknown(
              data['expiry_date']!, _expiryDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      currentStock: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}current_stock'])!,
      minStock: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}min_stock'])!,
      costPerUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cost_per_unit'])!,
      supplierId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}supplier_id']),
      expiryDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expiry_date']),
    );
  }

  @override
  $InventoryItemsTable createAlias(String alias) {
    return $InventoryItemsTable(attachedDatabase, alias);
  }
}

class InventoryItem extends DataClass implements Insertable<InventoryItem> {
  final int id;
  final String name;
  final String unit;
  final double currentStock;
  final double minStock;
  final double costPerUnit;
  final int? supplierId;
  final DateTime? expiryDate;
  const InventoryItem(
      {required this.id,
      required this.name,
      required this.unit,
      required this.currentStock,
      required this.minStock,
      required this.costPerUnit,
      this.supplierId,
      this.expiryDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['unit'] = Variable<String>(unit);
    map['current_stock'] = Variable<double>(currentStock);
    map['min_stock'] = Variable<double>(minStock);
    map['cost_per_unit'] = Variable<double>(costPerUnit);
    if (!nullToAbsent || supplierId != null) {
      map['supplier_id'] = Variable<int>(supplierId);
    }
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<DateTime>(expiryDate);
    }
    return map;
  }

  InventoryItemsCompanion toCompanion(bool nullToAbsent) {
    return InventoryItemsCompanion(
      id: Value(id),
      name: Value(name),
      unit: Value(unit),
      currentStock: Value(currentStock),
      minStock: Value(minStock),
      costPerUnit: Value(costPerUnit),
      supplierId: supplierId == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierId),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
    );
  }

  factory InventoryItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryItem(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      unit: serializer.fromJson<String>(json['unit']),
      currentStock: serializer.fromJson<double>(json['currentStock']),
      minStock: serializer.fromJson<double>(json['minStock']),
      costPerUnit: serializer.fromJson<double>(json['costPerUnit']),
      supplierId: serializer.fromJson<int?>(json['supplierId']),
      expiryDate: serializer.fromJson<DateTime?>(json['expiryDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'unit': serializer.toJson<String>(unit),
      'currentStock': serializer.toJson<double>(currentStock),
      'minStock': serializer.toJson<double>(minStock),
      'costPerUnit': serializer.toJson<double>(costPerUnit),
      'supplierId': serializer.toJson<int?>(supplierId),
      'expiryDate': serializer.toJson<DateTime?>(expiryDate),
    };
  }

  InventoryItem copyWith(
          {int? id,
          String? name,
          String? unit,
          double? currentStock,
          double? minStock,
          double? costPerUnit,
          Value<int?> supplierId = const Value.absent(),
          Value<DateTime?> expiryDate = const Value.absent()}) =>
      InventoryItem(
        id: id ?? this.id,
        name: name ?? this.name,
        unit: unit ?? this.unit,
        currentStock: currentStock ?? this.currentStock,
        minStock: minStock ?? this.minStock,
        costPerUnit: costPerUnit ?? this.costPerUnit,
        supplierId: supplierId.present ? supplierId.value : this.supplierId,
        expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
      );
  InventoryItem copyWithCompanion(InventoryItemsCompanion data) {
    return InventoryItem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      unit: data.unit.present ? data.unit.value : this.unit,
      currentStock: data.currentStock.present
          ? data.currentStock.value
          : this.currentStock,
      minStock: data.minStock.present ? data.minStock.value : this.minStock,
      costPerUnit:
          data.costPerUnit.present ? data.costPerUnit.value : this.costPerUnit,
      supplierId:
          data.supplierId.present ? data.supplierId.value : this.supplierId,
      expiryDate:
          data.expiryDate.present ? data.expiryDate.value : this.expiryDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('currentStock: $currentStock, ')
          ..write('minStock: $minStock, ')
          ..write('costPerUnit: $costPerUnit, ')
          ..write('supplierId: $supplierId, ')
          ..write('expiryDate: $expiryDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, unit, currentStock, minStock,
      costPerUnit, supplierId, expiryDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.unit == this.unit &&
          other.currentStock == this.currentStock &&
          other.minStock == this.minStock &&
          other.costPerUnit == this.costPerUnit &&
          other.supplierId == this.supplierId &&
          other.expiryDate == this.expiryDate);
}

class InventoryItemsCompanion extends UpdateCompanion<InventoryItem> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> unit;
  final Value<double> currentStock;
  final Value<double> minStock;
  final Value<double> costPerUnit;
  final Value<int?> supplierId;
  final Value<DateTime?> expiryDate;
  const InventoryItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.unit = const Value.absent(),
    this.currentStock = const Value.absent(),
    this.minStock = const Value.absent(),
    this.costPerUnit = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.expiryDate = const Value.absent(),
  });
  InventoryItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String unit,
    this.currentStock = const Value.absent(),
    this.minStock = const Value.absent(),
    this.costPerUnit = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.expiryDate = const Value.absent(),
  })  : name = Value(name),
        unit = Value(unit);
  static Insertable<InventoryItem> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? unit,
    Expression<double>? currentStock,
    Expression<double>? minStock,
    Expression<double>? costPerUnit,
    Expression<int>? supplierId,
    Expression<DateTime>? expiryDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (unit != null) 'unit': unit,
      if (currentStock != null) 'current_stock': currentStock,
      if (minStock != null) 'min_stock': minStock,
      if (costPerUnit != null) 'cost_per_unit': costPerUnit,
      if (supplierId != null) 'supplier_id': supplierId,
      if (expiryDate != null) 'expiry_date': expiryDate,
    });
  }

  InventoryItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? unit,
      Value<double>? currentStock,
      Value<double>? minStock,
      Value<double>? costPerUnit,
      Value<int?>? supplierId,
      Value<DateTime?>? expiryDate}) {
    return InventoryItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      currentStock: currentStock ?? this.currentStock,
      minStock: minStock ?? this.minStock,
      costPerUnit: costPerUnit ?? this.costPerUnit,
      supplierId: supplierId ?? this.supplierId,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (currentStock.present) {
      map['current_stock'] = Variable<double>(currentStock.value);
    }
    if (minStock.present) {
      map['min_stock'] = Variable<double>(minStock.value);
    }
    if (costPerUnit.present) {
      map['cost_per_unit'] = Variable<double>(costPerUnit.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('currentStock: $currentStock, ')
          ..write('minStock: $minStock, ')
          ..write('costPerUnit: $costPerUnit, ')
          ..write('supplierId: $supplierId, ')
          ..write('expiryDate: $expiryDate')
          ..write(')'))
        .toString();
  }
}

class $CashRegistersTable extends CashRegisters
    with TableInfo<$CashRegistersTable, CashRegister> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashRegistersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _openedByMeta =
      const VerificationMeta('openedBy');
  @override
  late final GeneratedColumn<String> openedBy = GeneratedColumn<String>(
      'opened_by', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _openingCashMeta =
      const VerificationMeta('openingCash');
  @override
  late final GeneratedColumn<double> openingCash = GeneratedColumn<double>(
      'opening_cash', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _openedAtMeta =
      const VerificationMeta('openedAt');
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
      'opened_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('open'));
  static const VerificationMeta _closedByMeta =
      const VerificationMeta('closedBy');
  @override
  late final GeneratedColumn<String> closedBy = GeneratedColumn<String>(
      'closed_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _closedAtMeta =
      const VerificationMeta('closedAt');
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
      'closed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _closingCashMeta =
      const VerificationMeta('closingCash');
  @override
  late final GeneratedColumn<double> closingCash = GeneratedColumn<double>(
      'closing_cash', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalCashSalesMeta =
      const VerificationMeta('totalCashSales');
  @override
  late final GeneratedColumn<double> totalCashSales = GeneratedColumn<double>(
      'total_cash_sales', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalCardSalesMeta =
      const VerificationMeta('totalCardSales');
  @override
  late final GeneratedColumn<double> totalCardSales = GeneratedColumn<double>(
      'total_card_sales', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalWalletSalesMeta =
      const VerificationMeta('totalWalletSales');
  @override
  late final GeneratedColumn<double> totalWalletSales = GeneratedColumn<double>(
      'total_wallet_sales', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalCreditSalesMeta =
      const VerificationMeta('totalCreditSales');
  @override
  late final GeneratedColumn<double> totalCreditSales = GeneratedColumn<double>(
      'total_credit_sales', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalExpensesMeta =
      const VerificationMeta('totalExpenses');
  @override
  late final GeneratedColumn<double> totalExpenses = GeneratedColumn<double>(
      'total_expenses', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _cashInMeta = const VerificationMeta('cashIn');
  @override
  late final GeneratedColumn<double> cashIn = GeneratedColumn<double>(
      'cash_in', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _cashOutMeta =
      const VerificationMeta('cashOut');
  @override
  late final GeneratedColumn<double> cashOut = GeneratedColumn<double>(
      'cash_out', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalOrdersMeta =
      const VerificationMeta('totalOrders');
  @override
  late final GeneratedColumn<int> totalOrders = GeneratedColumn<int>(
      'total_orders', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalKitchenTicketsMeta =
      const VerificationMeta('totalKitchenTickets');
  @override
  late final GeneratedColumn<int> totalKitchenTickets = GeneratedColumn<int>(
      'total_kitchen_tickets', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalDiscountsMeta =
      const VerificationMeta('totalDiscounts');
  @override
  late final GeneratedColumn<double> totalDiscounts = GeneratedColumn<double>(
      'total_discounts', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalTaxMeta =
      const VerificationMeta('totalTax');
  @override
  late final GeneratedColumn<double> totalTax = GeneratedColumn<double>(
      'total_tax', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _totalVoidsMeta =
      const VerificationMeta('totalVoids');
  @override
  late final GeneratedColumn<int> totalVoids = GeneratedColumn<int>(
      'total_voids', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        openedBy,
        openingCash,
        openedAt,
        status,
        closedBy,
        closedAt,
        closingCash,
        totalCashSales,
        totalCardSales,
        totalWalletSales,
        totalCreditSales,
        totalExpenses,
        cashIn,
        cashOut,
        totalOrders,
        totalKitchenTickets,
        totalDiscounts,
        totalTax,
        totalVoids
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_registers';
  @override
  VerificationContext validateIntegrity(Insertable<CashRegister> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('opened_by')) {
      context.handle(_openedByMeta,
          openedBy.isAcceptableOrUnknown(data['opened_by']!, _openedByMeta));
    } else if (isInserting) {
      context.missing(_openedByMeta);
    }
    if (data.containsKey('opening_cash')) {
      context.handle(
          _openingCashMeta,
          openingCash.isAcceptableOrUnknown(
              data['opening_cash']!, _openingCashMeta));
    } else if (isInserting) {
      context.missing(_openingCashMeta);
    }
    if (data.containsKey('opened_at')) {
      context.handle(_openedAtMeta,
          openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('closed_by')) {
      context.handle(_closedByMeta,
          closedBy.isAcceptableOrUnknown(data['closed_by']!, _closedByMeta));
    }
    if (data.containsKey('closed_at')) {
      context.handle(_closedAtMeta,
          closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta));
    }
    if (data.containsKey('closing_cash')) {
      context.handle(
          _closingCashMeta,
          closingCash.isAcceptableOrUnknown(
              data['closing_cash']!, _closingCashMeta));
    }
    if (data.containsKey('total_cash_sales')) {
      context.handle(
          _totalCashSalesMeta,
          totalCashSales.isAcceptableOrUnknown(
              data['total_cash_sales']!, _totalCashSalesMeta));
    }
    if (data.containsKey('total_card_sales')) {
      context.handle(
          _totalCardSalesMeta,
          totalCardSales.isAcceptableOrUnknown(
              data['total_card_sales']!, _totalCardSalesMeta));
    }
    if (data.containsKey('total_wallet_sales')) {
      context.handle(
          _totalWalletSalesMeta,
          totalWalletSales.isAcceptableOrUnknown(
              data['total_wallet_sales']!, _totalWalletSalesMeta));
    }
    if (data.containsKey('total_credit_sales')) {
      context.handle(
          _totalCreditSalesMeta,
          totalCreditSales.isAcceptableOrUnknown(
              data['total_credit_sales']!, _totalCreditSalesMeta));
    }
    if (data.containsKey('total_expenses')) {
      context.handle(
          _totalExpensesMeta,
          totalExpenses.isAcceptableOrUnknown(
              data['total_expenses']!, _totalExpensesMeta));
    }
    if (data.containsKey('cash_in')) {
      context.handle(_cashInMeta,
          cashIn.isAcceptableOrUnknown(data['cash_in']!, _cashInMeta));
    }
    if (data.containsKey('cash_out')) {
      context.handle(_cashOutMeta,
          cashOut.isAcceptableOrUnknown(data['cash_out']!, _cashOutMeta));
    }
    if (data.containsKey('total_orders')) {
      context.handle(
          _totalOrdersMeta,
          totalOrders.isAcceptableOrUnknown(
              data['total_orders']!, _totalOrdersMeta));
    }
    if (data.containsKey('total_kitchen_tickets')) {
      context.handle(
          _totalKitchenTicketsMeta,
          totalKitchenTickets.isAcceptableOrUnknown(
              data['total_kitchen_tickets']!, _totalKitchenTicketsMeta));
    }
    if (data.containsKey('total_discounts')) {
      context.handle(
          _totalDiscountsMeta,
          totalDiscounts.isAcceptableOrUnknown(
              data['total_discounts']!, _totalDiscountsMeta));
    }
    if (data.containsKey('total_tax')) {
      context.handle(_totalTaxMeta,
          totalTax.isAcceptableOrUnknown(data['total_tax']!, _totalTaxMeta));
    }
    if (data.containsKey('total_voids')) {
      context.handle(
          _totalVoidsMeta,
          totalVoids.isAcceptableOrUnknown(
              data['total_voids']!, _totalVoidsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashRegister map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashRegister(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      openedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}opened_by'])!,
      openingCash: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}opening_cash'])!,
      openedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}opened_at'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      closedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}closed_by']),
      closedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}closed_at']),
      closingCash: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}closing_cash'])!,
      totalCashSales: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_cash_sales'])!,
      totalCardSales: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_card_sales'])!,
      totalWalletSales: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_wallet_sales'])!,
      totalCreditSales: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_credit_sales'])!,
      totalExpenses: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_expenses'])!,
      cashIn: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cash_in'])!,
      cashOut: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cash_out'])!,
      totalOrders: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_orders'])!,
      totalKitchenTickets: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_kitchen_tickets'])!,
      totalDiscounts: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_discounts'])!,
      totalTax: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_tax'])!,
      totalVoids: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_voids'])!,
    );
  }

  @override
  $CashRegistersTable createAlias(String alias) {
    return $CashRegistersTable(attachedDatabase, alias);
  }
}

class CashRegister extends DataClass implements Insertable<CashRegister> {
  final int id;
  final String openedBy;
  final double openingCash;
  final DateTime openedAt;
  final String status;
  final String? closedBy;
  final DateTime? closedAt;
  final double closingCash;
  final double totalCashSales;
  final double totalCardSales;
  final double totalWalletSales;
  final double totalCreditSales;
  final double totalExpenses;
  final double cashIn;
  final double cashOut;
  final int totalOrders;
  final int totalKitchenTickets;
  final double totalDiscounts;
  final double totalTax;
  final int totalVoids;
  const CashRegister(
      {required this.id,
      required this.openedBy,
      required this.openingCash,
      required this.openedAt,
      required this.status,
      this.closedBy,
      this.closedAt,
      required this.closingCash,
      required this.totalCashSales,
      required this.totalCardSales,
      required this.totalWalletSales,
      required this.totalCreditSales,
      required this.totalExpenses,
      required this.cashIn,
      required this.cashOut,
      required this.totalOrders,
      required this.totalKitchenTickets,
      required this.totalDiscounts,
      required this.totalTax,
      required this.totalVoids});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['opened_by'] = Variable<String>(openedBy);
    map['opening_cash'] = Variable<double>(openingCash);
    map['opened_at'] = Variable<DateTime>(openedAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || closedBy != null) {
      map['closed_by'] = Variable<String>(closedBy);
    }
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    map['closing_cash'] = Variable<double>(closingCash);
    map['total_cash_sales'] = Variable<double>(totalCashSales);
    map['total_card_sales'] = Variable<double>(totalCardSales);
    map['total_wallet_sales'] = Variable<double>(totalWalletSales);
    map['total_credit_sales'] = Variable<double>(totalCreditSales);
    map['total_expenses'] = Variable<double>(totalExpenses);
    map['cash_in'] = Variable<double>(cashIn);
    map['cash_out'] = Variable<double>(cashOut);
    map['total_orders'] = Variable<int>(totalOrders);
    map['total_kitchen_tickets'] = Variable<int>(totalKitchenTickets);
    map['total_discounts'] = Variable<double>(totalDiscounts);
    map['total_tax'] = Variable<double>(totalTax);
    map['total_voids'] = Variable<int>(totalVoids);
    return map;
  }

  CashRegistersCompanion toCompanion(bool nullToAbsent) {
    return CashRegistersCompanion(
      id: Value(id),
      openedBy: Value(openedBy),
      openingCash: Value(openingCash),
      openedAt: Value(openedAt),
      status: Value(status),
      closedBy: closedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(closedBy),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
      closingCash: Value(closingCash),
      totalCashSales: Value(totalCashSales),
      totalCardSales: Value(totalCardSales),
      totalWalletSales: Value(totalWalletSales),
      totalCreditSales: Value(totalCreditSales),
      totalExpenses: Value(totalExpenses),
      cashIn: Value(cashIn),
      cashOut: Value(cashOut),
      totalOrders: Value(totalOrders),
      totalKitchenTickets: Value(totalKitchenTickets),
      totalDiscounts: Value(totalDiscounts),
      totalTax: Value(totalTax),
      totalVoids: Value(totalVoids),
    );
  }

  factory CashRegister.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashRegister(
      id: serializer.fromJson<int>(json['id']),
      openedBy: serializer.fromJson<String>(json['openedBy']),
      openingCash: serializer.fromJson<double>(json['openingCash']),
      openedAt: serializer.fromJson<DateTime>(json['openedAt']),
      status: serializer.fromJson<String>(json['status']),
      closedBy: serializer.fromJson<String?>(json['closedBy']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
      closingCash: serializer.fromJson<double>(json['closingCash']),
      totalCashSales: serializer.fromJson<double>(json['totalCashSales']),
      totalCardSales: serializer.fromJson<double>(json['totalCardSales']),
      totalWalletSales: serializer.fromJson<double>(json['totalWalletSales']),
      totalCreditSales: serializer.fromJson<double>(json['totalCreditSales']),
      totalExpenses: serializer.fromJson<double>(json['totalExpenses']),
      cashIn: serializer.fromJson<double>(json['cashIn']),
      cashOut: serializer.fromJson<double>(json['cashOut']),
      totalOrders: serializer.fromJson<int>(json['totalOrders']),
      totalKitchenTickets:
          serializer.fromJson<int>(json['totalKitchenTickets']),
      totalDiscounts: serializer.fromJson<double>(json['totalDiscounts']),
      totalTax: serializer.fromJson<double>(json['totalTax']),
      totalVoids: serializer.fromJson<int>(json['totalVoids']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'openedBy': serializer.toJson<String>(openedBy),
      'openingCash': serializer.toJson<double>(openingCash),
      'openedAt': serializer.toJson<DateTime>(openedAt),
      'status': serializer.toJson<String>(status),
      'closedBy': serializer.toJson<String?>(closedBy),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
      'closingCash': serializer.toJson<double>(closingCash),
      'totalCashSales': serializer.toJson<double>(totalCashSales),
      'totalCardSales': serializer.toJson<double>(totalCardSales),
      'totalWalletSales': serializer.toJson<double>(totalWalletSales),
      'totalCreditSales': serializer.toJson<double>(totalCreditSales),
      'totalExpenses': serializer.toJson<double>(totalExpenses),
      'cashIn': serializer.toJson<double>(cashIn),
      'cashOut': serializer.toJson<double>(cashOut),
      'totalOrders': serializer.toJson<int>(totalOrders),
      'totalKitchenTickets': serializer.toJson<int>(totalKitchenTickets),
      'totalDiscounts': serializer.toJson<double>(totalDiscounts),
      'totalTax': serializer.toJson<double>(totalTax),
      'totalVoids': serializer.toJson<int>(totalVoids),
    };
  }

  CashRegister copyWith(
          {int? id,
          String? openedBy,
          double? openingCash,
          DateTime? openedAt,
          String? status,
          Value<String?> closedBy = const Value.absent(),
          Value<DateTime?> closedAt = const Value.absent(),
          double? closingCash,
          double? totalCashSales,
          double? totalCardSales,
          double? totalWalletSales,
          double? totalCreditSales,
          double? totalExpenses,
          double? cashIn,
          double? cashOut,
          int? totalOrders,
          int? totalKitchenTickets,
          double? totalDiscounts,
          double? totalTax,
          int? totalVoids}) =>
      CashRegister(
        id: id ?? this.id,
        openedBy: openedBy ?? this.openedBy,
        openingCash: openingCash ?? this.openingCash,
        openedAt: openedAt ?? this.openedAt,
        status: status ?? this.status,
        closedBy: closedBy.present ? closedBy.value : this.closedBy,
        closedAt: closedAt.present ? closedAt.value : this.closedAt,
        closingCash: closingCash ?? this.closingCash,
        totalCashSales: totalCashSales ?? this.totalCashSales,
        totalCardSales: totalCardSales ?? this.totalCardSales,
        totalWalletSales: totalWalletSales ?? this.totalWalletSales,
        totalCreditSales: totalCreditSales ?? this.totalCreditSales,
        totalExpenses: totalExpenses ?? this.totalExpenses,
        cashIn: cashIn ?? this.cashIn,
        cashOut: cashOut ?? this.cashOut,
        totalOrders: totalOrders ?? this.totalOrders,
        totalKitchenTickets: totalKitchenTickets ?? this.totalKitchenTickets,
        totalDiscounts: totalDiscounts ?? this.totalDiscounts,
        totalTax: totalTax ?? this.totalTax,
        totalVoids: totalVoids ?? this.totalVoids,
      );
  CashRegister copyWithCompanion(CashRegistersCompanion data) {
    return CashRegister(
      id: data.id.present ? data.id.value : this.id,
      openedBy: data.openedBy.present ? data.openedBy.value : this.openedBy,
      openingCash:
          data.openingCash.present ? data.openingCash.value : this.openingCash,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      status: data.status.present ? data.status.value : this.status,
      closedBy: data.closedBy.present ? data.closedBy.value : this.closedBy,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
      closingCash:
          data.closingCash.present ? data.closingCash.value : this.closingCash,
      totalCashSales: data.totalCashSales.present
          ? data.totalCashSales.value
          : this.totalCashSales,
      totalCardSales: data.totalCardSales.present
          ? data.totalCardSales.value
          : this.totalCardSales,
      totalWalletSales: data.totalWalletSales.present
          ? data.totalWalletSales.value
          : this.totalWalletSales,
      totalCreditSales: data.totalCreditSales.present
          ? data.totalCreditSales.value
          : this.totalCreditSales,
      totalExpenses: data.totalExpenses.present
          ? data.totalExpenses.value
          : this.totalExpenses,
      cashIn: data.cashIn.present ? data.cashIn.value : this.cashIn,
      cashOut: data.cashOut.present ? data.cashOut.value : this.cashOut,
      totalOrders:
          data.totalOrders.present ? data.totalOrders.value : this.totalOrders,
      totalKitchenTickets: data.totalKitchenTickets.present
          ? data.totalKitchenTickets.value
          : this.totalKitchenTickets,
      totalDiscounts: data.totalDiscounts.present
          ? data.totalDiscounts.value
          : this.totalDiscounts,
      totalTax: data.totalTax.present ? data.totalTax.value : this.totalTax,
      totalVoids:
          data.totalVoids.present ? data.totalVoids.value : this.totalVoids,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashRegister(')
          ..write('id: $id, ')
          ..write('openedBy: $openedBy, ')
          ..write('openingCash: $openingCash, ')
          ..write('openedAt: $openedAt, ')
          ..write('status: $status, ')
          ..write('closedBy: $closedBy, ')
          ..write('closedAt: $closedAt, ')
          ..write('closingCash: $closingCash, ')
          ..write('totalCashSales: $totalCashSales, ')
          ..write('totalCardSales: $totalCardSales, ')
          ..write('totalWalletSales: $totalWalletSales, ')
          ..write('totalCreditSales: $totalCreditSales, ')
          ..write('totalExpenses: $totalExpenses, ')
          ..write('cashIn: $cashIn, ')
          ..write('cashOut: $cashOut, ')
          ..write('totalOrders: $totalOrders, ')
          ..write('totalKitchenTickets: $totalKitchenTickets, ')
          ..write('totalDiscounts: $totalDiscounts, ')
          ..write('totalTax: $totalTax, ')
          ..write('totalVoids: $totalVoids')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      openedBy,
      openingCash,
      openedAt,
      status,
      closedBy,
      closedAt,
      closingCash,
      totalCashSales,
      totalCardSales,
      totalWalletSales,
      totalCreditSales,
      totalExpenses,
      cashIn,
      cashOut,
      totalOrders,
      totalKitchenTickets,
      totalDiscounts,
      totalTax,
      totalVoids);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashRegister &&
          other.id == this.id &&
          other.openedBy == this.openedBy &&
          other.openingCash == this.openingCash &&
          other.openedAt == this.openedAt &&
          other.status == this.status &&
          other.closedBy == this.closedBy &&
          other.closedAt == this.closedAt &&
          other.closingCash == this.closingCash &&
          other.totalCashSales == this.totalCashSales &&
          other.totalCardSales == this.totalCardSales &&
          other.totalWalletSales == this.totalWalletSales &&
          other.totalCreditSales == this.totalCreditSales &&
          other.totalExpenses == this.totalExpenses &&
          other.cashIn == this.cashIn &&
          other.cashOut == this.cashOut &&
          other.totalOrders == this.totalOrders &&
          other.totalKitchenTickets == this.totalKitchenTickets &&
          other.totalDiscounts == this.totalDiscounts &&
          other.totalTax == this.totalTax &&
          other.totalVoids == this.totalVoids);
}

class CashRegistersCompanion extends UpdateCompanion<CashRegister> {
  final Value<int> id;
  final Value<String> openedBy;
  final Value<double> openingCash;
  final Value<DateTime> openedAt;
  final Value<String> status;
  final Value<String?> closedBy;
  final Value<DateTime?> closedAt;
  final Value<double> closingCash;
  final Value<double> totalCashSales;
  final Value<double> totalCardSales;
  final Value<double> totalWalletSales;
  final Value<double> totalCreditSales;
  final Value<double> totalExpenses;
  final Value<double> cashIn;
  final Value<double> cashOut;
  final Value<int> totalOrders;
  final Value<int> totalKitchenTickets;
  final Value<double> totalDiscounts;
  final Value<double> totalTax;
  final Value<int> totalVoids;
  const CashRegistersCompanion({
    this.id = const Value.absent(),
    this.openedBy = const Value.absent(),
    this.openingCash = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.closedBy = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.closingCash = const Value.absent(),
    this.totalCashSales = const Value.absent(),
    this.totalCardSales = const Value.absent(),
    this.totalWalletSales = const Value.absent(),
    this.totalCreditSales = const Value.absent(),
    this.totalExpenses = const Value.absent(),
    this.cashIn = const Value.absent(),
    this.cashOut = const Value.absent(),
    this.totalOrders = const Value.absent(),
    this.totalKitchenTickets = const Value.absent(),
    this.totalDiscounts = const Value.absent(),
    this.totalTax = const Value.absent(),
    this.totalVoids = const Value.absent(),
  });
  CashRegistersCompanion.insert({
    this.id = const Value.absent(),
    required String openedBy,
    required double openingCash,
    this.openedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.closedBy = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.closingCash = const Value.absent(),
    this.totalCashSales = const Value.absent(),
    this.totalCardSales = const Value.absent(),
    this.totalWalletSales = const Value.absent(),
    this.totalCreditSales = const Value.absent(),
    this.totalExpenses = const Value.absent(),
    this.cashIn = const Value.absent(),
    this.cashOut = const Value.absent(),
    this.totalOrders = const Value.absent(),
    this.totalKitchenTickets = const Value.absent(),
    this.totalDiscounts = const Value.absent(),
    this.totalTax = const Value.absent(),
    this.totalVoids = const Value.absent(),
  })  : openedBy = Value(openedBy),
        openingCash = Value(openingCash);
  static Insertable<CashRegister> custom({
    Expression<int>? id,
    Expression<String>? openedBy,
    Expression<double>? openingCash,
    Expression<DateTime>? openedAt,
    Expression<String>? status,
    Expression<String>? closedBy,
    Expression<DateTime>? closedAt,
    Expression<double>? closingCash,
    Expression<double>? totalCashSales,
    Expression<double>? totalCardSales,
    Expression<double>? totalWalletSales,
    Expression<double>? totalCreditSales,
    Expression<double>? totalExpenses,
    Expression<double>? cashIn,
    Expression<double>? cashOut,
    Expression<int>? totalOrders,
    Expression<int>? totalKitchenTickets,
    Expression<double>? totalDiscounts,
    Expression<double>? totalTax,
    Expression<int>? totalVoids,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (openedBy != null) 'opened_by': openedBy,
      if (openingCash != null) 'opening_cash': openingCash,
      if (openedAt != null) 'opened_at': openedAt,
      if (status != null) 'status': status,
      if (closedBy != null) 'closed_by': closedBy,
      if (closedAt != null) 'closed_at': closedAt,
      if (closingCash != null) 'closing_cash': closingCash,
      if (totalCashSales != null) 'total_cash_sales': totalCashSales,
      if (totalCardSales != null) 'total_card_sales': totalCardSales,
      if (totalWalletSales != null) 'total_wallet_sales': totalWalletSales,
      if (totalCreditSales != null) 'total_credit_sales': totalCreditSales,
      if (totalExpenses != null) 'total_expenses': totalExpenses,
      if (cashIn != null) 'cash_in': cashIn,
      if (cashOut != null) 'cash_out': cashOut,
      if (totalOrders != null) 'total_orders': totalOrders,
      if (totalKitchenTickets != null)
        'total_kitchen_tickets': totalKitchenTickets,
      if (totalDiscounts != null) 'total_discounts': totalDiscounts,
      if (totalTax != null) 'total_tax': totalTax,
      if (totalVoids != null) 'total_voids': totalVoids,
    });
  }

  CashRegistersCompanion copyWith(
      {Value<int>? id,
      Value<String>? openedBy,
      Value<double>? openingCash,
      Value<DateTime>? openedAt,
      Value<String>? status,
      Value<String?>? closedBy,
      Value<DateTime?>? closedAt,
      Value<double>? closingCash,
      Value<double>? totalCashSales,
      Value<double>? totalCardSales,
      Value<double>? totalWalletSales,
      Value<double>? totalCreditSales,
      Value<double>? totalExpenses,
      Value<double>? cashIn,
      Value<double>? cashOut,
      Value<int>? totalOrders,
      Value<int>? totalKitchenTickets,
      Value<double>? totalDiscounts,
      Value<double>? totalTax,
      Value<int>? totalVoids}) {
    return CashRegistersCompanion(
      id: id ?? this.id,
      openedBy: openedBy ?? this.openedBy,
      openingCash: openingCash ?? this.openingCash,
      openedAt: openedAt ?? this.openedAt,
      status: status ?? this.status,
      closedBy: closedBy ?? this.closedBy,
      closedAt: closedAt ?? this.closedAt,
      closingCash: closingCash ?? this.closingCash,
      totalCashSales: totalCashSales ?? this.totalCashSales,
      totalCardSales: totalCardSales ?? this.totalCardSales,
      totalWalletSales: totalWalletSales ?? this.totalWalletSales,
      totalCreditSales: totalCreditSales ?? this.totalCreditSales,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      cashIn: cashIn ?? this.cashIn,
      cashOut: cashOut ?? this.cashOut,
      totalOrders: totalOrders ?? this.totalOrders,
      totalKitchenTickets: totalKitchenTickets ?? this.totalKitchenTickets,
      totalDiscounts: totalDiscounts ?? this.totalDiscounts,
      totalTax: totalTax ?? this.totalTax,
      totalVoids: totalVoids ?? this.totalVoids,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (openedBy.present) {
      map['opened_by'] = Variable<String>(openedBy.value);
    }
    if (openingCash.present) {
      map['opening_cash'] = Variable<double>(openingCash.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (closedBy.present) {
      map['closed_by'] = Variable<String>(closedBy.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (closingCash.present) {
      map['closing_cash'] = Variable<double>(closingCash.value);
    }
    if (totalCashSales.present) {
      map['total_cash_sales'] = Variable<double>(totalCashSales.value);
    }
    if (totalCardSales.present) {
      map['total_card_sales'] = Variable<double>(totalCardSales.value);
    }
    if (totalWalletSales.present) {
      map['total_wallet_sales'] = Variable<double>(totalWalletSales.value);
    }
    if (totalCreditSales.present) {
      map['total_credit_sales'] = Variable<double>(totalCreditSales.value);
    }
    if (totalExpenses.present) {
      map['total_expenses'] = Variable<double>(totalExpenses.value);
    }
    if (cashIn.present) {
      map['cash_in'] = Variable<double>(cashIn.value);
    }
    if (cashOut.present) {
      map['cash_out'] = Variable<double>(cashOut.value);
    }
    if (totalOrders.present) {
      map['total_orders'] = Variable<int>(totalOrders.value);
    }
    if (totalKitchenTickets.present) {
      map['total_kitchen_tickets'] = Variable<int>(totalKitchenTickets.value);
    }
    if (totalDiscounts.present) {
      map['total_discounts'] = Variable<double>(totalDiscounts.value);
    }
    if (totalTax.present) {
      map['total_tax'] = Variable<double>(totalTax.value);
    }
    if (totalVoids.present) {
      map['total_voids'] = Variable<int>(totalVoids.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashRegistersCompanion(')
          ..write('id: $id, ')
          ..write('openedBy: $openedBy, ')
          ..write('openingCash: $openingCash, ')
          ..write('openedAt: $openedAt, ')
          ..write('status: $status, ')
          ..write('closedBy: $closedBy, ')
          ..write('closedAt: $closedAt, ')
          ..write('closingCash: $closingCash, ')
          ..write('totalCashSales: $totalCashSales, ')
          ..write('totalCardSales: $totalCardSales, ')
          ..write('totalWalletSales: $totalWalletSales, ')
          ..write('totalCreditSales: $totalCreditSales, ')
          ..write('totalExpenses: $totalExpenses, ')
          ..write('cashIn: $cashIn, ')
          ..write('cashOut: $cashOut, ')
          ..write('totalOrders: $totalOrders, ')
          ..write('totalKitchenTickets: $totalKitchenTickets, ')
          ..write('totalDiscounts: $totalDiscounts, ')
          ..write('totalTax: $totalTax, ')
          ..write('totalVoids: $totalVoids')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paidByMeta = const VerificationMeta('paidBy');
  @override
  late final GeneratedColumn<String> paidBy = GeneratedColumn<String>(
      'paid_by', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _registerIdMeta =
      const VerificationMeta('registerId');
  @override
  late final GeneratedColumn<int> registerId = GeneratedColumn<int>(
      'register_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, category, amount, description, paidBy, registerId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(Insertable<Expense> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('paid_by')) {
      context.handle(_paidByMeta,
          paidBy.isAcceptableOrUnknown(data['paid_by']!, _paidByMeta));
    } else if (isInserting) {
      context.missing(_paidByMeta);
    }
    if (data.containsKey('register_id')) {
      context.handle(
          _registerIdMeta,
          registerId.isAcceptableOrUnknown(
              data['register_id']!, _registerIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      paidBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}paid_by'])!,
      registerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}register_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final String category;
  final double amount;
  final String description;
  final String paidBy;
  final int? registerId;
  final DateTime createdAt;
  const Expense(
      {required this.id,
      required this.category,
      required this.amount,
      required this.description,
      required this.paidBy,
      this.registerId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<double>(amount);
    map['description'] = Variable<String>(description);
    map['paid_by'] = Variable<String>(paidBy);
    if (!nullToAbsent || registerId != null) {
      map['register_id'] = Variable<int>(registerId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      category: Value(category),
      amount: Value(amount),
      description: Value(description),
      paidBy: Value(paidBy),
      registerId: registerId == null && nullToAbsent
          ? const Value.absent()
          : Value(registerId),
      createdAt: Value(createdAt),
    );
  }

  factory Expense.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<double>(json['amount']),
      description: serializer.fromJson<String>(json['description']),
      paidBy: serializer.fromJson<String>(json['paidBy']),
      registerId: serializer.fromJson<int?>(json['registerId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<double>(amount),
      'description': serializer.toJson<String>(description),
      'paidBy': serializer.toJson<String>(paidBy),
      'registerId': serializer.toJson<int?>(registerId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Expense copyWith(
          {int? id,
          String? category,
          double? amount,
          String? description,
          String? paidBy,
          Value<int?> registerId = const Value.absent(),
          DateTime? createdAt}) =>
      Expense(
        id: id ?? this.id,
        category: category ?? this.category,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        paidBy: paidBy ?? this.paidBy,
        registerId: registerId.present ? registerId.value : this.registerId,
        createdAt: createdAt ?? this.createdAt,
      );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      description:
          data.description.present ? data.description.value : this.description,
      paidBy: data.paidBy.present ? data.paidBy.value : this.paidBy,
      registerId:
          data.registerId.present ? data.registerId.value : this.registerId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('paidBy: $paidBy, ')
          ..write('registerId: $registerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, category, amount, description, paidBy, registerId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.description == this.description &&
          other.paidBy == this.paidBy &&
          other.registerId == this.registerId &&
          other.createdAt == this.createdAt);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<String> category;
  final Value<double> amount;
  final Value<String> description;
  final Value<String> paidBy;
  final Value<int?> registerId;
  final Value<DateTime> createdAt;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
    this.paidBy = const Value.absent(),
    this.registerId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    required double amount,
    required String description,
    required String paidBy,
    this.registerId = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : category = Value(category),
        amount = Value(amount),
        description = Value(description),
        paidBy = Value(paidBy);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<String>? description,
    Expression<String>? paidBy,
    Expression<int>? registerId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (paidBy != null) 'paid_by': paidBy,
      if (registerId != null) 'register_id': registerId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExpensesCompanion copyWith(
      {Value<int>? id,
      Value<String>? category,
      Value<double>? amount,
      Value<String>? description,
      Value<String>? paidBy,
      Value<int?>? registerId,
      Value<DateTime>? createdAt}) {
    return ExpensesCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      paidBy: paidBy ?? this.paidBy,
      registerId: registerId ?? this.registerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (paidBy.present) {
      map['paid_by'] = Variable<String>(paidBy.value);
    }
    if (registerId.present) {
      map['register_id'] = Variable<int>(registerId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('paidBy: $paidBy, ')
          ..write('registerId: $registerId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AttendanceTable extends Attendance
    with TableInfo<$AttendanceTable, AttendanceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _userNameMeta =
      const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
      'user_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _checkInMeta =
      const VerificationMeta('checkIn');
  @override
  late final GeneratedColumn<DateTime> checkIn = GeneratedColumn<DateTime>(
      'check_in', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _checkOutMeta =
      const VerificationMeta('checkOut');
  @override
  late final GeneratedColumn<DateTime> checkOut = GeneratedColumn<DateTime>(
      'check_out', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dailyWageMeta =
      const VerificationMeta('dailyWage');
  @override
  late final GeneratedColumn<double> dailyWage = GeneratedColumn<double>(
      'daily_wage', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, userName, checkIn, checkOut, dailyWage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance';
  @override
  VerificationContext validateIntegrity(Insertable<AttendanceData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('check_in')) {
      context.handle(_checkInMeta,
          checkIn.isAcceptableOrUnknown(data['check_in']!, _checkInMeta));
    } else if (isInserting) {
      context.missing(_checkInMeta);
    }
    if (data.containsKey('check_out')) {
      context.handle(_checkOutMeta,
          checkOut.isAcceptableOrUnknown(data['check_out']!, _checkOutMeta));
    }
    if (data.containsKey('daily_wage')) {
      context.handle(_dailyWageMeta,
          dailyWage.isAcceptableOrUnknown(data['daily_wage']!, _dailyWageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttendanceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      userName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_name'])!,
      checkIn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}check_in'])!,
      checkOut: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}check_out']),
      dailyWage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}daily_wage'])!,
    );
  }

  @override
  $AttendanceTable createAlias(String alias) {
    return $AttendanceTable(attachedDatabase, alias);
  }
}

class AttendanceData extends DataClass implements Insertable<AttendanceData> {
  final int id;
  final int userId;
  final String userName;
  final DateTime checkIn;
  final DateTime? checkOut;
  final double dailyWage;
  const AttendanceData(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.checkIn,
      this.checkOut,
      required this.dailyWage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['user_name'] = Variable<String>(userName);
    map['check_in'] = Variable<DateTime>(checkIn);
    if (!nullToAbsent || checkOut != null) {
      map['check_out'] = Variable<DateTime>(checkOut);
    }
    map['daily_wage'] = Variable<double>(dailyWage);
    return map;
  }

  AttendanceCompanion toCompanion(bool nullToAbsent) {
    return AttendanceCompanion(
      id: Value(id),
      userId: Value(userId),
      userName: Value(userName),
      checkIn: Value(checkIn),
      checkOut: checkOut == null && nullToAbsent
          ? const Value.absent()
          : Value(checkOut),
      dailyWage: Value(dailyWage),
    );
  }

  factory AttendanceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      userName: serializer.fromJson<String>(json['userName']),
      checkIn: serializer.fromJson<DateTime>(json['checkIn']),
      checkOut: serializer.fromJson<DateTime?>(json['checkOut']),
      dailyWage: serializer.fromJson<double>(json['dailyWage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'userName': serializer.toJson<String>(userName),
      'checkIn': serializer.toJson<DateTime>(checkIn),
      'checkOut': serializer.toJson<DateTime?>(checkOut),
      'dailyWage': serializer.toJson<double>(dailyWage),
    };
  }

  AttendanceData copyWith(
          {int? id,
          int? userId,
          String? userName,
          DateTime? checkIn,
          Value<DateTime?> checkOut = const Value.absent(),
          double? dailyWage}) =>
      AttendanceData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        checkIn: checkIn ?? this.checkIn,
        checkOut: checkOut.present ? checkOut.value : this.checkOut,
        dailyWage: dailyWage ?? this.dailyWage,
      );
  AttendanceData copyWithCompanion(AttendanceCompanion data) {
    return AttendanceData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      userName: data.userName.present ? data.userName.value : this.userName,
      checkIn: data.checkIn.present ? data.checkIn.value : this.checkIn,
      checkOut: data.checkOut.present ? data.checkOut.value : this.checkOut,
      dailyWage: data.dailyWage.present ? data.dailyWage.value : this.dailyWage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('checkIn: $checkIn, ')
          ..write('checkOut: $checkOut, ')
          ..write('dailyWage: $dailyWage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, userName, checkIn, checkOut, dailyWage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.userName == this.userName &&
          other.checkIn == this.checkIn &&
          other.checkOut == this.checkOut &&
          other.dailyWage == this.dailyWage);
}

class AttendanceCompanion extends UpdateCompanion<AttendanceData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> userName;
  final Value<DateTime> checkIn;
  final Value<DateTime?> checkOut;
  final Value<double> dailyWage;
  const AttendanceCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    this.checkIn = const Value.absent(),
    this.checkOut = const Value.absent(),
    this.dailyWage = const Value.absent(),
  });
  AttendanceCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String userName,
    required DateTime checkIn,
    this.checkOut = const Value.absent(),
    this.dailyWage = const Value.absent(),
  })  : userId = Value(userId),
        userName = Value(userName),
        checkIn = Value(checkIn);
  static Insertable<AttendanceData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? userName,
    Expression<DateTime>? checkIn,
    Expression<DateTime>? checkOut,
    Expression<double>? dailyWage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (checkIn != null) 'check_in': checkIn,
      if (checkOut != null) 'check_out': checkOut,
      if (dailyWage != null) 'daily_wage': dailyWage,
    });
  }

  AttendanceCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String>? userName,
      Value<DateTime>? checkIn,
      Value<DateTime?>? checkOut,
      Value<double>? dailyWage}) {
    return AttendanceCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      dailyWage: dailyWage ?? this.dailyWage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (checkIn.present) {
      map['check_in'] = Variable<DateTime>(checkIn.value);
    }
    if (checkOut.present) {
      map['check_out'] = Variable<DateTime>(checkOut.value);
    }
    if (dailyWage.present) {
      map['daily_wage'] = Variable<double>(dailyWage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('checkIn: $checkIn, ')
          ..write('checkOut: $checkOut, ')
          ..write('dailyWage: $dailyWage')
          ..write(')'))
        .toString();
  }
}

class $SalaryPaymentsTable extends SalaryPayments
    with TableInfo<$SalaryPaymentsTable, SalaryPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalaryPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _userNameMeta =
      const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
      'user_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
      'paid_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, userName, month, year, amount, notes, paidAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'salary_payments';
  @override
  VerificationContext validateIntegrity(Insertable<SalaryPayment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('paid_at')) {
      context.handle(_paidAtMeta,
          paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalaryPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalaryPayment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      userName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_name'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      paidAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}paid_at'])!,
    );
  }

  @override
  $SalaryPaymentsTable createAlias(String alias) {
    return $SalaryPaymentsTable(attachedDatabase, alias);
  }
}

class SalaryPayment extends DataClass implements Insertable<SalaryPayment> {
  final int id;
  final int userId;
  final String userName;
  final int month;
  final int year;
  final double amount;
  final String? notes;
  final DateTime paidAt;
  const SalaryPayment(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.month,
      required this.year,
      required this.amount,
      this.notes,
      required this.paidAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['user_name'] = Variable<String>(userName);
    map['month'] = Variable<int>(month);
    map['year'] = Variable<int>(year);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['paid_at'] = Variable<DateTime>(paidAt);
    return map;
  }

  SalaryPaymentsCompanion toCompanion(bool nullToAbsent) {
    return SalaryPaymentsCompanion(
      id: Value(id),
      userId: Value(userId),
      userName: Value(userName),
      month: Value(month),
      year: Value(year),
      amount: Value(amount),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      paidAt: Value(paidAt),
    );
  }

  factory SalaryPayment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalaryPayment(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      userName: serializer.fromJson<String>(json['userName']),
      month: serializer.fromJson<int>(json['month']),
      year: serializer.fromJson<int>(json['year']),
      amount: serializer.fromJson<double>(json['amount']),
      notes: serializer.fromJson<String?>(json['notes']),
      paidAt: serializer.fromJson<DateTime>(json['paidAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'userName': serializer.toJson<String>(userName),
      'month': serializer.toJson<int>(month),
      'year': serializer.toJson<int>(year),
      'amount': serializer.toJson<double>(amount),
      'notes': serializer.toJson<String?>(notes),
      'paidAt': serializer.toJson<DateTime>(paidAt),
    };
  }

  SalaryPayment copyWith(
          {int? id,
          int? userId,
          String? userName,
          int? month,
          int? year,
          double? amount,
          Value<String?> notes = const Value.absent(),
          DateTime? paidAt}) =>
      SalaryPayment(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        month: month ?? this.month,
        year: year ?? this.year,
        amount: amount ?? this.amount,
        notes: notes.present ? notes.value : this.notes,
        paidAt: paidAt ?? this.paidAt,
      );
  SalaryPayment copyWithCompanion(SalaryPaymentsCompanion data) {
    return SalaryPayment(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      userName: data.userName.present ? data.userName.value : this.userName,
      month: data.month.present ? data.month.value : this.month,
      year: data.year.present ? data.year.value : this.year,
      amount: data.amount.present ? data.amount.value : this.amount,
      notes: data.notes.present ? data.notes.value : this.notes,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalaryPayment(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes, ')
          ..write('paidAt: $paidAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, userName, month, year, amount, notes, paidAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalaryPayment &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.userName == this.userName &&
          other.month == this.month &&
          other.year == this.year &&
          other.amount == this.amount &&
          other.notes == this.notes &&
          other.paidAt == this.paidAt);
}

class SalaryPaymentsCompanion extends UpdateCompanion<SalaryPayment> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> userName;
  final Value<int> month;
  final Value<int> year;
  final Value<double> amount;
  final Value<String?> notes;
  final Value<DateTime> paidAt;
  const SalaryPaymentsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    this.month = const Value.absent(),
    this.year = const Value.absent(),
    this.amount = const Value.absent(),
    this.notes = const Value.absent(),
    this.paidAt = const Value.absent(),
  });
  SalaryPaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String userName,
    required int month,
    required int year,
    required double amount,
    this.notes = const Value.absent(),
    this.paidAt = const Value.absent(),
  })  : userId = Value(userId),
        userName = Value(userName),
        month = Value(month),
        year = Value(year),
        amount = Value(amount);
  static Insertable<SalaryPayment> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? userName,
    Expression<int>? month,
    Expression<int>? year,
    Expression<double>? amount,
    Expression<String>? notes,
    Expression<DateTime>? paidAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (month != null) 'month': month,
      if (year != null) 'year': year,
      if (amount != null) 'amount': amount,
      if (notes != null) 'notes': notes,
      if (paidAt != null) 'paid_at': paidAt,
    });
  }

  SalaryPaymentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String>? userName,
      Value<int>? month,
      Value<int>? year,
      Value<double>? amount,
      Value<String?>? notes,
      Value<DateTime>? paidAt}) {
    return SalaryPaymentsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      month: month ?? this.month,
      year: year ?? this.year,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
      paidAt: paidAt ?? this.paidAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalaryPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('month: $month, ')
          ..write('year: $year, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes, ')
          ..write('paidAt: $paidAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppSetting(
      {required this.id,
      required this.key,
      required this.value,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith(
          {int? id, String? key, String? value, DateTime? updatedAt}) =>
      AppSetting(
        id: id ?? this.id,
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String value,
    this.updatedAt = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AppSettingsCompanion copyWith(
      {Value<int>? id,
      Value<String>? key,
      Value<String>? value,
      Value<DateTime>? updatedAt}) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DealItemsTable extends DealItems
    with TableInfo<$DealItemsTable, DealItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DealItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dealIdMeta = const VerificationMeta('dealId');
  @override
  late final GeneratedColumn<int> dealId = GeneratedColumn<int>(
      'deal_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES deals (id) ON DELETE CASCADE'));
  static const VerificationMeta _menuItemIdMeta =
      const VerificationMeta('menuItemId');
  @override
  late final GeneratedColumn<int> menuItemId = GeneratedColumn<int>(
      'menu_item_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES menu_items (id)'));
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, dealId, menuItemId, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deal_items';
  @override
  VerificationContext validateIntegrity(Insertable<DealItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('deal_id')) {
      context.handle(_dealIdMeta,
          dealId.isAcceptableOrUnknown(data['deal_id']!, _dealIdMeta));
    } else if (isInserting) {
      context.missing(_dealIdMeta);
    }
    if (data.containsKey('menu_item_id')) {
      context.handle(
          _menuItemIdMeta,
          menuItemId.isAcceptableOrUnknown(
              data['menu_item_id']!, _menuItemIdMeta));
    } else if (isInserting) {
      context.missing(_menuItemIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DealItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DealItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dealId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deal_id'])!,
      menuItemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}menu_item_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
    );
  }

  @override
  $DealItemsTable createAlias(String alias) {
    return $DealItemsTable(attachedDatabase, alias);
  }
}

class DealItem extends DataClass implements Insertable<DealItem> {
  final int id;
  final int dealId;
  final int menuItemId;
  final int quantity;
  const DealItem(
      {required this.id,
      required this.dealId,
      required this.menuItemId,
      required this.quantity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['deal_id'] = Variable<int>(dealId);
    map['menu_item_id'] = Variable<int>(menuItemId);
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  DealItemsCompanion toCompanion(bool nullToAbsent) {
    return DealItemsCompanion(
      id: Value(id),
      dealId: Value(dealId),
      menuItemId: Value(menuItemId),
      quantity: Value(quantity),
    );
  }

  factory DealItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DealItem(
      id: serializer.fromJson<int>(json['id']),
      dealId: serializer.fromJson<int>(json['dealId']),
      menuItemId: serializer.fromJson<int>(json['menuItemId']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dealId': serializer.toJson<int>(dealId),
      'menuItemId': serializer.toJson<int>(menuItemId),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  DealItem copyWith({int? id, int? dealId, int? menuItemId, int? quantity}) =>
      DealItem(
        id: id ?? this.id,
        dealId: dealId ?? this.dealId,
        menuItemId: menuItemId ?? this.menuItemId,
        quantity: quantity ?? this.quantity,
      );
  DealItem copyWithCompanion(DealItemsCompanion data) {
    return DealItem(
      id: data.id.present ? data.id.value : this.id,
      dealId: data.dealId.present ? data.dealId.value : this.dealId,
      menuItemId:
          data.menuItemId.present ? data.menuItemId.value : this.menuItemId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DealItem(')
          ..write('id: $id, ')
          ..write('dealId: $dealId, ')
          ..write('menuItemId: $menuItemId, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dealId, menuItemId, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DealItem &&
          other.id == this.id &&
          other.dealId == this.dealId &&
          other.menuItemId == this.menuItemId &&
          other.quantity == this.quantity);
}

class DealItemsCompanion extends UpdateCompanion<DealItem> {
  final Value<int> id;
  final Value<int> dealId;
  final Value<int> menuItemId;
  final Value<int> quantity;
  const DealItemsCompanion({
    this.id = const Value.absent(),
    this.dealId = const Value.absent(),
    this.menuItemId = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  DealItemsCompanion.insert({
    this.id = const Value.absent(),
    required int dealId,
    required int menuItemId,
    required int quantity,
  })  : dealId = Value(dealId),
        menuItemId = Value(menuItemId),
        quantity = Value(quantity);
  static Insertable<DealItem> custom({
    Expression<int>? id,
    Expression<int>? dealId,
    Expression<int>? menuItemId,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dealId != null) 'deal_id': dealId,
      if (menuItemId != null) 'menu_item_id': menuItemId,
      if (quantity != null) 'quantity': quantity,
    });
  }

  DealItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? dealId,
      Value<int>? menuItemId,
      Value<int>? quantity}) {
    return DealItemsCompanion(
      id: id ?? this.id,
      dealId: dealId ?? this.dealId,
      menuItemId: menuItemId ?? this.menuItemId,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dealId.present) {
      map['deal_id'] = Variable<int>(dealId.value);
    }
    if (menuItemId.present) {
      map['menu_item_id'] = Variable<int>(menuItemId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DealItemsCompanion(')
          ..write('id: $id, ')
          ..write('dealId: $dealId, ')
          ..write('menuItemId: $menuItemId, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

class $BackupHistoriesTable extends BackupHistories
    with TableInfo<$BackupHistoriesTable, BackupHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sizeBytesMeta =
      const VerificationMeta('sizeBytes');
  @override
  late final GeneratedColumn<double> sizeBytes = GeneratedColumn<double>(
      'size_bytes', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, location, status, errorMessage, sizeBytes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_histories';
  @override
  VerificationContext validateIntegrity(Insertable<BackupHistory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    if (data.containsKey('size_bytes')) {
      context.handle(_sizeBytesMeta,
          sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackupHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupHistory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
      sizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}size_bytes'])!,
    );
  }

  @override
  $BackupHistoriesTable createAlias(String alias) {
    return $BackupHistoriesTable(attachedDatabase, alias);
  }
}

class BackupHistory extends DataClass implements Insertable<BackupHistory> {
  final int id;
  final DateTime createdAt;
  final String location;
  final String status;
  final String? errorMessage;
  final double sizeBytes;
  const BackupHistory(
      {required this.id,
      required this.createdAt,
      required this.location,
      required this.status,
      this.errorMessage,
      required this.sizeBytes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['location'] = Variable<String>(location);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['size_bytes'] = Variable<double>(sizeBytes);
    return map;
  }

  BackupHistoriesCompanion toCompanion(bool nullToAbsent) {
    return BackupHistoriesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      location: Value(location),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      sizeBytes: Value(sizeBytes),
    );
  }

  factory BackupHistory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupHistory(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      location: serializer.fromJson<String>(json['location']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      sizeBytes: serializer.fromJson<double>(json['sizeBytes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'location': serializer.toJson<String>(location),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'sizeBytes': serializer.toJson<double>(sizeBytes),
    };
  }

  BackupHistory copyWith(
          {int? id,
          DateTime? createdAt,
          String? location,
          String? status,
          Value<String?> errorMessage = const Value.absent(),
          double? sizeBytes}) =>
      BackupHistory(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        location: location ?? this.location,
        status: status ?? this.status,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
        sizeBytes: sizeBytes ?? this.sizeBytes,
      );
  BackupHistory copyWithCompanion(BackupHistoriesCompanion data) {
    return BackupHistory(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      location: data.location.present ? data.location.value : this.location,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupHistory(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('location: $location, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('sizeBytes: $sizeBytes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, location, status, errorMessage, sizeBytes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupHistory &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.location == this.location &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage &&
          other.sizeBytes == this.sizeBytes);
}

class BackupHistoriesCompanion extends UpdateCompanion<BackupHistory> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<String> location;
  final Value<String> status;
  final Value<String?> errorMessage;
  final Value<double> sizeBytes;
  const BackupHistoriesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.location = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.sizeBytes = const Value.absent(),
  });
  BackupHistoriesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String location,
    required String status,
    this.errorMessage = const Value.absent(),
    this.sizeBytes = const Value.absent(),
  })  : location = Value(location),
        status = Value(status);
  static Insertable<BackupHistory> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? location,
    Expression<String>? status,
    Expression<String>? errorMessage,
    Expression<double>? sizeBytes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (location != null) 'location': location,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
    });
  }

  BackupHistoriesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? createdAt,
      Value<String>? location,
      Value<String>? status,
      Value<String?>? errorMessage,
      Value<double>? sizeBytes}) {
    return BackupHistoriesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      location: location ?? this.location,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      sizeBytes: sizeBytes ?? this.sizeBytes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<double>(sizeBytes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('location: $location, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('sizeBytes: $sizeBytes')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $FloorsTable floors = $FloorsTable(this);
  late final $RestaurantTablesTable restaurantTables =
      $RestaurantTablesTable(this);
  late final $MenuGroupsTable menuGroups = $MenuGroupsTable(this);
  late final $MenuItemsTable menuItems = $MenuItemsTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $DealsTable deals = $DealsTable(this);
  late final $OrderItemsTable orderItems = $OrderItemsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $CreditLedgerTable creditLedger = $CreditLedgerTable(this);
  late final $InventoryItemsTable inventoryItems = $InventoryItemsTable(this);
  late final $CashRegistersTable cashRegisters = $CashRegistersTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $AttendanceTable attendance = $AttendanceTable(this);
  late final $SalaryPaymentsTable salaryPayments = $SalaryPaymentsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $DealItemsTable dealItems = $DealItemsTable(this);
  late final $BackupHistoriesTable backupHistories =
      $BackupHistoriesTable(this);
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final TableDao tableDao = TableDao(this as AppDatabase);
  late final MenuDao menuDao = MenuDao(this as AppDatabase);
  late final OrderDao orderDao = OrderDao(this as AppDatabase);
  late final InvoiceDao invoiceDao = InvoiceDao(this as AppDatabase);
  late final CustomerDao customerDao = CustomerDao(this as AppDatabase);
  late final RegisterDao registerDao = RegisterDao(this as AppDatabase);
  late final HRDao hRDao = HRDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  late final DealDao dealDao = DealDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        floors,
        restaurantTables,
        menuGroups,
        menuItems,
        orders,
        deals,
        orderItems,
        invoices,
        customers,
        creditLedger,
        inventoryItems,
        cashRegisters,
        expenses,
        attendance,
        salaryPayments,
        appSettings,
        dealItems,
        backupHistories
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('orders',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('order_items', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('deals',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('deal_items', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String name,
  required String email,
  required String passwordHash,
  required String role,
  Value<String?> phone,
  Value<String?> photoPath,
  Value<double> salary,
  Value<String> wageType,
  Value<bool> isActive,
  Value<String> permissionsJson,
  Value<DateTime> createdAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> email,
  Value<String> passwordHash,
  Value<String> role,
  Value<String?> phone,
  Value<String?> photoPath,
  Value<double> salary,
  Value<String> wageType,
  Value<bool> isActive,
  Value<String> permissionsJson,
  Value<DateTime> createdAt,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrdersTable, List<Order>> _ordersRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.orders,
          aliasName: $_aliasNameGenerator(db.users.id, db.orders.waiterId));

  $$OrdersTableProcessedTableManager get ordersRefs {
    final manager = $$OrdersTableTableManager($_db, $_db.orders)
        .filter((f) => f.waiterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AttendanceTable, List<AttendanceData>>
      _attendanceRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.attendance,
          aliasName: $_aliasNameGenerator(db.users.id, db.attendance.userId));

  $$AttendanceTableProcessedTableManager get attendanceRefs {
    final manager = $$AttendanceTableTableManager($_db, $_db.attendance)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_attendanceRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SalaryPaymentsTable, List<SalaryPayment>>
      _salaryPaymentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.salaryPayments,
              aliasName:
                  $_aliasNameGenerator(db.users.id, db.salaryPayments.userId));

  $$SalaryPaymentsTableProcessedTableManager get salaryPaymentsRefs {
    final manager = $$SalaryPaymentsTableTableManager($_db, $_db.salaryPayments)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_salaryPaymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get salary => $composableBuilder(
      column: $table.salary, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wageType => $composableBuilder(
      column: $table.wageType, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get permissionsJson => $composableBuilder(
      column: $table.permissionsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> ordersRefs(
      Expression<bool> Function($$OrdersTableFilterComposer f) f) {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.waiterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableFilterComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> attendanceRefs(
      Expression<bool> Function($$AttendanceTableFilterComposer f) f) {
    final $$AttendanceTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attendance,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttendanceTableFilterComposer(
              $db: $db,
              $table: $db.attendance,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> salaryPaymentsRefs(
      Expression<bool> Function($$SalaryPaymentsTableFilterComposer f) f) {
    final $$SalaryPaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.salaryPayments,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SalaryPaymentsTableFilterComposer(
              $db: $db,
              $table: $db.salaryPayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get salary => $composableBuilder(
      column: $table.salary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wageType => $composableBuilder(
      column: $table.wageType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get permissionsJson => $composableBuilder(
      column: $table.permissionsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<double> get salary =>
      $composableBuilder(column: $table.salary, builder: (column) => column);

  GeneratedColumn<String> get wageType =>
      $composableBuilder(column: $table.wageType, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get permissionsJson => $composableBuilder(
      column: $table.permissionsJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> ordersRefs<T extends Object>(
      Expression<T> Function($$OrdersTableAnnotationComposer a) f) {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.waiterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableAnnotationComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> attendanceRefs<T extends Object>(
      Expression<T> Function($$AttendanceTableAnnotationComposer a) f) {
    final $$AttendanceTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attendance,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttendanceTableAnnotationComposer(
              $db: $db,
              $table: $db.attendance,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> salaryPaymentsRefs<T extends Object>(
      Expression<T> Function($$SalaryPaymentsTableAnnotationComposer a) f) {
    final $$SalaryPaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.salaryPayments,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SalaryPaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.salaryPayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function(
        {bool ordersRefs, bool attendanceRefs, bool salaryPaymentsRefs})> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> passwordHash = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<double> salary = const Value.absent(),
            Value<String> wageType = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String> permissionsJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            name: name,
            email: email,
            passwordHash: passwordHash,
            role: role,
            phone: phone,
            photoPath: photoPath,
            salary: salary,
            wageType: wageType,
            isActive: isActive,
            permissionsJson: permissionsJson,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String email,
            required String passwordHash,
            required String role,
            Value<String?> phone = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<double> salary = const Value.absent(),
            Value<String> wageType = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String> permissionsJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            name: name,
            email: email,
            passwordHash: passwordHash,
            role: role,
            phone: phone,
            photoPath: photoPath,
            salary: salary,
            wageType: wageType,
            isActive: isActive,
            permissionsJson: permissionsJson,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {ordersRefs = false,
              attendanceRefs = false,
              salaryPaymentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (ordersRefs) db.orders,
                if (attendanceRefs) db.attendance,
                if (salaryPaymentsRefs) db.salaryPayments
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordersRefs)
                    await $_getPrefetchedData<User, $UsersTable, Order>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._ordersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).ordersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.waiterId == item.id),
                        typedResults: items),
                  if (attendanceRefs)
                    await $_getPrefetchedData<User, $UsersTable,
                            AttendanceData>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._attendanceRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .attendanceRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (salaryPaymentsRefs)
                    await $_getPrefetchedData<User, $UsersTable, SalaryPayment>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._salaryPaymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .salaryPaymentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function(
        {bool ordersRefs, bool attendanceRefs, bool salaryPaymentsRefs})>;
typedef $$FloorsTableCreateCompanionBuilder = FloorsCompanion Function({
  Value<int> id,
  required String name,
  Value<int> sortOrder,
});
typedef $$FloorsTableUpdateCompanionBuilder = FloorsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> sortOrder,
});

final class $$FloorsTableReferences
    extends BaseReferences<_$AppDatabase, $FloorsTable, Floor> {
  $$FloorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RestaurantTablesTable, List<RestaurantTable>>
      _restaurantTablesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.restaurantTables,
              aliasName: $_aliasNameGenerator(
                  db.floors.id, db.restaurantTables.floorId));

  $$RestaurantTablesTableProcessedTableManager get restaurantTablesRefs {
    final manager =
        $$RestaurantTablesTableTableManager($_db, $_db.restaurantTables)
            .filter((f) => f.floorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_restaurantTablesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FloorsTableFilterComposer
    extends Composer<_$AppDatabase, $FloorsTable> {
  $$FloorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  Expression<bool> restaurantTablesRefs(
      Expression<bool> Function($$RestaurantTablesTableFilterComposer f) f) {
    final $$RestaurantTablesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.restaurantTables,
        getReferencedColumn: (t) => t.floorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RestaurantTablesTableFilterComposer(
              $db: $db,
              $table: $db.restaurantTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FloorsTableOrderingComposer
    extends Composer<_$AppDatabase, $FloorsTable> {
  $$FloorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));
}

class $$FloorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FloorsTable> {
  $$FloorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> restaurantTablesRefs<T extends Object>(
      Expression<T> Function($$RestaurantTablesTableAnnotationComposer a) f) {
    final $$RestaurantTablesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.restaurantTables,
        getReferencedColumn: (t) => t.floorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RestaurantTablesTableAnnotationComposer(
              $db: $db,
              $table: $db.restaurantTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FloorsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FloorsTable,
    Floor,
    $$FloorsTableFilterComposer,
    $$FloorsTableOrderingComposer,
    $$FloorsTableAnnotationComposer,
    $$FloorsTableCreateCompanionBuilder,
    $$FloorsTableUpdateCompanionBuilder,
    (Floor, $$FloorsTableReferences),
    Floor,
    PrefetchHooks Function({bool restaurantTablesRefs})> {
  $$FloorsTableTableManager(_$AppDatabase db, $FloorsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FloorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FloorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FloorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              FloorsCompanion(
            id: id,
            name: name,
            sortOrder: sortOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<int> sortOrder = const Value.absent(),
          }) =>
              FloorsCompanion.insert(
            id: id,
            name: name,
            sortOrder: sortOrder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$FloorsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({restaurantTablesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (restaurantTablesRefs) db.restaurantTables
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (restaurantTablesRefs)
                    await $_getPrefetchedData<Floor, $FloorsTable,
                            RestaurantTable>(
                        currentTable: table,
                        referencedTable: $$FloorsTableReferences
                            ._restaurantTablesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FloorsTableReferences(db, table, p0)
                                .restaurantTablesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.floorId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FloorsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FloorsTable,
    Floor,
    $$FloorsTableFilterComposer,
    $$FloorsTableOrderingComposer,
    $$FloorsTableAnnotationComposer,
    $$FloorsTableCreateCompanionBuilder,
    $$FloorsTableUpdateCompanionBuilder,
    (Floor, $$FloorsTableReferences),
    Floor,
    PrefetchHooks Function({bool restaurantTablesRefs})>;
typedef $$RestaurantTablesTableCreateCompanionBuilder
    = RestaurantTablesCompanion Function({
  Value<int> id,
  required int floorId,
  required String name,
  Value<int> capacity,
  Value<String> shape,
  Value<double> posX,
  Value<double> posY,
  Value<double> width,
  Value<double> height,
  Value<String> status,
  Value<int?> activeOrderId,
  Value<String?> waiterName,
  Value<int> guestCount,
  Value<double> runningTotal,
  Value<DateTime?> orderStartTime,
});
typedef $$RestaurantTablesTableUpdateCompanionBuilder
    = RestaurantTablesCompanion Function({
  Value<int> id,
  Value<int> floorId,
  Value<String> name,
  Value<int> capacity,
  Value<String> shape,
  Value<double> posX,
  Value<double> posY,
  Value<double> width,
  Value<double> height,
  Value<String> status,
  Value<int?> activeOrderId,
  Value<String?> waiterName,
  Value<int> guestCount,
  Value<double> runningTotal,
  Value<DateTime?> orderStartTime,
});

final class $$RestaurantTablesTableReferences extends BaseReferences<
    _$AppDatabase, $RestaurantTablesTable, RestaurantTable> {
  $$RestaurantTablesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $FloorsTable _floorIdTable(_$AppDatabase db) => db.floors.createAlias(
      $_aliasNameGenerator(db.restaurantTables.floorId, db.floors.id));

  $$FloorsTableProcessedTableManager get floorId {
    final $_column = $_itemColumn<int>('floor_id')!;

    final manager = $$FloorsTableTableManager($_db, $_db.floors)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_floorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$OrdersTable, List<Order>> _ordersRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.orders,
          aliasName:
              $_aliasNameGenerator(db.restaurantTables.id, db.orders.tableId));

  $$OrdersTableProcessedTableManager get ordersRefs {
    final manager = $$OrdersTableTableManager($_db, $_db.orders)
        .filter((f) => f.tableId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RestaurantTablesTableFilterComposer
    extends Composer<_$AppDatabase, $RestaurantTablesTable> {
  $$RestaurantTablesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get capacity => $composableBuilder(
      column: $table.capacity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shape => $composableBuilder(
      column: $table.shape, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get posX => $composableBuilder(
      column: $table.posX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get posY => $composableBuilder(
      column: $table.posY, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get activeOrderId => $composableBuilder(
      column: $table.activeOrderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get waiterName => $composableBuilder(
      column: $table.waiterName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get guestCount => $composableBuilder(
      column: $table.guestCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get runningTotal => $composableBuilder(
      column: $table.runningTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get orderStartTime => $composableBuilder(
      column: $table.orderStartTime,
      builder: (column) => ColumnFilters(column));

  $$FloorsTableFilterComposer get floorId {
    final $$FloorsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.floorId,
        referencedTable: $db.floors,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FloorsTableFilterComposer(
              $db: $db,
              $table: $db.floors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> ordersRefs(
      Expression<bool> Function($$OrdersTableFilterComposer f) f) {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.tableId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableFilterComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RestaurantTablesTableOrderingComposer
    extends Composer<_$AppDatabase, $RestaurantTablesTable> {
  $$RestaurantTablesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get capacity => $composableBuilder(
      column: $table.capacity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shape => $composableBuilder(
      column: $table.shape, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get posX => $composableBuilder(
      column: $table.posX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get posY => $composableBuilder(
      column: $table.posY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get activeOrderId => $composableBuilder(
      column: $table.activeOrderId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get waiterName => $composableBuilder(
      column: $table.waiterName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get guestCount => $composableBuilder(
      column: $table.guestCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get runningTotal => $composableBuilder(
      column: $table.runningTotal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get orderStartTime => $composableBuilder(
      column: $table.orderStartTime,
      builder: (column) => ColumnOrderings(column));

  $$FloorsTableOrderingComposer get floorId {
    final $$FloorsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.floorId,
        referencedTable: $db.floors,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FloorsTableOrderingComposer(
              $db: $db,
              $table: $db.floors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RestaurantTablesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RestaurantTablesTable> {
  $$RestaurantTablesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get capacity =>
      $composableBuilder(column: $table.capacity, builder: (column) => column);

  GeneratedColumn<String> get shape =>
      $composableBuilder(column: $table.shape, builder: (column) => column);

  GeneratedColumn<double> get posX =>
      $composableBuilder(column: $table.posX, builder: (column) => column);

  GeneratedColumn<double> get posY =>
      $composableBuilder(column: $table.posY, builder: (column) => column);

  GeneratedColumn<double> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get activeOrderId => $composableBuilder(
      column: $table.activeOrderId, builder: (column) => column);

  GeneratedColumn<String> get waiterName => $composableBuilder(
      column: $table.waiterName, builder: (column) => column);

  GeneratedColumn<int> get guestCount => $composableBuilder(
      column: $table.guestCount, builder: (column) => column);

  GeneratedColumn<double> get runningTotal => $composableBuilder(
      column: $table.runningTotal, builder: (column) => column);

  GeneratedColumn<DateTime> get orderStartTime => $composableBuilder(
      column: $table.orderStartTime, builder: (column) => column);

  $$FloorsTableAnnotationComposer get floorId {
    final $$FloorsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.floorId,
        referencedTable: $db.floors,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FloorsTableAnnotationComposer(
              $db: $db,
              $table: $db.floors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> ordersRefs<T extends Object>(
      Expression<T> Function($$OrdersTableAnnotationComposer a) f) {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.tableId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableAnnotationComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RestaurantTablesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RestaurantTablesTable,
    RestaurantTable,
    $$RestaurantTablesTableFilterComposer,
    $$RestaurantTablesTableOrderingComposer,
    $$RestaurantTablesTableAnnotationComposer,
    $$RestaurantTablesTableCreateCompanionBuilder,
    $$RestaurantTablesTableUpdateCompanionBuilder,
    (RestaurantTable, $$RestaurantTablesTableReferences),
    RestaurantTable,
    PrefetchHooks Function({bool floorId, bool ordersRefs})> {
  $$RestaurantTablesTableTableManager(
      _$AppDatabase db, $RestaurantTablesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RestaurantTablesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RestaurantTablesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RestaurantTablesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> floorId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> capacity = const Value.absent(),
            Value<String> shape = const Value.absent(),
            Value<double> posX = const Value.absent(),
            Value<double> posY = const Value.absent(),
            Value<double> width = const Value.absent(),
            Value<double> height = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> activeOrderId = const Value.absent(),
            Value<String?> waiterName = const Value.absent(),
            Value<int> guestCount = const Value.absent(),
            Value<double> runningTotal = const Value.absent(),
            Value<DateTime?> orderStartTime = const Value.absent(),
          }) =>
              RestaurantTablesCompanion(
            id: id,
            floorId: floorId,
            name: name,
            capacity: capacity,
            shape: shape,
            posX: posX,
            posY: posY,
            width: width,
            height: height,
            status: status,
            activeOrderId: activeOrderId,
            waiterName: waiterName,
            guestCount: guestCount,
            runningTotal: runningTotal,
            orderStartTime: orderStartTime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int floorId,
            required String name,
            Value<int> capacity = const Value.absent(),
            Value<String> shape = const Value.absent(),
            Value<double> posX = const Value.absent(),
            Value<double> posY = const Value.absent(),
            Value<double> width = const Value.absent(),
            Value<double> height = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> activeOrderId = const Value.absent(),
            Value<String?> waiterName = const Value.absent(),
            Value<int> guestCount = const Value.absent(),
            Value<double> runningTotal = const Value.absent(),
            Value<DateTime?> orderStartTime = const Value.absent(),
          }) =>
              RestaurantTablesCompanion.insert(
            id: id,
            floorId: floorId,
            name: name,
            capacity: capacity,
            shape: shape,
            posX: posX,
            posY: posY,
            width: width,
            height: height,
            status: status,
            activeOrderId: activeOrderId,
            waiterName: waiterName,
            guestCount: guestCount,
            runningTotal: runningTotal,
            orderStartTime: orderStartTime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RestaurantTablesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({floorId = false, ordersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ordersRefs) db.orders],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (floorId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.floorId,
                    referencedTable:
                        $$RestaurantTablesTableReferences._floorIdTable(db),
                    referencedColumn:
                        $$RestaurantTablesTableReferences._floorIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordersRefs)
                    await $_getPrefetchedData<RestaurantTable,
                            $RestaurantTablesTable, Order>(
                        currentTable: table,
                        referencedTable: $$RestaurantTablesTableReferences
                            ._ordersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RestaurantTablesTableReferences(db, table, p0)
                                .ordersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.tableId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RestaurantTablesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RestaurantTablesTable,
    RestaurantTable,
    $$RestaurantTablesTableFilterComposer,
    $$RestaurantTablesTableOrderingComposer,
    $$RestaurantTablesTableAnnotationComposer,
    $$RestaurantTablesTableCreateCompanionBuilder,
    $$RestaurantTablesTableUpdateCompanionBuilder,
    (RestaurantTable, $$RestaurantTablesTableReferences),
    RestaurantTable,
    PrefetchHooks Function({bool floorId, bool ordersRefs})>;
typedef $$MenuGroupsTableCreateCompanionBuilder = MenuGroupsCompanion Function({
  Value<int> id,
  required String name,
  Value<String> iconPath,
  Value<String> colorHex,
  Value<int> sortOrder,
  Value<bool> isActive,
});
typedef $$MenuGroupsTableUpdateCompanionBuilder = MenuGroupsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> iconPath,
  Value<String> colorHex,
  Value<int> sortOrder,
  Value<bool> isActive,
});

final class $$MenuGroupsTableReferences
    extends BaseReferences<_$AppDatabase, $MenuGroupsTable, MenuGroup> {
  $$MenuGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MenuItemsTable, List<MenuItem>>
      _menuItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.menuItems,
              aliasName:
                  $_aliasNameGenerator(db.menuGroups.id, db.menuItems.groupId));

  $$MenuItemsTableProcessedTableManager get menuItemsRefs {
    final manager = $$MenuItemsTableTableManager($_db, $_db.menuItems)
        .filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_menuItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MenuGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $MenuGroupsTable> {
  $$MenuGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconPath => $composableBuilder(
      column: $table.iconPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  Expression<bool> menuItemsRefs(
      Expression<bool> Function($$MenuItemsTableFilterComposer f) f) {
    final $$MenuItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.menuItems,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuItemsTableFilterComposer(
              $db: $db,
              $table: $db.menuItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MenuGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuGroupsTable> {
  $$MenuGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconPath => $composableBuilder(
      column: $table.iconPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));
}

class $$MenuGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuGroupsTable> {
  $$MenuGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get iconPath =>
      $composableBuilder(column: $table.iconPath, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> menuItemsRefs<T extends Object>(
      Expression<T> Function($$MenuItemsTableAnnotationComposer a) f) {
    final $$MenuItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.menuItems,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.menuItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MenuGroupsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MenuGroupsTable,
    MenuGroup,
    $$MenuGroupsTableFilterComposer,
    $$MenuGroupsTableOrderingComposer,
    $$MenuGroupsTableAnnotationComposer,
    $$MenuGroupsTableCreateCompanionBuilder,
    $$MenuGroupsTableUpdateCompanionBuilder,
    (MenuGroup, $$MenuGroupsTableReferences),
    MenuGroup,
    PrefetchHooks Function({bool menuItemsRefs})> {
  $$MenuGroupsTableTableManager(_$AppDatabase db, $MenuGroupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenuGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> iconPath = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              MenuGroupsCompanion(
            id: id,
            name: name,
            iconPath: iconPath,
            colorHex: colorHex,
            sortOrder: sortOrder,
            isActive: isActive,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String> iconPath = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
          }) =>
              MenuGroupsCompanion.insert(
            id: id,
            name: name,
            iconPath: iconPath,
            colorHex: colorHex,
            sortOrder: sortOrder,
            isActive: isActive,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MenuGroupsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({menuItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (menuItemsRefs) db.menuItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (menuItemsRefs)
                    await $_getPrefetchedData<MenuGroup, $MenuGroupsTable,
                            MenuItem>(
                        currentTable: table,
                        referencedTable:
                            $$MenuGroupsTableReferences._menuItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MenuGroupsTableReferences(db, table, p0)
                                .menuItemsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.groupId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MenuGroupsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MenuGroupsTable,
    MenuGroup,
    $$MenuGroupsTableFilterComposer,
    $$MenuGroupsTableOrderingComposer,
    $$MenuGroupsTableAnnotationComposer,
    $$MenuGroupsTableCreateCompanionBuilder,
    $$MenuGroupsTableUpdateCompanionBuilder,
    (MenuGroup, $$MenuGroupsTableReferences),
    MenuGroup,
    PrefetchHooks Function({bool menuItemsRefs})>;
typedef $$MenuItemsTableCreateCompanionBuilder = MenuItemsCompanion Function({
  Value<int> id,
  required int groupId,
  required String name,
  required double price,
  Value<double> costPrice,
  Value<String?> description,
  Value<String?> imagePath,
  Value<int> preparationMinutes,
  Value<bool> isAvailable,
  Value<int> stockCount,
  Value<double> taxPercent,
  Value<int> sortOrder,
});
typedef $$MenuItemsTableUpdateCompanionBuilder = MenuItemsCompanion Function({
  Value<int> id,
  Value<int> groupId,
  Value<String> name,
  Value<double> price,
  Value<double> costPrice,
  Value<String?> description,
  Value<String?> imagePath,
  Value<int> preparationMinutes,
  Value<bool> isAvailable,
  Value<int> stockCount,
  Value<double> taxPercent,
  Value<int> sortOrder,
});

final class $$MenuItemsTableReferences
    extends BaseReferences<_$AppDatabase, $MenuItemsTable, MenuItem> {
  $$MenuItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MenuGroupsTable _groupIdTable(_$AppDatabase db) =>
      db.menuGroups.createAlias(
          $_aliasNameGenerator(db.menuItems.groupId, db.menuGroups.id));

  $$MenuGroupsTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$MenuGroupsTableTableManager($_db, $_db.menuGroups)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$OrderItemsTable, List<OrderItem>>
      _orderItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.orderItems,
          aliasName:
              $_aliasNameGenerator(db.menuItems.id, db.orderItems.menuItemId));

  $$OrderItemsTableProcessedTableManager get orderItemsRefs {
    final manager = $$OrderItemsTableTableManager($_db, $_db.orderItems)
        .filter((f) => f.menuItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DealItemsTable, List<DealItem>>
      _dealItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.dealItems,
          aliasName:
              $_aliasNameGenerator(db.menuItems.id, db.dealItems.menuItemId));

  $$DealItemsTableProcessedTableManager get dealItemsRefs {
    final manager = $$DealItemsTableTableManager($_db, $_db.dealItems)
        .filter((f) => f.menuItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dealItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MenuItemsTableFilterComposer
    extends Composer<_$AppDatabase, $MenuItemsTable> {
  $$MenuItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costPrice => $composableBuilder(
      column: $table.costPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get preparationMinutes => $composableBuilder(
      column: $table.preparationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isAvailable => $composableBuilder(
      column: $table.isAvailable, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stockCount => $composableBuilder(
      column: $table.stockCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get taxPercent => $composableBuilder(
      column: $table.taxPercent, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  $$MenuGroupsTableFilterComposer get groupId {
    final $$MenuGroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.menuGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuGroupsTableFilterComposer(
              $db: $db,
              $table: $db.menuGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> orderItemsRefs(
      Expression<bool> Function($$OrderItemsTableFilterComposer f) f) {
    final $$OrderItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderItems,
        getReferencedColumn: (t) => t.menuItemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrderItemsTableFilterComposer(
              $db: $db,
              $table: $db.orderItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> dealItemsRefs(
      Expression<bool> Function($$DealItemsTableFilterComposer f) f) {
    final $$DealItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dealItems,
        getReferencedColumn: (t) => t.menuItemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DealItemsTableFilterComposer(
              $db: $db,
              $table: $db.dealItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MenuItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $MenuItemsTable> {
  $$MenuItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costPrice => $composableBuilder(
      column: $table.costPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get preparationMinutes => $composableBuilder(
      column: $table.preparationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isAvailable => $composableBuilder(
      column: $table.isAvailable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stockCount => $composableBuilder(
      column: $table.stockCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get taxPercent => $composableBuilder(
      column: $table.taxPercent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  $$MenuGroupsTableOrderingComposer get groupId {
    final $$MenuGroupsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.menuGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuGroupsTableOrderingComposer(
              $db: $db,
              $table: $db.menuGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MenuItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenuItemsTable> {
  $$MenuItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get costPrice =>
      $composableBuilder(column: $table.costPrice, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<int> get preparationMinutes => $composableBuilder(
      column: $table.preparationMinutes, builder: (column) => column);

  GeneratedColumn<bool> get isAvailable => $composableBuilder(
      column: $table.isAvailable, builder: (column) => column);

  GeneratedColumn<int> get stockCount => $composableBuilder(
      column: $table.stockCount, builder: (column) => column);

  GeneratedColumn<double> get taxPercent => $composableBuilder(
      column: $table.taxPercent, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$MenuGroupsTableAnnotationComposer get groupId {
    final $$MenuGroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.menuGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuGroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.menuGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> orderItemsRefs<T extends Object>(
      Expression<T> Function($$OrderItemsTableAnnotationComposer a) f) {
    final $$OrderItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderItems,
        getReferencedColumn: (t) => t.menuItemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrderItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.orderItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> dealItemsRefs<T extends Object>(
      Expression<T> Function($$DealItemsTableAnnotationComposer a) f) {
    final $$DealItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dealItems,
        getReferencedColumn: (t) => t.menuItemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DealItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.dealItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MenuItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MenuItemsTable,
    MenuItem,
    $$MenuItemsTableFilterComposer,
    $$MenuItemsTableOrderingComposer,
    $$MenuItemsTableAnnotationComposer,
    $$MenuItemsTableCreateCompanionBuilder,
    $$MenuItemsTableUpdateCompanionBuilder,
    (MenuItem, $$MenuItemsTableReferences),
    MenuItem,
    PrefetchHooks Function(
        {bool groupId, bool orderItemsRefs, bool dealItemsRefs})> {
  $$MenuItemsTableTableManager(_$AppDatabase db, $MenuItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenuItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenuItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenuItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> groupId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<double> costPrice = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<int> preparationMinutes = const Value.absent(),
            Value<bool> isAvailable = const Value.absent(),
            Value<int> stockCount = const Value.absent(),
            Value<double> taxPercent = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              MenuItemsCompanion(
            id: id,
            groupId: groupId,
            name: name,
            price: price,
            costPrice: costPrice,
            description: description,
            imagePath: imagePath,
            preparationMinutes: preparationMinutes,
            isAvailable: isAvailable,
            stockCount: stockCount,
            taxPercent: taxPercent,
            sortOrder: sortOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int groupId,
            required String name,
            required double price,
            Value<double> costPrice = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<int> preparationMinutes = const Value.absent(),
            Value<bool> isAvailable = const Value.absent(),
            Value<int> stockCount = const Value.absent(),
            Value<double> taxPercent = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              MenuItemsCompanion.insert(
            id: id,
            groupId: groupId,
            name: name,
            price: price,
            costPrice: costPrice,
            description: description,
            imagePath: imagePath,
            preparationMinutes: preparationMinutes,
            isAvailable: isAvailable,
            stockCount: stockCount,
            taxPercent: taxPercent,
            sortOrder: sortOrder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MenuItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {groupId = false,
              orderItemsRefs = false,
              dealItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (orderItemsRefs) db.orderItems,
                if (dealItemsRefs) db.dealItems
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (groupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.groupId,
                    referencedTable:
                        $$MenuItemsTableReferences._groupIdTable(db),
                    referencedColumn:
                        $$MenuItemsTableReferences._groupIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (orderItemsRefs)
                    await $_getPrefetchedData<MenuItem, $MenuItemsTable,
                            OrderItem>(
                        currentTable: table,
                        referencedTable:
                            $$MenuItemsTableReferences._orderItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MenuItemsTableReferences(db, table, p0)
                                .orderItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.menuItemId == item.id),
                        typedResults: items),
                  if (dealItemsRefs)
                    await $_getPrefetchedData<MenuItem, $MenuItemsTable,
                            DealItem>(
                        currentTable: table,
                        referencedTable:
                            $$MenuItemsTableReferences._dealItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MenuItemsTableReferences(db, table, p0)
                                .dealItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.menuItemId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MenuItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MenuItemsTable,
    MenuItem,
    $$MenuItemsTableFilterComposer,
    $$MenuItemsTableOrderingComposer,
    $$MenuItemsTableAnnotationComposer,
    $$MenuItemsTableCreateCompanionBuilder,
    $$MenuItemsTableUpdateCompanionBuilder,
    (MenuItem, $$MenuItemsTableReferences),
    MenuItem,
    PrefetchHooks Function(
        {bool groupId, bool orderItemsRefs, bool dealItemsRefs})>;
typedef $$OrdersTableCreateCompanionBuilder = OrdersCompanion Function({
  Value<int> id,
  required String orderNumber,
  required int tableId,
  required String tableNameCol,
  required int waiterId,
  required String waiterName,
  Value<String> status,
  Value<double> discountPercent,
  Value<double> discountAmount,
  Value<double> taxPercent,
  Value<double> serviceChargePercent,
  Value<String> notes,
  Value<int> kitchenTicketCount,
  Value<int> guestCount,
  Value<DateTime> createdAt,
  Value<DateTime?> paidAt,
});
typedef $$OrdersTableUpdateCompanionBuilder = OrdersCompanion Function({
  Value<int> id,
  Value<String> orderNumber,
  Value<int> tableId,
  Value<String> tableNameCol,
  Value<int> waiterId,
  Value<String> waiterName,
  Value<String> status,
  Value<double> discountPercent,
  Value<double> discountAmount,
  Value<double> taxPercent,
  Value<double> serviceChargePercent,
  Value<String> notes,
  Value<int> kitchenTicketCount,
  Value<int> guestCount,
  Value<DateTime> createdAt,
  Value<DateTime?> paidAt,
});

final class $$OrdersTableReferences
    extends BaseReferences<_$AppDatabase, $OrdersTable, Order> {
  $$OrdersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RestaurantTablesTable _tableIdTable(_$AppDatabase db) =>
      db.restaurantTables.createAlias(
          $_aliasNameGenerator(db.orders.tableId, db.restaurantTables.id));

  $$RestaurantTablesTableProcessedTableManager get tableId {
    final $_column = $_itemColumn<int>('table_id')!;

    final manager =
        $$RestaurantTablesTableTableManager($_db, $_db.restaurantTables)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tableIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _waiterIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.orders.waiterId, db.users.id));

  $$UsersTableProcessedTableManager get waiterId {
    final $_column = $_itemColumn<int>('waiter_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_waiterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$OrderItemsTable, List<OrderItem>>
      _orderItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.orderItems,
          aliasName: $_aliasNameGenerator(db.orders.id, db.orderItems.orderId));

  $$OrderItemsTableProcessedTableManager get orderItemsRefs {
    final manager = $$OrderItemsTableTableManager($_db, $_db.orderItems)
        .filter((f) => f.orderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.invoices,
          aliasName: $_aliasNameGenerator(db.orders.id, db.invoices.orderId));

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager($_db, $_db.invoices)
        .filter((f) => f.orderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$OrdersTableFilterComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tableNameCol => $composableBuilder(
      column: $table.tableNameCol, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get waiterName => $composableBuilder(
      column: $table.waiterName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discountPercent => $composableBuilder(
      column: $table.discountPercent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discountAmount => $composableBuilder(
      column: $table.discountAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get taxPercent => $composableBuilder(
      column: $table.taxPercent, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get serviceChargePercent => $composableBuilder(
      column: $table.serviceChargePercent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get kitchenTicketCount => $composableBuilder(
      column: $table.kitchenTicketCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get guestCount => $composableBuilder(
      column: $table.guestCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
      column: $table.paidAt, builder: (column) => ColumnFilters(column));

  $$RestaurantTablesTableFilterComposer get tableId {
    final $$RestaurantTablesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tableId,
        referencedTable: $db.restaurantTables,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RestaurantTablesTableFilterComposer(
              $db: $db,
              $table: $db.restaurantTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get waiterId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.waiterId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> orderItemsRefs(
      Expression<bool> Function($$OrderItemsTableFilterComposer f) f) {
    final $$OrderItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderItems,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrderItemsTableFilterComposer(
              $db: $db,
              $table: $db.orderItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> invoicesRefs(
      Expression<bool> Function($$InvoicesTableFilterComposer f) f) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.invoices,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoicesTableFilterComposer(
              $db: $db,
              $table: $db.invoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tableNameCol => $composableBuilder(
      column: $table.tableNameCol,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get waiterName => $composableBuilder(
      column: $table.waiterName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discountPercent => $composableBuilder(
      column: $table.discountPercent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discountAmount => $composableBuilder(
      column: $table.discountAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get taxPercent => $composableBuilder(
      column: $table.taxPercent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get serviceChargePercent => $composableBuilder(
      column: $table.serviceChargePercent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get kitchenTicketCount => $composableBuilder(
      column: $table.kitchenTicketCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get guestCount => $composableBuilder(
      column: $table.guestCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
      column: $table.paidAt, builder: (column) => ColumnOrderings(column));

  $$RestaurantTablesTableOrderingComposer get tableId {
    final $$RestaurantTablesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tableId,
        referencedTable: $db.restaurantTables,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RestaurantTablesTableOrderingComposer(
              $db: $db,
              $table: $db.restaurantTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get waiterId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.waiterId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => column);

  GeneratedColumn<String> get tableNameCol => $composableBuilder(
      column: $table.tableNameCol, builder: (column) => column);

  GeneratedColumn<String> get waiterName => $composableBuilder(
      column: $table.waiterName, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get discountPercent => $composableBuilder(
      column: $table.discountPercent, builder: (column) => column);

  GeneratedColumn<double> get discountAmount => $composableBuilder(
      column: $table.discountAmount, builder: (column) => column);

  GeneratedColumn<double> get taxPercent => $composableBuilder(
      column: $table.taxPercent, builder: (column) => column);

  GeneratedColumn<double> get serviceChargePercent => $composableBuilder(
      column: $table.serviceChargePercent, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get kitchenTicketCount => $composableBuilder(
      column: $table.kitchenTicketCount, builder: (column) => column);

  GeneratedColumn<int> get guestCount => $composableBuilder(
      column: $table.guestCount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  $$RestaurantTablesTableAnnotationComposer get tableId {
    final $$RestaurantTablesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tableId,
        referencedTable: $db.restaurantTables,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RestaurantTablesTableAnnotationComposer(
              $db: $db,
              $table: $db.restaurantTables,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get waiterId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.waiterId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> orderItemsRefs<T extends Object>(
      Expression<T> Function($$OrderItemsTableAnnotationComposer a) f) {
    final $$OrderItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderItems,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrderItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.orderItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
      Expression<T> Function($$InvoicesTableAnnotationComposer a) f) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.invoices,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoicesTableAnnotationComposer(
              $db: $db,
              $table: $db.invoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrdersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdersTable,
    Order,
    $$OrdersTableFilterComposer,
    $$OrdersTableOrderingComposer,
    $$OrdersTableAnnotationComposer,
    $$OrdersTableCreateCompanionBuilder,
    $$OrdersTableUpdateCompanionBuilder,
    (Order, $$OrdersTableReferences),
    Order,
    PrefetchHooks Function(
        {bool tableId,
        bool waiterId,
        bool orderItemsRefs,
        bool invoicesRefs})> {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> orderNumber = const Value.absent(),
            Value<int> tableId = const Value.absent(),
            Value<String> tableNameCol = const Value.absent(),
            Value<int> waiterId = const Value.absent(),
            Value<String> waiterName = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<double> discountPercent = const Value.absent(),
            Value<double> discountAmount = const Value.absent(),
            Value<double> taxPercent = const Value.absent(),
            Value<double> serviceChargePercent = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<int> kitchenTicketCount = const Value.absent(),
            Value<int> guestCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> paidAt = const Value.absent(),
          }) =>
              OrdersCompanion(
            id: id,
            orderNumber: orderNumber,
            tableId: tableId,
            tableNameCol: tableNameCol,
            waiterId: waiterId,
            waiterName: waiterName,
            status: status,
            discountPercent: discountPercent,
            discountAmount: discountAmount,
            taxPercent: taxPercent,
            serviceChargePercent: serviceChargePercent,
            notes: notes,
            kitchenTicketCount: kitchenTicketCount,
            guestCount: guestCount,
            createdAt: createdAt,
            paidAt: paidAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String orderNumber,
            required int tableId,
            required String tableNameCol,
            required int waiterId,
            required String waiterName,
            Value<String> status = const Value.absent(),
            Value<double> discountPercent = const Value.absent(),
            Value<double> discountAmount = const Value.absent(),
            Value<double> taxPercent = const Value.absent(),
            Value<double> serviceChargePercent = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<int> kitchenTicketCount = const Value.absent(),
            Value<int> guestCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> paidAt = const Value.absent(),
          }) =>
              OrdersCompanion.insert(
            id: id,
            orderNumber: orderNumber,
            tableId: tableId,
            tableNameCol: tableNameCol,
            waiterId: waiterId,
            waiterName: waiterName,
            status: status,
            discountPercent: discountPercent,
            discountAmount: discountAmount,
            taxPercent: taxPercent,
            serviceChargePercent: serviceChargePercent,
            notes: notes,
            kitchenTicketCount: kitchenTicketCount,
            guestCount: guestCount,
            createdAt: createdAt,
            paidAt: paidAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$OrdersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {tableId = false,
              waiterId = false,
              orderItemsRefs = false,
              invoicesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (orderItemsRefs) db.orderItems,
                if (invoicesRefs) db.invoices
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (tableId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tableId,
                    referencedTable: $$OrdersTableReferences._tableIdTable(db),
                    referencedColumn:
                        $$OrdersTableReferences._tableIdTable(db).id,
                  ) as T;
                }
                if (waiterId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.waiterId,
                    referencedTable: $$OrdersTableReferences._waiterIdTable(db),
                    referencedColumn:
                        $$OrdersTableReferences._waiterIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (orderItemsRefs)
                    await $_getPrefetchedData<Order, $OrdersTable, OrderItem>(
                        currentTable: table,
                        referencedTable:
                            $$OrdersTableReferences._orderItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$OrdersTableReferences(db, table, p0)
                                .orderItemsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.orderId == item.id),
                        typedResults: items),
                  if (invoicesRefs)
                    await $_getPrefetchedData<Order, $OrdersTable, Invoice>(
                        currentTable: table,
                        referencedTable:
                            $$OrdersTableReferences._invoicesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$OrdersTableReferences(db, table, p0).invoicesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.orderId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$OrdersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrdersTable,
    Order,
    $$OrdersTableFilterComposer,
    $$OrdersTableOrderingComposer,
    $$OrdersTableAnnotationComposer,
    $$OrdersTableCreateCompanionBuilder,
    $$OrdersTableUpdateCompanionBuilder,
    (Order, $$OrdersTableReferences),
    Order,
    PrefetchHooks Function(
        {bool tableId, bool waiterId, bool orderItemsRefs, bool invoicesRefs})>;
typedef $$DealsTableCreateCompanionBuilder = DealsCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> code,
  required double price,
  Value<String?> description,
  Value<bool> isActive,
  Value<String?> imagePath,
  Value<DateTime> createdAt,
});
typedef $$DealsTableUpdateCompanionBuilder = DealsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> code,
  Value<double> price,
  Value<String?> description,
  Value<bool> isActive,
  Value<String?> imagePath,
  Value<DateTime> createdAt,
});

final class $$DealsTableReferences
    extends BaseReferences<_$AppDatabase, $DealsTable, Deal> {
  $$DealsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrderItemsTable, List<OrderItem>>
      _orderItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.orderItems,
          aliasName: $_aliasNameGenerator(db.deals.id, db.orderItems.dealId));

  $$OrderItemsTableProcessedTableManager get orderItemsRefs {
    final manager = $$OrderItemsTableTableManager($_db, $_db.orderItems)
        .filter((f) => f.dealId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DealItemsTable, List<DealItem>>
      _dealItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.dealItems,
          aliasName: $_aliasNameGenerator(db.deals.id, db.dealItems.dealId));

  $$DealItemsTableProcessedTableManager get dealItemsRefs {
    final manager = $$DealItemsTableTableManager($_db, $_db.dealItems)
        .filter((f) => f.dealId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dealItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DealsTableFilterComposer extends Composer<_$AppDatabase, $DealsTable> {
  $$DealsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> orderItemsRefs(
      Expression<bool> Function($$OrderItemsTableFilterComposer f) f) {
    final $$OrderItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderItems,
        getReferencedColumn: (t) => t.dealId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrderItemsTableFilterComposer(
              $db: $db,
              $table: $db.orderItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> dealItemsRefs(
      Expression<bool> Function($$DealItemsTableFilterComposer f) f) {
    final $$DealItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dealItems,
        getReferencedColumn: (t) => t.dealId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DealItemsTableFilterComposer(
              $db: $db,
              $table: $db.dealItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DealsTableOrderingComposer
    extends Composer<_$AppDatabase, $DealsTable> {
  $$DealsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DealsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DealsTable> {
  $$DealsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> orderItemsRefs<T extends Object>(
      Expression<T> Function($$OrderItemsTableAnnotationComposer a) f) {
    final $$OrderItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.orderItems,
        getReferencedColumn: (t) => t.dealId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrderItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.orderItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> dealItemsRefs<T extends Object>(
      Expression<T> Function($$DealItemsTableAnnotationComposer a) f) {
    final $$DealItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dealItems,
        getReferencedColumn: (t) => t.dealId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DealItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.dealItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DealsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DealsTable,
    Deal,
    $$DealsTableFilterComposer,
    $$DealsTableOrderingComposer,
    $$DealsTableAnnotationComposer,
    $$DealsTableCreateCompanionBuilder,
    $$DealsTableUpdateCompanionBuilder,
    (Deal, $$DealsTableReferences),
    Deal,
    PrefetchHooks Function({bool orderItemsRefs, bool dealItemsRefs})> {
  $$DealsTableTableManager(_$AppDatabase db, $DealsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DealsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DealsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DealsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DealsCompanion(
            id: id,
            name: name,
            code: code,
            price: price,
            description: description,
            isActive: isActive,
            imagePath: imagePath,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> code = const Value.absent(),
            required double price,
            Value<String?> description = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DealsCompanion.insert(
            id: id,
            name: name,
            code: code,
            price: price,
            description: description,
            isActive: isActive,
            imagePath: imagePath,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DealsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {orderItemsRefs = false, dealItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (orderItemsRefs) db.orderItems,
                if (dealItemsRefs) db.dealItems
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (orderItemsRefs)
                    await $_getPrefetchedData<Deal, $DealsTable, OrderItem>(
                        currentTable: table,
                        referencedTable:
                            $$DealsTableReferences._orderItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DealsTableReferences(db, table, p0)
                                .orderItemsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.dealId == item.id),
                        typedResults: items),
                  if (dealItemsRefs)
                    await $_getPrefetchedData<Deal, $DealsTable, DealItem>(
                        currentTable: table,
                        referencedTable:
                            $$DealsTableReferences._dealItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DealsTableReferences(db, table, p0).dealItemsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.dealId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DealsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DealsTable,
    Deal,
    $$DealsTableFilterComposer,
    $$DealsTableOrderingComposer,
    $$DealsTableAnnotationComposer,
    $$DealsTableCreateCompanionBuilder,
    $$DealsTableUpdateCompanionBuilder,
    (Deal, $$DealsTableReferences),
    Deal,
    PrefetchHooks Function({bool orderItemsRefs, bool dealItemsRefs})>;
typedef $$OrderItemsTableCreateCompanionBuilder = OrderItemsCompanion Function({
  Value<int> id,
  required int orderId,
  required int menuItemId,
  required String menuItemName,
  required double unitPrice,
  required int quantity,
  Value<String> notes,
  Value<String> status,
  Value<String> modifiersJson,
  Value<bool> isVoided,
  Value<DateTime?> sentToKitchenAt,
  Value<int?> dealId,
  Value<String?> dealItemsJson,
});
typedef $$OrderItemsTableUpdateCompanionBuilder = OrderItemsCompanion Function({
  Value<int> id,
  Value<int> orderId,
  Value<int> menuItemId,
  Value<String> menuItemName,
  Value<double> unitPrice,
  Value<int> quantity,
  Value<String> notes,
  Value<String> status,
  Value<String> modifiersJson,
  Value<bool> isVoided,
  Value<DateTime?> sentToKitchenAt,
  Value<int?> dealId,
  Value<String?> dealItemsJson,
});

final class $$OrderItemsTableReferences
    extends BaseReferences<_$AppDatabase, $OrderItemsTable, OrderItem> {
  $$OrderItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdersTable _orderIdTable(_$AppDatabase db) => db.orders
      .createAlias($_aliasNameGenerator(db.orderItems.orderId, db.orders.id));

  $$OrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<int>('order_id')!;

    final manager = $$OrdersTableTableManager($_db, $_db.orders)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MenuItemsTable _menuItemIdTable(_$AppDatabase db) =>
      db.menuItems.createAlias(
          $_aliasNameGenerator(db.orderItems.menuItemId, db.menuItems.id));

  $$MenuItemsTableProcessedTableManager get menuItemId {
    final $_column = $_itemColumn<int>('menu_item_id')!;

    final manager = $$MenuItemsTableTableManager($_db, $_db.menuItems)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_menuItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $DealsTable _dealIdTable(_$AppDatabase db) => db.deals
      .createAlias($_aliasNameGenerator(db.orderItems.dealId, db.deals.id));

  $$DealsTableProcessedTableManager? get dealId {
    final $_column = $_itemColumn<int>('deal_id');
    if ($_column == null) return null;
    final manager = $$DealsTableTableManager($_db, $_db.deals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dealIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$OrderItemsTableFilterComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get menuItemName => $composableBuilder(
      column: $table.menuItemName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get unitPrice => $composableBuilder(
      column: $table.unitPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get modifiersJson => $composableBuilder(
      column: $table.modifiersJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isVoided => $composableBuilder(
      column: $table.isVoided, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get sentToKitchenAt => $composableBuilder(
      column: $table.sentToKitchenAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dealItemsJson => $composableBuilder(
      column: $table.dealItemsJson, builder: (column) => ColumnFilters(column));

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableFilterComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MenuItemsTableFilterComposer get menuItemId {
    final $$MenuItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.menuItemId,
        referencedTable: $db.menuItems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuItemsTableFilterComposer(
              $db: $db,
              $table: $db.menuItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DealsTableFilterComposer get dealId {
    final $$DealsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dealId,
        referencedTable: $db.deals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DealsTableFilterComposer(
              $db: $db,
              $table: $db.deals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OrderItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get menuItemName => $composableBuilder(
      column: $table.menuItemName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get unitPrice => $composableBuilder(
      column: $table.unitPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get modifiersJson => $composableBuilder(
      column: $table.modifiersJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isVoided => $composableBuilder(
      column: $table.isVoided, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get sentToKitchenAt => $composableBuilder(
      column: $table.sentToKitchenAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dealItemsJson => $composableBuilder(
      column: $table.dealItemsJson,
      builder: (column) => ColumnOrderings(column));

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableOrderingComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MenuItemsTableOrderingComposer get menuItemId {
    final $$MenuItemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.menuItemId,
        referencedTable: $db.menuItems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuItemsTableOrderingComposer(
              $db: $db,
              $table: $db.menuItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DealsTableOrderingComposer get dealId {
    final $$DealsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dealId,
        referencedTable: $db.deals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DealsTableOrderingComposer(
              $db: $db,
              $table: $db.deals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OrderItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get menuItemName => $composableBuilder(
      column: $table.menuItemName, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get modifiersJson => $composableBuilder(
      column: $table.modifiersJson, builder: (column) => column);

  GeneratedColumn<bool> get isVoided =>
      $composableBuilder(column: $table.isVoided, builder: (column) => column);

  GeneratedColumn<DateTime> get sentToKitchenAt => $composableBuilder(
      column: $table.sentToKitchenAt, builder: (column) => column);

  GeneratedColumn<String> get dealItemsJson => $composableBuilder(
      column: $table.dealItemsJson, builder: (column) => column);

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableAnnotationComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MenuItemsTableAnnotationComposer get menuItemId {
    final $$MenuItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.menuItemId,
        referencedTable: $db.menuItems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.menuItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$DealsTableAnnotationComposer get dealId {
    final $$DealsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dealId,
        referencedTable: $db.deals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DealsTableAnnotationComposer(
              $db: $db,
              $table: $db.deals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OrderItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrderItemsTable,
    OrderItem,
    $$OrderItemsTableFilterComposer,
    $$OrderItemsTableOrderingComposer,
    $$OrderItemsTableAnnotationComposer,
    $$OrderItemsTableCreateCompanionBuilder,
    $$OrderItemsTableUpdateCompanionBuilder,
    (OrderItem, $$OrderItemsTableReferences),
    OrderItem,
    PrefetchHooks Function({bool orderId, bool menuItemId, bool dealId})> {
  $$OrderItemsTableTableManager(_$AppDatabase db, $OrderItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> orderId = const Value.absent(),
            Value<int> menuItemId = const Value.absent(),
            Value<String> menuItemName = const Value.absent(),
            Value<double> unitPrice = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> modifiersJson = const Value.absent(),
            Value<bool> isVoided = const Value.absent(),
            Value<DateTime?> sentToKitchenAt = const Value.absent(),
            Value<int?> dealId = const Value.absent(),
            Value<String?> dealItemsJson = const Value.absent(),
          }) =>
              OrderItemsCompanion(
            id: id,
            orderId: orderId,
            menuItemId: menuItemId,
            menuItemName: menuItemName,
            unitPrice: unitPrice,
            quantity: quantity,
            notes: notes,
            status: status,
            modifiersJson: modifiersJson,
            isVoided: isVoided,
            sentToKitchenAt: sentToKitchenAt,
            dealId: dealId,
            dealItemsJson: dealItemsJson,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int orderId,
            required int menuItemId,
            required String menuItemName,
            required double unitPrice,
            required int quantity,
            Value<String> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> modifiersJson = const Value.absent(),
            Value<bool> isVoided = const Value.absent(),
            Value<DateTime?> sentToKitchenAt = const Value.absent(),
            Value<int?> dealId = const Value.absent(),
            Value<String?> dealItemsJson = const Value.absent(),
          }) =>
              OrderItemsCompanion.insert(
            id: id,
            orderId: orderId,
            menuItemId: menuItemId,
            menuItemName: menuItemName,
            unitPrice: unitPrice,
            quantity: quantity,
            notes: notes,
            status: status,
            modifiersJson: modifiersJson,
            isVoided: isVoided,
            sentToKitchenAt: sentToKitchenAt,
            dealId: dealId,
            dealItemsJson: dealItemsJson,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$OrderItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {orderId = false, menuItemId = false, dealId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (orderId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.orderId,
                    referencedTable:
                        $$OrderItemsTableReferences._orderIdTable(db),
                    referencedColumn:
                        $$OrderItemsTableReferences._orderIdTable(db).id,
                  ) as T;
                }
                if (menuItemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.menuItemId,
                    referencedTable:
                        $$OrderItemsTableReferences._menuItemIdTable(db),
                    referencedColumn:
                        $$OrderItemsTableReferences._menuItemIdTable(db).id,
                  ) as T;
                }
                if (dealId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dealId,
                    referencedTable:
                        $$OrderItemsTableReferences._dealIdTable(db),
                    referencedColumn:
                        $$OrderItemsTableReferences._dealIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$OrderItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrderItemsTable,
    OrderItem,
    $$OrderItemsTableFilterComposer,
    $$OrderItemsTableOrderingComposer,
    $$OrderItemsTableAnnotationComposer,
    $$OrderItemsTableCreateCompanionBuilder,
    $$OrderItemsTableUpdateCompanionBuilder,
    (OrderItem, $$OrderItemsTableReferences),
    OrderItem,
    PrefetchHooks Function({bool orderId, bool menuItemId, bool dealId})>;
typedef $$InvoicesTableCreateCompanionBuilder = InvoicesCompanion Function({
  Value<int> id,
  required String invoiceNumber,
  required int orderId,
  required String orderNumber,
  required String tableNameCol,
  required String waiterName,
  required double subtotal,
  Value<double> discountValue,
  Value<double> taxValue,
  Value<double> serviceChargeValue,
  required double grandTotal,
  required double amountPaid,
  Value<double> changeAmount,
  Value<String> paymentMethod,
  Value<String> paymentSplitsJson,
  Value<String> status,
  Value<int?> customerId,
  Value<bool> isVoided,
  Value<DateTime> createdAt,
});
typedef $$InvoicesTableUpdateCompanionBuilder = InvoicesCompanion Function({
  Value<int> id,
  Value<String> invoiceNumber,
  Value<int> orderId,
  Value<String> orderNumber,
  Value<String> tableNameCol,
  Value<String> waiterName,
  Value<double> subtotal,
  Value<double> discountValue,
  Value<double> taxValue,
  Value<double> serviceChargeValue,
  Value<double> grandTotal,
  Value<double> amountPaid,
  Value<double> changeAmount,
  Value<String> paymentMethod,
  Value<String> paymentSplitsJson,
  Value<String> status,
  Value<int?> customerId,
  Value<bool> isVoided,
  Value<DateTime> createdAt,
});

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdersTable _orderIdTable(_$AppDatabase db) => db.orders
      .createAlias($_aliasNameGenerator(db.invoices.orderId, db.orders.id));

  $$OrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<int>('order_id')!;

    final manager = $$OrdersTableTableManager($_db, $_db.orders)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tableNameCol => $composableBuilder(
      column: $table.tableNameCol, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get waiterName => $composableBuilder(
      column: $table.waiterName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discountValue => $composableBuilder(
      column: $table.discountValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get taxValue => $composableBuilder(
      column: $table.taxValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get serviceChargeValue => $composableBuilder(
      column: $table.serviceChargeValue,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get grandTotal => $composableBuilder(
      column: $table.grandTotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amountPaid => $composableBuilder(
      column: $table.amountPaid, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get changeAmount => $composableBuilder(
      column: $table.changeAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentSplitsJson => $composableBuilder(
      column: $table.paymentSplitsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isVoided => $composableBuilder(
      column: $table.isVoided, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableFilterComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tableNameCol => $composableBuilder(
      column: $table.tableNameCol,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get waiterName => $composableBuilder(
      column: $table.waiterName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discountValue => $composableBuilder(
      column: $table.discountValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get taxValue => $composableBuilder(
      column: $table.taxValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get serviceChargeValue => $composableBuilder(
      column: $table.serviceChargeValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get grandTotal => $composableBuilder(
      column: $table.grandTotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amountPaid => $composableBuilder(
      column: $table.amountPaid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get changeAmount => $composableBuilder(
      column: $table.changeAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentSplitsJson => $composableBuilder(
      column: $table.paymentSplitsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isVoided => $composableBuilder(
      column: $table.isVoided, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableOrderingComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
      column: $table.invoiceNumber, builder: (column) => column);

  GeneratedColumn<String> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => column);

  GeneratedColumn<String> get tableNameCol => $composableBuilder(
      column: $table.tableNameCol, builder: (column) => column);

  GeneratedColumn<String> get waiterName => $composableBuilder(
      column: $table.waiterName, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get discountValue => $composableBuilder(
      column: $table.discountValue, builder: (column) => column);

  GeneratedColumn<double> get taxValue =>
      $composableBuilder(column: $table.taxValue, builder: (column) => column);

  GeneratedColumn<double> get serviceChargeValue => $composableBuilder(
      column: $table.serviceChargeValue, builder: (column) => column);

  GeneratedColumn<double> get grandTotal => $composableBuilder(
      column: $table.grandTotal, builder: (column) => column);

  GeneratedColumn<double> get amountPaid => $composableBuilder(
      column: $table.amountPaid, builder: (column) => column);

  GeneratedColumn<double> get changeAmount => $composableBuilder(
      column: $table.changeAmount, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<String> get paymentSplitsJson => $composableBuilder(
      column: $table.paymentSplitsJson, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(
      column: $table.customerId, builder: (column) => column);

  GeneratedColumn<bool> get isVoided =>
      $composableBuilder(column: $table.isVoided, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.orders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdersTableAnnotationComposer(
              $db: $db,
              $table: $db.orders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoicesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InvoicesTable,
    Invoice,
    $$InvoicesTableFilterComposer,
    $$InvoicesTableOrderingComposer,
    $$InvoicesTableAnnotationComposer,
    $$InvoicesTableCreateCompanionBuilder,
    $$InvoicesTableUpdateCompanionBuilder,
    (Invoice, $$InvoicesTableReferences),
    Invoice,
    PrefetchHooks Function({bool orderId})> {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> invoiceNumber = const Value.absent(),
            Value<int> orderId = const Value.absent(),
            Value<String> orderNumber = const Value.absent(),
            Value<String> tableNameCol = const Value.absent(),
            Value<String> waiterName = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> discountValue = const Value.absent(),
            Value<double> taxValue = const Value.absent(),
            Value<double> serviceChargeValue = const Value.absent(),
            Value<double> grandTotal = const Value.absent(),
            Value<double> amountPaid = const Value.absent(),
            Value<double> changeAmount = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<String> paymentSplitsJson = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> customerId = const Value.absent(),
            Value<bool> isVoided = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              InvoicesCompanion(
            id: id,
            invoiceNumber: invoiceNumber,
            orderId: orderId,
            orderNumber: orderNumber,
            tableNameCol: tableNameCol,
            waiterName: waiterName,
            subtotal: subtotal,
            discountValue: discountValue,
            taxValue: taxValue,
            serviceChargeValue: serviceChargeValue,
            grandTotal: grandTotal,
            amountPaid: amountPaid,
            changeAmount: changeAmount,
            paymentMethod: paymentMethod,
            paymentSplitsJson: paymentSplitsJson,
            status: status,
            customerId: customerId,
            isVoided: isVoided,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String invoiceNumber,
            required int orderId,
            required String orderNumber,
            required String tableNameCol,
            required String waiterName,
            required double subtotal,
            Value<double> discountValue = const Value.absent(),
            Value<double> taxValue = const Value.absent(),
            Value<double> serviceChargeValue = const Value.absent(),
            required double grandTotal,
            required double amountPaid,
            Value<double> changeAmount = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<String> paymentSplitsJson = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> customerId = const Value.absent(),
            Value<bool> isVoided = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              InvoicesCompanion.insert(
            id: id,
            invoiceNumber: invoiceNumber,
            orderId: orderId,
            orderNumber: orderNumber,
            tableNameCol: tableNameCol,
            waiterName: waiterName,
            subtotal: subtotal,
            discountValue: discountValue,
            taxValue: taxValue,
            serviceChargeValue: serviceChargeValue,
            grandTotal: grandTotal,
            amountPaid: amountPaid,
            changeAmount: changeAmount,
            paymentMethod: paymentMethod,
            paymentSplitsJson: paymentSplitsJson,
            status: status,
            customerId: customerId,
            isVoided: isVoided,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$InvoicesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({orderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (orderId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.orderId,
                    referencedTable:
                        $$InvoicesTableReferences._orderIdTable(db),
                    referencedColumn:
                        $$InvoicesTableReferences._orderIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$InvoicesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InvoicesTable,
    Invoice,
    $$InvoicesTableFilterComposer,
    $$InvoicesTableOrderingComposer,
    $$InvoicesTableAnnotationComposer,
    $$InvoicesTableCreateCompanionBuilder,
    $$InvoicesTableUpdateCompanionBuilder,
    (Invoice, $$InvoicesTableReferences),
    Invoice,
    PrefetchHooks Function({bool orderId})>;
typedef $$CustomersTableCreateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  required String name,
  required String phone,
  Value<String?> address,
  Value<double> creditLimit,
  Value<double> balance,
  Value<int> loyaltyPoints,
  Value<DateTime> createdAt,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> phone,
  Value<String?> address,
  Value<double> creditLimit,
  Value<double> balance,
  Value<int> loyaltyPoints,
  Value<DateTime> createdAt,
});

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CreditLedgerTable, List<CreditLedgerData>>
      _creditLedgerRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.creditLedger,
              aliasName: $_aliasNameGenerator(
                  db.customers.id, db.creditLedger.customerId));

  $$CreditLedgerTableProcessedTableManager get creditLedgerRefs {
    final manager = $$CreditLedgerTableTableManager($_db, $_db.creditLedger)
        .filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_creditLedgerRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get creditLimit => $composableBuilder(
      column: $table.creditLimit, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get balance => $composableBuilder(
      column: $table.balance, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get loyaltyPoints => $composableBuilder(
      column: $table.loyaltyPoints, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> creditLedgerRefs(
      Expression<bool> Function($$CreditLedgerTableFilterComposer f) f) {
    final $$CreditLedgerTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.creditLedger,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CreditLedgerTableFilterComposer(
              $db: $db,
              $table: $db.creditLedger,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get creditLimit => $composableBuilder(
      column: $table.creditLimit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get balance => $composableBuilder(
      column: $table.balance, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get loyaltyPoints => $composableBuilder(
      column: $table.loyaltyPoints,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get creditLimit => $composableBuilder(
      column: $table.creditLimit, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<int> get loyaltyPoints => $composableBuilder(
      column: $table.loyaltyPoints, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> creditLedgerRefs<T extends Object>(
      Expression<T> Function($$CreditLedgerTableAnnotationComposer a) f) {
    final $$CreditLedgerTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.creditLedger,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CreditLedgerTableAnnotationComposer(
              $db: $db,
              $table: $db.creditLedger,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CustomersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableAnnotationComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder,
    (Customer, $$CustomersTableReferences),
    Customer,
    PrefetchHooks Function({bool creditLedgerRefs})> {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<double> creditLimit = const Value.absent(),
            Value<double> balance = const Value.absent(),
            Value<int> loyaltyPoints = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CustomersCompanion(
            id: id,
            name: name,
            phone: phone,
            address: address,
            creditLimit: creditLimit,
            balance: balance,
            loyaltyPoints: loyaltyPoints,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String phone,
            Value<String?> address = const Value.absent(),
            Value<double> creditLimit = const Value.absent(),
            Value<double> balance = const Value.absent(),
            Value<int> loyaltyPoints = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CustomersCompanion.insert(
            id: id,
            name: name,
            phone: phone,
            address: address,
            creditLimit: creditLimit,
            balance: balance,
            loyaltyPoints: loyaltyPoints,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CustomersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({creditLedgerRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (creditLedgerRefs) db.creditLedger],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (creditLedgerRefs)
                    await $_getPrefetchedData<Customer, $CustomersTable,
                            CreditLedgerData>(
                        currentTable: table,
                        referencedTable: $$CustomersTableReferences
                            ._creditLedgerRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CustomersTableReferences(db, table, p0)
                                .creditLedgerRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.customerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CustomersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableAnnotationComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder,
    (Customer, $$CustomersTableReferences),
    Customer,
    PrefetchHooks Function({bool creditLedgerRefs})>;
typedef $$CreditLedgerTableCreateCompanionBuilder = CreditLedgerCompanion
    Function({
  Value<int> id,
  required int customerId,
  required String type,
  required double amount,
  required double balanceAfter,
  Value<String> description,
  Value<int?> invoiceId,
  Value<DateTime> createdAt,
});
typedef $$CreditLedgerTableUpdateCompanionBuilder = CreditLedgerCompanion
    Function({
  Value<int> id,
  Value<int> customerId,
  Value<String> type,
  Value<double> amount,
  Value<double> balanceAfter,
  Value<String> description,
  Value<int?> invoiceId,
  Value<DateTime> createdAt,
});

final class $$CreditLedgerTableReferences extends BaseReferences<_$AppDatabase,
    $CreditLedgerTable, CreditLedgerData> {
  $$CreditLedgerTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
          $_aliasNameGenerator(db.creditLedger.customerId, db.customers.id));

  $$CustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<int>('customer_id')!;

    final manager = $$CustomersTableTableManager($_db, $_db.customers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CreditLedgerTableFilterComposer
    extends Composer<_$AppDatabase, $CreditLedgerTable> {
  $$CreditLedgerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get balanceAfter => $composableBuilder(
      column: $table.balanceAfter, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get invoiceId => $composableBuilder(
      column: $table.invoiceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableFilterComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CreditLedgerTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditLedgerTable> {
  $$CreditLedgerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get balanceAfter => $composableBuilder(
      column: $table.balanceAfter,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get invoiceId => $composableBuilder(
      column: $table.invoiceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableOrderingComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CreditLedgerTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditLedgerTable> {
  $$CreditLedgerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get balanceAfter => $composableBuilder(
      column: $table.balanceAfter, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableAnnotationComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CreditLedgerTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CreditLedgerTable,
    CreditLedgerData,
    $$CreditLedgerTableFilterComposer,
    $$CreditLedgerTableOrderingComposer,
    $$CreditLedgerTableAnnotationComposer,
    $$CreditLedgerTableCreateCompanionBuilder,
    $$CreditLedgerTableUpdateCompanionBuilder,
    (CreditLedgerData, $$CreditLedgerTableReferences),
    CreditLedgerData,
    PrefetchHooks Function({bool customerId})> {
  $$CreditLedgerTableTableManager(_$AppDatabase db, $CreditLedgerTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditLedgerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditLedgerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditLedgerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> customerId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<double> balanceAfter = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<int?> invoiceId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CreditLedgerCompanion(
            id: id,
            customerId: customerId,
            type: type,
            amount: amount,
            balanceAfter: balanceAfter,
            description: description,
            invoiceId: invoiceId,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int customerId,
            required String type,
            required double amount,
            required double balanceAfter,
            Value<String> description = const Value.absent(),
            Value<int?> invoiceId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CreditLedgerCompanion.insert(
            id: id,
            customerId: customerId,
            type: type,
            amount: amount,
            balanceAfter: balanceAfter,
            description: description,
            invoiceId: invoiceId,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CreditLedgerTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({customerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (customerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.customerId,
                    referencedTable:
                        $$CreditLedgerTableReferences._customerIdTable(db),
                    referencedColumn:
                        $$CreditLedgerTableReferences._customerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CreditLedgerTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CreditLedgerTable,
    CreditLedgerData,
    $$CreditLedgerTableFilterComposer,
    $$CreditLedgerTableOrderingComposer,
    $$CreditLedgerTableAnnotationComposer,
    $$CreditLedgerTableCreateCompanionBuilder,
    $$CreditLedgerTableUpdateCompanionBuilder,
    (CreditLedgerData, $$CreditLedgerTableReferences),
    CreditLedgerData,
    PrefetchHooks Function({bool customerId})>;
typedef $$InventoryItemsTableCreateCompanionBuilder = InventoryItemsCompanion
    Function({
  Value<int> id,
  required String name,
  required String unit,
  Value<double> currentStock,
  Value<double> minStock,
  Value<double> costPerUnit,
  Value<int?> supplierId,
  Value<DateTime?> expiryDate,
});
typedef $$InventoryItemsTableUpdateCompanionBuilder = InventoryItemsCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> unit,
  Value<double> currentStock,
  Value<double> minStock,
  Value<double> costPerUnit,
  Value<int?> supplierId,
  Value<DateTime?> expiryDate,
});

class $$InventoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get currentStock => $composableBuilder(
      column: $table.currentStock, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get minStock => $composableBuilder(
      column: $table.minStock, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costPerUnit => $composableBuilder(
      column: $table.costPerUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get supplierId => $composableBuilder(
      column: $table.supplierId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => ColumnFilters(column));
}

class $$InventoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get currentStock => $composableBuilder(
      column: $table.currentStock,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get minStock => $composableBuilder(
      column: $table.minStock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costPerUnit => $composableBuilder(
      column: $table.costPerUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get supplierId => $composableBuilder(
      column: $table.supplierId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => ColumnOrderings(column));
}

class $$InventoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get currentStock => $composableBuilder(
      column: $table.currentStock, builder: (column) => column);

  GeneratedColumn<double> get minStock =>
      $composableBuilder(column: $table.minStock, builder: (column) => column);

  GeneratedColumn<double> get costPerUnit => $composableBuilder(
      column: $table.costPerUnit, builder: (column) => column);

  GeneratedColumn<int> get supplierId => $composableBuilder(
      column: $table.supplierId, builder: (column) => column);

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => column);
}

class $$InventoryItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InventoryItemsTable,
    InventoryItem,
    $$InventoryItemsTableFilterComposer,
    $$InventoryItemsTableOrderingComposer,
    $$InventoryItemsTableAnnotationComposer,
    $$InventoryItemsTableCreateCompanionBuilder,
    $$InventoryItemsTableUpdateCompanionBuilder,
    (
      InventoryItem,
      BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>
    ),
    InventoryItem,
    PrefetchHooks Function()> {
  $$InventoryItemsTableTableManager(
      _$AppDatabase db, $InventoryItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<double> currentStock = const Value.absent(),
            Value<double> minStock = const Value.absent(),
            Value<double> costPerUnit = const Value.absent(),
            Value<int?> supplierId = const Value.absent(),
            Value<DateTime?> expiryDate = const Value.absent(),
          }) =>
              InventoryItemsCompanion(
            id: id,
            name: name,
            unit: unit,
            currentStock: currentStock,
            minStock: minStock,
            costPerUnit: costPerUnit,
            supplierId: supplierId,
            expiryDate: expiryDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String unit,
            Value<double> currentStock = const Value.absent(),
            Value<double> minStock = const Value.absent(),
            Value<double> costPerUnit = const Value.absent(),
            Value<int?> supplierId = const Value.absent(),
            Value<DateTime?> expiryDate = const Value.absent(),
          }) =>
              InventoryItemsCompanion.insert(
            id: id,
            name: name,
            unit: unit,
            currentStock: currentStock,
            minStock: minStock,
            costPerUnit: costPerUnit,
            supplierId: supplierId,
            expiryDate: expiryDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InventoryItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InventoryItemsTable,
    InventoryItem,
    $$InventoryItemsTableFilterComposer,
    $$InventoryItemsTableOrderingComposer,
    $$InventoryItemsTableAnnotationComposer,
    $$InventoryItemsTableCreateCompanionBuilder,
    $$InventoryItemsTableUpdateCompanionBuilder,
    (
      InventoryItem,
      BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>
    ),
    InventoryItem,
    PrefetchHooks Function()>;
typedef $$CashRegistersTableCreateCompanionBuilder = CashRegistersCompanion
    Function({
  Value<int> id,
  required String openedBy,
  required double openingCash,
  Value<DateTime> openedAt,
  Value<String> status,
  Value<String?> closedBy,
  Value<DateTime?> closedAt,
  Value<double> closingCash,
  Value<double> totalCashSales,
  Value<double> totalCardSales,
  Value<double> totalWalletSales,
  Value<double> totalCreditSales,
  Value<double> totalExpenses,
  Value<double> cashIn,
  Value<double> cashOut,
  Value<int> totalOrders,
  Value<int> totalKitchenTickets,
  Value<double> totalDiscounts,
  Value<double> totalTax,
  Value<int> totalVoids,
});
typedef $$CashRegistersTableUpdateCompanionBuilder = CashRegistersCompanion
    Function({
  Value<int> id,
  Value<String> openedBy,
  Value<double> openingCash,
  Value<DateTime> openedAt,
  Value<String> status,
  Value<String?> closedBy,
  Value<DateTime?> closedAt,
  Value<double> closingCash,
  Value<double> totalCashSales,
  Value<double> totalCardSales,
  Value<double> totalWalletSales,
  Value<double> totalCreditSales,
  Value<double> totalExpenses,
  Value<double> cashIn,
  Value<double> cashOut,
  Value<int> totalOrders,
  Value<int> totalKitchenTickets,
  Value<double> totalDiscounts,
  Value<double> totalTax,
  Value<int> totalVoids,
});

class $$CashRegistersTableFilterComposer
    extends Composer<_$AppDatabase, $CashRegistersTable> {
  $$CashRegistersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get openedBy => $composableBuilder(
      column: $table.openedBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get openingCash => $composableBuilder(
      column: $table.openingCash, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
      column: $table.openedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get closedBy => $composableBuilder(
      column: $table.closedBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get closingCash => $composableBuilder(
      column: $table.closingCash, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCashSales => $composableBuilder(
      column: $table.totalCashSales,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCardSales => $composableBuilder(
      column: $table.totalCardSales,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalWalletSales => $composableBuilder(
      column: $table.totalWalletSales,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCreditSales => $composableBuilder(
      column: $table.totalCreditSales,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalExpenses => $composableBuilder(
      column: $table.totalExpenses, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cashIn => $composableBuilder(
      column: $table.cashIn, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cashOut => $composableBuilder(
      column: $table.cashOut, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalOrders => $composableBuilder(
      column: $table.totalOrders, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalKitchenTickets => $composableBuilder(
      column: $table.totalKitchenTickets,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalDiscounts => $composableBuilder(
      column: $table.totalDiscounts,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalTax => $composableBuilder(
      column: $table.totalTax, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalVoids => $composableBuilder(
      column: $table.totalVoids, builder: (column) => ColumnFilters(column));
}

class $$CashRegistersTableOrderingComposer
    extends Composer<_$AppDatabase, $CashRegistersTable> {
  $$CashRegistersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get openedBy => $composableBuilder(
      column: $table.openedBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get openingCash => $composableBuilder(
      column: $table.openingCash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
      column: $table.openedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get closedBy => $composableBuilder(
      column: $table.closedBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get closingCash => $composableBuilder(
      column: $table.closingCash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCashSales => $composableBuilder(
      column: $table.totalCashSales,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCardSales => $composableBuilder(
      column: $table.totalCardSales,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalWalletSales => $composableBuilder(
      column: $table.totalWalletSales,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCreditSales => $composableBuilder(
      column: $table.totalCreditSales,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalExpenses => $composableBuilder(
      column: $table.totalExpenses,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cashIn => $composableBuilder(
      column: $table.cashIn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cashOut => $composableBuilder(
      column: $table.cashOut, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalOrders => $composableBuilder(
      column: $table.totalOrders, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalKitchenTickets => $composableBuilder(
      column: $table.totalKitchenTickets,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalDiscounts => $composableBuilder(
      column: $table.totalDiscounts,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalTax => $composableBuilder(
      column: $table.totalTax, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalVoids => $composableBuilder(
      column: $table.totalVoids, builder: (column) => ColumnOrderings(column));
}

class $$CashRegistersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashRegistersTable> {
  $$CashRegistersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get openedBy =>
      $composableBuilder(column: $table.openedBy, builder: (column) => column);

  GeneratedColumn<double> get openingCash => $composableBuilder(
      column: $table.openingCash, builder: (column) => column);

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get closedBy =>
      $composableBuilder(column: $table.closedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  GeneratedColumn<double> get closingCash => $composableBuilder(
      column: $table.closingCash, builder: (column) => column);

  GeneratedColumn<double> get totalCashSales => $composableBuilder(
      column: $table.totalCashSales, builder: (column) => column);

  GeneratedColumn<double> get totalCardSales => $composableBuilder(
      column: $table.totalCardSales, builder: (column) => column);

  GeneratedColumn<double> get totalWalletSales => $composableBuilder(
      column: $table.totalWalletSales, builder: (column) => column);

  GeneratedColumn<double> get totalCreditSales => $composableBuilder(
      column: $table.totalCreditSales, builder: (column) => column);

  GeneratedColumn<double> get totalExpenses => $composableBuilder(
      column: $table.totalExpenses, builder: (column) => column);

  GeneratedColumn<double> get cashIn =>
      $composableBuilder(column: $table.cashIn, builder: (column) => column);

  GeneratedColumn<double> get cashOut =>
      $composableBuilder(column: $table.cashOut, builder: (column) => column);

  GeneratedColumn<int> get totalOrders => $composableBuilder(
      column: $table.totalOrders, builder: (column) => column);

  GeneratedColumn<int> get totalKitchenTickets => $composableBuilder(
      column: $table.totalKitchenTickets, builder: (column) => column);

  GeneratedColumn<double> get totalDiscounts => $composableBuilder(
      column: $table.totalDiscounts, builder: (column) => column);

  GeneratedColumn<double> get totalTax =>
      $composableBuilder(column: $table.totalTax, builder: (column) => column);

  GeneratedColumn<int> get totalVoids => $composableBuilder(
      column: $table.totalVoids, builder: (column) => column);
}

class $$CashRegistersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CashRegistersTable,
    CashRegister,
    $$CashRegistersTableFilterComposer,
    $$CashRegistersTableOrderingComposer,
    $$CashRegistersTableAnnotationComposer,
    $$CashRegistersTableCreateCompanionBuilder,
    $$CashRegistersTableUpdateCompanionBuilder,
    (
      CashRegister,
      BaseReferences<_$AppDatabase, $CashRegistersTable, CashRegister>
    ),
    CashRegister,
    PrefetchHooks Function()> {
  $$CashRegistersTableTableManager(_$AppDatabase db, $CashRegistersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashRegistersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashRegistersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashRegistersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> openedBy = const Value.absent(),
            Value<double> openingCash = const Value.absent(),
            Value<DateTime> openedAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> closedBy = const Value.absent(),
            Value<DateTime?> closedAt = const Value.absent(),
            Value<double> closingCash = const Value.absent(),
            Value<double> totalCashSales = const Value.absent(),
            Value<double> totalCardSales = const Value.absent(),
            Value<double> totalWalletSales = const Value.absent(),
            Value<double> totalCreditSales = const Value.absent(),
            Value<double> totalExpenses = const Value.absent(),
            Value<double> cashIn = const Value.absent(),
            Value<double> cashOut = const Value.absent(),
            Value<int> totalOrders = const Value.absent(),
            Value<int> totalKitchenTickets = const Value.absent(),
            Value<double> totalDiscounts = const Value.absent(),
            Value<double> totalTax = const Value.absent(),
            Value<int> totalVoids = const Value.absent(),
          }) =>
              CashRegistersCompanion(
            id: id,
            openedBy: openedBy,
            openingCash: openingCash,
            openedAt: openedAt,
            status: status,
            closedBy: closedBy,
            closedAt: closedAt,
            closingCash: closingCash,
            totalCashSales: totalCashSales,
            totalCardSales: totalCardSales,
            totalWalletSales: totalWalletSales,
            totalCreditSales: totalCreditSales,
            totalExpenses: totalExpenses,
            cashIn: cashIn,
            cashOut: cashOut,
            totalOrders: totalOrders,
            totalKitchenTickets: totalKitchenTickets,
            totalDiscounts: totalDiscounts,
            totalTax: totalTax,
            totalVoids: totalVoids,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String openedBy,
            required double openingCash,
            Value<DateTime> openedAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> closedBy = const Value.absent(),
            Value<DateTime?> closedAt = const Value.absent(),
            Value<double> closingCash = const Value.absent(),
            Value<double> totalCashSales = const Value.absent(),
            Value<double> totalCardSales = const Value.absent(),
            Value<double> totalWalletSales = const Value.absent(),
            Value<double> totalCreditSales = const Value.absent(),
            Value<double> totalExpenses = const Value.absent(),
            Value<double> cashIn = const Value.absent(),
            Value<double> cashOut = const Value.absent(),
            Value<int> totalOrders = const Value.absent(),
            Value<int> totalKitchenTickets = const Value.absent(),
            Value<double> totalDiscounts = const Value.absent(),
            Value<double> totalTax = const Value.absent(),
            Value<int> totalVoids = const Value.absent(),
          }) =>
              CashRegistersCompanion.insert(
            id: id,
            openedBy: openedBy,
            openingCash: openingCash,
            openedAt: openedAt,
            status: status,
            closedBy: closedBy,
            closedAt: closedAt,
            closingCash: closingCash,
            totalCashSales: totalCashSales,
            totalCardSales: totalCardSales,
            totalWalletSales: totalWalletSales,
            totalCreditSales: totalCreditSales,
            totalExpenses: totalExpenses,
            cashIn: cashIn,
            cashOut: cashOut,
            totalOrders: totalOrders,
            totalKitchenTickets: totalKitchenTickets,
            totalDiscounts: totalDiscounts,
            totalTax: totalTax,
            totalVoids: totalVoids,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CashRegistersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CashRegistersTable,
    CashRegister,
    $$CashRegistersTableFilterComposer,
    $$CashRegistersTableOrderingComposer,
    $$CashRegistersTableAnnotationComposer,
    $$CashRegistersTableCreateCompanionBuilder,
    $$CashRegistersTableUpdateCompanionBuilder,
    (
      CashRegister,
      BaseReferences<_$AppDatabase, $CashRegistersTable, CashRegister>
    ),
    CashRegister,
    PrefetchHooks Function()>;
typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  required String category,
  required double amount,
  required String description,
  required String paidBy,
  Value<int?> registerId,
  Value<DateTime> createdAt,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  Value<String> category,
  Value<double> amount,
  Value<String> description,
  Value<String> paidBy,
  Value<int?> registerId,
  Value<DateTime> createdAt,
});

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paidBy => $composableBuilder(
      column: $table.paidBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get registerId => $composableBuilder(
      column: $table.registerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paidBy => $composableBuilder(
      column: $table.paidBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get registerId => $composableBuilder(
      column: $table.registerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get paidBy =>
      $composableBuilder(column: $table.paidBy, builder: (column) => column);

  GeneratedColumn<int> get registerId => $composableBuilder(
      column: $table.registerId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ExpensesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
    Expense,
    PrefetchHooks Function()> {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> paidBy = const Value.absent(),
            Value<int?> registerId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ExpensesCompanion(
            id: id,
            category: category,
            amount: amount,
            description: description,
            paidBy: paidBy,
            registerId: registerId,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String category,
            required double amount,
            required String description,
            required String paidBy,
            Value<int?> registerId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ExpensesCompanion.insert(
            id: id,
            category: category,
            amount: amount,
            description: description,
            paidBy: paidBy,
            registerId: registerId,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExpensesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
    Expense,
    PrefetchHooks Function()>;
typedef $$AttendanceTableCreateCompanionBuilder = AttendanceCompanion Function({
  Value<int> id,
  required int userId,
  required String userName,
  required DateTime checkIn,
  Value<DateTime?> checkOut,
  Value<double> dailyWage,
});
typedef $$AttendanceTableUpdateCompanionBuilder = AttendanceCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<String> userName,
  Value<DateTime> checkIn,
  Value<DateTime?> checkOut,
  Value<double> dailyWage,
});

final class $$AttendanceTableReferences
    extends BaseReferences<_$AppDatabase, $AttendanceTable, AttendanceData> {
  $$AttendanceTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.attendance.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AttendanceTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userName => $composableBuilder(
      column: $table.userName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get checkIn => $composableBuilder(
      column: $table.checkIn, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get checkOut => $composableBuilder(
      column: $table.checkOut, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get dailyWage => $composableBuilder(
      column: $table.dailyWage, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AttendanceTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userName => $composableBuilder(
      column: $table.userName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get checkIn => $composableBuilder(
      column: $table.checkIn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get checkOut => $composableBuilder(
      column: $table.checkOut, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get dailyWage => $composableBuilder(
      column: $table.dailyWage, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AttendanceTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceTable> {
  $$AttendanceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<DateTime> get checkIn =>
      $composableBuilder(column: $table.checkIn, builder: (column) => column);

  GeneratedColumn<DateTime> get checkOut =>
      $composableBuilder(column: $table.checkOut, builder: (column) => column);

  GeneratedColumn<double> get dailyWage =>
      $composableBuilder(column: $table.dailyWage, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AttendanceTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AttendanceTable,
    AttendanceData,
    $$AttendanceTableFilterComposer,
    $$AttendanceTableOrderingComposer,
    $$AttendanceTableAnnotationComposer,
    $$AttendanceTableCreateCompanionBuilder,
    $$AttendanceTableUpdateCompanionBuilder,
    (AttendanceData, $$AttendanceTableReferences),
    AttendanceData,
    PrefetchHooks Function({bool userId})> {
  $$AttendanceTableTableManager(_$AppDatabase db, $AttendanceTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> userName = const Value.absent(),
            Value<DateTime> checkIn = const Value.absent(),
            Value<DateTime?> checkOut = const Value.absent(),
            Value<double> dailyWage = const Value.absent(),
          }) =>
              AttendanceCompanion(
            id: id,
            userId: userId,
            userName: userName,
            checkIn: checkIn,
            checkOut: checkOut,
            dailyWage: dailyWage,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required String userName,
            required DateTime checkIn,
            Value<DateTime?> checkOut = const Value.absent(),
            Value<double> dailyWage = const Value.absent(),
          }) =>
              AttendanceCompanion.insert(
            id: id,
            userId: userId,
            userName: userName,
            checkIn: checkIn,
            checkOut: checkOut,
            dailyWage: dailyWage,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AttendanceTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$AttendanceTableReferences._userIdTable(db),
                    referencedColumn:
                        $$AttendanceTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AttendanceTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AttendanceTable,
    AttendanceData,
    $$AttendanceTableFilterComposer,
    $$AttendanceTableOrderingComposer,
    $$AttendanceTableAnnotationComposer,
    $$AttendanceTableCreateCompanionBuilder,
    $$AttendanceTableUpdateCompanionBuilder,
    (AttendanceData, $$AttendanceTableReferences),
    AttendanceData,
    PrefetchHooks Function({bool userId})>;
typedef $$SalaryPaymentsTableCreateCompanionBuilder = SalaryPaymentsCompanion
    Function({
  Value<int> id,
  required int userId,
  required String userName,
  required int month,
  required int year,
  required double amount,
  Value<String?> notes,
  Value<DateTime> paidAt,
});
typedef $$SalaryPaymentsTableUpdateCompanionBuilder = SalaryPaymentsCompanion
    Function({
  Value<int> id,
  Value<int> userId,
  Value<String> userName,
  Value<int> month,
  Value<int> year,
  Value<double> amount,
  Value<String?> notes,
  Value<DateTime> paidAt,
});

final class $$SalaryPaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $SalaryPaymentsTable, SalaryPayment> {
  $$SalaryPaymentsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.salaryPayments.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SalaryPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $SalaryPaymentsTable> {
  $$SalaryPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userName => $composableBuilder(
      column: $table.userName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
      column: $table.paidAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SalaryPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $SalaryPaymentsTable> {
  $$SalaryPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userName => $composableBuilder(
      column: $table.userName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
      column: $table.paidAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SalaryPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalaryPaymentsTable> {
  $$SalaryPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SalaryPaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SalaryPaymentsTable,
    SalaryPayment,
    $$SalaryPaymentsTableFilterComposer,
    $$SalaryPaymentsTableOrderingComposer,
    $$SalaryPaymentsTableAnnotationComposer,
    $$SalaryPaymentsTableCreateCompanionBuilder,
    $$SalaryPaymentsTableUpdateCompanionBuilder,
    (SalaryPayment, $$SalaryPaymentsTableReferences),
    SalaryPayment,
    PrefetchHooks Function({bool userId})> {
  $$SalaryPaymentsTableTableManager(
      _$AppDatabase db, $SalaryPaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalaryPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalaryPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalaryPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<String> userName = const Value.absent(),
            Value<int> month = const Value.absent(),
            Value<int> year = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> paidAt = const Value.absent(),
          }) =>
              SalaryPaymentsCompanion(
            id: id,
            userId: userId,
            userName: userName,
            month: month,
            year: year,
            amount: amount,
            notes: notes,
            paidAt: paidAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required String userName,
            required int month,
            required int year,
            required double amount,
            Value<String?> notes = const Value.absent(),
            Value<DateTime> paidAt = const Value.absent(),
          }) =>
              SalaryPaymentsCompanion.insert(
            id: id,
            userId: userId,
            userName: userName,
            month: month,
            year: year,
            amount: amount,
            notes: notes,
            paidAt: paidAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SalaryPaymentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$SalaryPaymentsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$SalaryPaymentsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SalaryPaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SalaryPaymentsTable,
    SalaryPayment,
    $$SalaryPaymentsTableFilterComposer,
    $$SalaryPaymentsTableOrderingComposer,
    $$SalaryPaymentsTableAnnotationComposer,
    $$SalaryPaymentsTableCreateCompanionBuilder,
    $$SalaryPaymentsTableUpdateCompanionBuilder,
    (SalaryPayment, $$SalaryPaymentsTableReferences),
    SalaryPayment,
    PrefetchHooks Function({bool userId})>;
typedef $$AppSettingsTableCreateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  required String key,
  required String value,
  Value<DateTime> updatedAt,
});
typedef $$AppSettingsTableUpdateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  Value<String> key,
  Value<String> value,
  Value<DateTime> updatedAt,
});

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()> {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AppSettingsCompanion(
            id: id,
            key: key,
            value: value,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String key,
            required String value,
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AppSettingsCompanion.insert(
            id: id,
            key: key,
            value: value,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()>;
typedef $$DealItemsTableCreateCompanionBuilder = DealItemsCompanion Function({
  Value<int> id,
  required int dealId,
  required int menuItemId,
  required int quantity,
});
typedef $$DealItemsTableUpdateCompanionBuilder = DealItemsCompanion Function({
  Value<int> id,
  Value<int> dealId,
  Value<int> menuItemId,
  Value<int> quantity,
});

final class $$DealItemsTableReferences
    extends BaseReferences<_$AppDatabase, $DealItemsTable, DealItem> {
  $$DealItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DealsTable _dealIdTable(_$AppDatabase db) => db.deals
      .createAlias($_aliasNameGenerator(db.dealItems.dealId, db.deals.id));

  $$DealsTableProcessedTableManager get dealId {
    final $_column = $_itemColumn<int>('deal_id')!;

    final manager = $$DealsTableTableManager($_db, $_db.deals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dealIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MenuItemsTable _menuItemIdTable(_$AppDatabase db) =>
      db.menuItems.createAlias(
          $_aliasNameGenerator(db.dealItems.menuItemId, db.menuItems.id));

  $$MenuItemsTableProcessedTableManager get menuItemId {
    final $_column = $_itemColumn<int>('menu_item_id')!;

    final manager = $$MenuItemsTableTableManager($_db, $_db.menuItems)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_menuItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DealItemsTableFilterComposer
    extends Composer<_$AppDatabase, $DealItemsTable> {
  $$DealItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  $$DealsTableFilterComposer get dealId {
    final $$DealsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dealId,
        referencedTable: $db.deals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DealsTableFilterComposer(
              $db: $db,
              $table: $db.deals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MenuItemsTableFilterComposer get menuItemId {
    final $$MenuItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.menuItemId,
        referencedTable: $db.menuItems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuItemsTableFilterComposer(
              $db: $db,
              $table: $db.menuItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DealItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $DealItemsTable> {
  $$DealItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  $$DealsTableOrderingComposer get dealId {
    final $$DealsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dealId,
        referencedTable: $db.deals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DealsTableOrderingComposer(
              $db: $db,
              $table: $db.deals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MenuItemsTableOrderingComposer get menuItemId {
    final $$MenuItemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.menuItemId,
        referencedTable: $db.menuItems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuItemsTableOrderingComposer(
              $db: $db,
              $table: $db.menuItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DealItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DealItemsTable> {
  $$DealItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  $$DealsTableAnnotationComposer get dealId {
    final $$DealsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dealId,
        referencedTable: $db.deals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DealsTableAnnotationComposer(
              $db: $db,
              $table: $db.deals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MenuItemsTableAnnotationComposer get menuItemId {
    final $$MenuItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.menuItemId,
        referencedTable: $db.menuItems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MenuItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.menuItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DealItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DealItemsTable,
    DealItem,
    $$DealItemsTableFilterComposer,
    $$DealItemsTableOrderingComposer,
    $$DealItemsTableAnnotationComposer,
    $$DealItemsTableCreateCompanionBuilder,
    $$DealItemsTableUpdateCompanionBuilder,
    (DealItem, $$DealItemsTableReferences),
    DealItem,
    PrefetchHooks Function({bool dealId, bool menuItemId})> {
  $$DealItemsTableTableManager(_$AppDatabase db, $DealItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DealItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DealItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DealItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> dealId = const Value.absent(),
            Value<int> menuItemId = const Value.absent(),
            Value<int> quantity = const Value.absent(),
          }) =>
              DealItemsCompanion(
            id: id,
            dealId: dealId,
            menuItemId: menuItemId,
            quantity: quantity,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dealId,
            required int menuItemId,
            required int quantity,
          }) =>
              DealItemsCompanion.insert(
            id: id,
            dealId: dealId,
            menuItemId: menuItemId,
            quantity: quantity,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DealItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({dealId = false, menuItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (dealId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dealId,
                    referencedTable:
                        $$DealItemsTableReferences._dealIdTable(db),
                    referencedColumn:
                        $$DealItemsTableReferences._dealIdTable(db).id,
                  ) as T;
                }
                if (menuItemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.menuItemId,
                    referencedTable:
                        $$DealItemsTableReferences._menuItemIdTable(db),
                    referencedColumn:
                        $$DealItemsTableReferences._menuItemIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DealItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DealItemsTable,
    DealItem,
    $$DealItemsTableFilterComposer,
    $$DealItemsTableOrderingComposer,
    $$DealItemsTableAnnotationComposer,
    $$DealItemsTableCreateCompanionBuilder,
    $$DealItemsTableUpdateCompanionBuilder,
    (DealItem, $$DealItemsTableReferences),
    DealItem,
    PrefetchHooks Function({bool dealId, bool menuItemId})>;
typedef $$BackupHistoriesTableCreateCompanionBuilder = BackupHistoriesCompanion
    Function({
  Value<int> id,
  Value<DateTime> createdAt,
  required String location,
  required String status,
  Value<String?> errorMessage,
  Value<double> sizeBytes,
});
typedef $$BackupHistoriesTableUpdateCompanionBuilder = BackupHistoriesCompanion
    Function({
  Value<int> id,
  Value<DateTime> createdAt,
  Value<String> location,
  Value<String> status,
  Value<String?> errorMessage,
  Value<double> sizeBytes,
});

class $$BackupHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $BackupHistoriesTable> {
  $$BackupHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnFilters(column));
}

class $$BackupHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $BackupHistoriesTable> {
  $$BackupHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sizeBytes => $composableBuilder(
      column: $table.sizeBytes, builder: (column) => ColumnOrderings(column));
}

class $$BackupHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackupHistoriesTable> {
  $$BackupHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);

  GeneratedColumn<double> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);
}

class $$BackupHistoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BackupHistoriesTable,
    BackupHistory,
    $$BackupHistoriesTableFilterComposer,
    $$BackupHistoriesTableOrderingComposer,
    $$BackupHistoriesTableAnnotationComposer,
    $$BackupHistoriesTableCreateCompanionBuilder,
    $$BackupHistoriesTableUpdateCompanionBuilder,
    (
      BackupHistory,
      BaseReferences<_$AppDatabase, $BackupHistoriesTable, BackupHistory>
    ),
    BackupHistory,
    PrefetchHooks Function()> {
  $$BackupHistoriesTableTableManager(
      _$AppDatabase db, $BackupHistoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackupHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackupHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackupHistoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<double> sizeBytes = const Value.absent(),
          }) =>
              BackupHistoriesCompanion(
            id: id,
            createdAt: createdAt,
            location: location,
            status: status,
            errorMessage: errorMessage,
            sizeBytes: sizeBytes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            required String location,
            required String status,
            Value<String?> errorMessage = const Value.absent(),
            Value<double> sizeBytes = const Value.absent(),
          }) =>
              BackupHistoriesCompanion.insert(
            id: id,
            createdAt: createdAt,
            location: location,
            status: status,
            errorMessage: errorMessage,
            sizeBytes: sizeBytes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BackupHistoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BackupHistoriesTable,
    BackupHistory,
    $$BackupHistoriesTableFilterComposer,
    $$BackupHistoriesTableOrderingComposer,
    $$BackupHistoriesTableAnnotationComposer,
    $$BackupHistoriesTableCreateCompanionBuilder,
    $$BackupHistoriesTableUpdateCompanionBuilder,
    (
      BackupHistory,
      BaseReferences<_$AppDatabase, $BackupHistoriesTable, BackupHistory>
    ),
    BackupHistory,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$FloorsTableTableManager get floors =>
      $$FloorsTableTableManager(_db, _db.floors);
  $$RestaurantTablesTableTableManager get restaurantTables =>
      $$RestaurantTablesTableTableManager(_db, _db.restaurantTables);
  $$MenuGroupsTableTableManager get menuGroups =>
      $$MenuGroupsTableTableManager(_db, _db.menuGroups);
  $$MenuItemsTableTableManager get menuItems =>
      $$MenuItemsTableTableManager(_db, _db.menuItems);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$DealsTableTableManager get deals =>
      $$DealsTableTableManager(_db, _db.deals);
  $$OrderItemsTableTableManager get orderItems =>
      $$OrderItemsTableTableManager(_db, _db.orderItems);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$CreditLedgerTableTableManager get creditLedger =>
      $$CreditLedgerTableTableManager(_db, _db.creditLedger);
  $$InventoryItemsTableTableManager get inventoryItems =>
      $$InventoryItemsTableTableManager(_db, _db.inventoryItems);
  $$CashRegistersTableTableManager get cashRegisters =>
      $$CashRegistersTableTableManager(_db, _db.cashRegisters);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$AttendanceTableTableManager get attendance =>
      $$AttendanceTableTableManager(_db, _db.attendance);
  $$SalaryPaymentsTableTableManager get salaryPayments =>
      $$SalaryPaymentsTableTableManager(_db, _db.salaryPayments);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$DealItemsTableTableManager get dealItems =>
      $$DealItemsTableTableManager(_db, _db.dealItems);
  $$BackupHistoriesTableTableManager get backupHistories =>
      $$BackupHistoriesTableTableManager(_db, _db.backupHistories);
}
