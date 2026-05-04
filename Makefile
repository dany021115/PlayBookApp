# PlayBook Flutter — convenience targets.
#
# `make web` always launches Chrome on port 5000 so Google OAuth's
# Authorized JavaScript origins can be a single fixed entry
# (`http://localhost:5000`) registered once in Google Cloud Console.

WEB_PORT ?= 5173
WEB_HOSTNAME ?= localhost

.PHONY: web web-release ios android codegen clean

web:
	flutter run -d chrome --web-port=$(WEB_PORT) --web-hostname=$(WEB_HOSTNAME)

web-release:
	flutter run -d chrome --release --web-port=$(WEB_PORT) --web-hostname=$(WEB_HOSTNAME)

ios:
	flutter run -d "iPhone"

android:
	flutter run

codegen:
	dart run build_runner build --delete-conflicting-outputs

clean:
	flutter clean && flutter pub get
