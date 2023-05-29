# photo gallery

A Search based photo gallery, build using Flutter and Unsplash.


### To run this project

1. create "api_key.json" file inside /lib directory.

2. add the following json keys to that file

    `{
    "access-key": <unsplash-access-key>,
    "secret-key": <unsplash-secret-key>
    }`

3. then run the following command

    `flutter run --dart-define-from-file=lib/api_keys.json`