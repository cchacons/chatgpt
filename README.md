# chatgpt

This is a Flutter-based Chatgpt App with a sleek and modern design.

![image](https://user-images.githubusercontent.com/67297759/220212716-a0336eff-0b09-411d-b827-dab8597fe806.png)

## Installation
To get started, you need to have [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine. Then, follow the instructions below:

1. Open the terminal and navigate to the project folder.
2. Run the command `flutter packages get` to install the required packages.
3. Run `flutter create` to create the targets
4. Run `flutter run` to build and run the debug app on your emulator/phone

To make the release on the server:
1. flutter build web
   might need to do this: flutter build web --no-tree-shake-icons if there is error related to icons tree
2. sudo cp -r build/web/* /var/www/html/

## Credits

- [Flutter](https://flutter.dev) for providing an amazing cross-platform framework.

## License

This project is licensed under the [MIT License](https://github.com/rrdhoi/chatgpt/blob/master/LICENSE).
