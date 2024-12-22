# My Money

A Flutter-based mobile application to help users track and manage their personal expenses efficiently.

## Features
- **Add Expense**: Input the amount, date, and a brief description of expenses.
- **View Expenses**: Display expenses in a list view, with sorting and filtering by date.
- **Edit/Delete Expense**: Modify or remove existing expense entries.
- **Expense Summary**: Summarize expenses categorized by type, with weekly and monthly breakdowns.
- **Reminder Notifications**: Receive daily reminders to record expenses.

## Architecture and Design
- **UI/UX**: Developed a visually appealing and responsive interface using Flutter widgets and a consistent theme.
- **State Management**: Managed application state using GetX.
- **Data Persistence**: Used Hive database for offline storage of expense data.
- **Clean Architecture**: Followed clean architecture principles to separate presentation, business logic, and data layers.

## Notifications
Implemented local notifications using Flutter Local Notifications to send daily reminders for expense tracking.

## Screenshot
![Group 3320](https://github.com/user-attachments/assets/6a095bd1-b212-4657-a703-d8667e6d465b)


## Setup and Running Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/1Muhammed_Shibili/My-Money.git
   cd My-Money
   ```

2. **Install Dependencies**
   Ensure you have Flutter installed on your system. Then, run:
   ```bash
   flutter pub get
   ```

3. **Generate Hive Adapters**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the Application**
   Connect your device or emulator and run:
   ```bash
   flutter run
   ```

5. **Build APK** (Optional)
   To generate a release APK, use:
   ```bash
   flutter build apk --release
   ```

## Testing
- Run unit tests:
  ```bash
  flutter test
  ```
- Ensure code coverage and test for business logic thoroughly.

## Contributing
Feel free to fork the repository and submit pull requests for enhancements or bug fixes.



