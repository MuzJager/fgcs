class Parent {
  String name;
  int age;

  Parent(this.name, this.age);

  void introduce() {
    print("Меня зовут $name, мне $age лет.");
    _secretMethod();
  }

  void _secretMethod() {
    print("Скрытый мето");
  }
}

class Child extends Parent {
  String hobby;

  Child(String name, int age, this.hobby) : super(name, age);

  @override
  void introduce() {
    print("Меня зовут $name, мне $age лет, и я люблю $hobby");
  }

  static void showMessage() {
    print("Статистический метод");
  }
}

void main() {
  Parent parent = Parent("Генадий", 18);
  parent.introduce();

  Child child = Child("Володя", 18, "программирование");
  child.introduce();

  Child.showMessage();
}
