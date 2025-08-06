

Sign in
Help

slang 4.8.1 copy "slang: ^4.8.1" to clipboard
Published 5 days ago • verified publishertienisto.comDart 3 compatible
SDKDARTFLUTTERPLATFORMANDROIDIOSLINUXMACOSWEBWINDOWS
liked status: inactive
665
Readme
Changelog
Example
Installing
Versions
Scores
featured

logo

pub package ci License: MIT

Type-safe i18n solution using JSON, YAML, CSV, or ARB files.

About this library 

🚀 Minimal setup, create JSON files and get started! No configuration needed.
🐞 Bug-resistant, no typos or missing arguments possible due to compile-time checking.
⚡ Fast, you get translations using native dart method calls, zero parsing!
📁 Organized, split large files into smaller ones via namespaces.
🖥 Flutter-independent, use it in any Dart project!
🔨 Configurable, English is not the default language? Configure it in build.yaml!
You can see an example of the generated file here.

This is how you access the translations:

final t = Translations.of(context); // there is also a static getter without context

String a = t.mainScreen.title;                         // simple use case
String b = t.game.end.highscore(score: 32.6);          // with parameters
String c = t.items(n: 2);                              // with pluralization
String d = t.greet(name: 'Tom', context: Gender.male); // with custom context
String e = t.greet(today: DateTime.now());             // with L10n
String f = t.intro.step[4];                            // with index
String g = t.error.type['WARNING'];                    // with dynamic key
String h = t['mainScreen.title'];                      // with fully dynamic key
TextSpan i = t.greet(name: TextSpan(text: 'Tom'));     // with RichText

PageData page0 = t.onboarding.pages[0];                // with interfaces
PageData page1 = t.onboarding.pages[1];
String j = page1.title; // type-safe call
An extensive CLI will help you to manage the translations:

dart run slang                               # generate dart file
dart run slang analyze                       # unused and missing translations
dart run slang normalize                     # sort translations according to base locale
dart run slang configure                     # automatically update CFBundleLocalizations
dart run slang edit move loginPage authPage  # move or rename translations
dart run slang migrate arb src.arb dest.json # migrate arb to json
Table of Contents 

Getting Started
Configuration
Main Features
File Types
String Interpolation
RichText
Lists
Maps
Dynamic Keys
Changing Locale
Complex Features
Linked Translations
Pluralization
Custom Contexts / Enums
Typed Parameters
L10n
Interfaces
Modifiers
Locale Enum
Locale Stream
Translation Overrides
Dependency Injection
Structuring Features
Namespaces
Compact CSV
Other Features
Fallback
Lazy Loading
Comments
Auto Generated Comments
Recasing
Sanitization
Obfuscation
Formatting
Dart Only
Tools
Main Command
Update configuration
Analyze Translations
Clean Translations
Apply Translations
Edit Translations
Normalize Translations
Outdated Translations
Translate with GPT
Migration
ARB
Statistics
Auto Rebuild
More Usages
Assets
Unit Tests
Multiple Packages
Integrations
slang x riverpod
slang x Weblate
FAQ
Further Reading
Ecosystem
Slang in production
Slang ports
Getting Started 

Coming from ARB? There is a tool for that.

Are you using Slang without Flutter? Check out the Dart only section.

Step 1: Add dependencies

You will probably need at least 2 packages: slang and slang_flutter.

dependencies:
  slang: <version>
  slang_flutter: <version> # also add this if you use flutter

dev_dependencies:
  build_runner: <version> # ONLY if you use build_runner (1/2)
  slang_build_runner: <version> # ONLY if you use build_runner (2/2)
Step 2: Create JSON files

Format:

<locale>.<extension>
Most common i18n directories are assets/i18n and lib/i18n. (see Assets).

Example:

lib/
 └── i18n/
      └── en.i18n.json
      └── de.i18n.json
      └── zh-CN.i18n.json <-- example for country code
// File: en.i18n.json
{
  "hello": "Hello $name",
  "save": "Save",
  "login": {
    "success": "Logged in successfully",
    "fail": "Logged in failed"
  }
}
// File: de.i18n.json
{
  "hello": "Hallo $name",
  "save": "Speichern",
  "login": {
    "success": "Login erfolgreich",
    "fail": "Login fehlgeschlagen"
  }
}
Step 3: Generate the dart code

Built-in (recommended during development):

dart run slang
Alternative (useful for CI and initial git checkout, requires slang_build_runner):

dart run build_runner build -d
Step 4: Initialize

a) use device locale

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // add this
  LocaleSettings.useDeviceLocale(); // and this
  runApp(MyApp());
}
b) use specific locale

@override
void initState() {
  super.initState();
  String storedLocale = loadFromStorage(); // your logic here
  LocaleSettings.setLocaleRaw(storedLocale);
}
c) use dependency injection (aka "I handle it myself")

final english = AppLocale.en.build();
final german = AppLocale.de.build();

// read
String a = german.login.success;
You can ignore step 4a and 5 (but not 4b) if you handle the locale yourself.

Step 4a: Flutter locale

This is optional but recommended.

Standard flutter controls (e.g. back button's tooltip) will also pick the right locale.

# File: pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations: # add this
    sdk: flutter
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TranslationProvider(child: MyApp())); // Wrap your app with TranslationProvider
}
MaterialApp(
  locale: TranslationProvider.of(context).flutterLocale, // use provider
  supportedLocales: AppLocaleUtils.supportedLocales,
  localizationsDelegates: GlobalMaterialLocalizations.delegates,
  child: YourFirstScreen(),
)
Step 4b: iOS configuration

Add the supported locales to your Info.plist file.

In this example, we support English (en) and German (de).

File: ios/Runner/Info.plist

<key>CFBundleLocalizations</key>
<array>
   <string>en</string>
   <string>de</string>
</array>
For convenience, you can also run:

dart run slang configure
Step 5: Use your translations

import 'package:my_app/i18n/strings.g.dart'; // (1) import

String a = t.login.success; // (2) get translation
Configuration 

This is optional. This library works without any configuration (in most cases).

For customization, you can create a slang.yaml or a build.yaml file. Place it in the root directory.

slang.yaml (Click to open example)
build.yaml (Click to open example)
Key	Type	Usage	Default
base_locale	String	locale of default json	en
fallback_strategy	none, base_locale, base_locale_empty_string	handle missing translations (i)	none
input_directory	String	path to input directory	null
input_file_pattern	String	input file pattern, must end with .json, .yaml, .csv, .arb	.i18n.json
output_directory	String	path to output directory	null
output_file_name	String	output file name	null
lazy	Boolean	load translations lazily (i)	true
locale_handling	Boolean	generate locale handling logic (i)	true
flutter_integration	Boolean	generate flutter features (i)	true
namespaces	Boolean	split input files (i)	false
translate_var	String	translate variable name	t
enum_name	String	enum name	AppLocale
class_name	String	name of the translations class	Translations
translation_class_visibility	private, public	class visibility	private
key_case	null, camel, pascal, snake	transform keys (optional) (i)	null
key_map_case	null, camel, pascal, snake	transform keys for maps (optional) (i)	null
param_case	null, camel, pascal, snake	transform parameters (optional) (i)	null
sanitization/enabled	Boolean	enable sanitization (i)	true
sanitization/prefix	String	prefix for sanitization (i)	k
sanitization/case	null, camel, pascal, snake	case style for sanitization (i)	camel
string_interpolation	dart, braces, double_braces	string interpolation mode (i)	dart
flat_map	Boolean	generate flat map (i)	true
translation_overrides	Boolean	enable translation overrides (i)	false
timestamp	Boolean	write "Built on" timestamp	true
statistics	Boolean	write statistics (locale and string count)	true
maps	List<String>	entries which should be accessed via keys (i)	[]
pluralization/auto	off, cardinal, ordinal	detect plurals automatically (i)	cardinal
pluralization/default_parameter	String	default plural parameter (i)	n
pluralization/cardinal	List<String>	entries which have cardinals	[]
pluralization/ordinal	List<String>	entries which have ordinals	[]
<context>/default_parameter	String	default parameter name (i)	context
<context>/generate_enum	Boolean	generate enum (i)	true
children of interfaces	Pairs of Alias:Path	alias interfaces (i)	null
obfuscation/enabled	Boolean	enable obfuscation (i)	false
obfuscation/secret	String	obfuscation secret (random if null) (i)	null
format/enabled	Boolean	enable auto format (i)	false
format/width	String	set line length / characters per line (i)	null
autodoc/enabled	Boolean	enable autodoc (i)	true
autodoc/locales	List<String>	list of locales to generate (i)	$BASE$
imports	List<String>	generate import statements	[]
generate_enum	Boolean	global generate_enum (i)	true
Main Features 

➤ File Types 

Supported file types: JSON (default), YAML, CSV, and ARB.

Update input_file_pattern to change the file type.

# Config
input_directory: assets/i18n
input_file_pattern: .i18n.yaml # must end with .json, .yaml, .csv, or .arb
JSON Example

The default file type.

{
  "welcome": {
    "title": "Welcome $name"
  }
}
YAML Example

YAML offers a more compact syntax. It provides native support for multiline strings and comments.

welcome:
  title: Welcome $name # some comment
CSV Example

You may also combine multiple locales into one CSV (see Compact CSV).

welcome.title,Welcome $name
pages.0.title,First Page
pages.1.title,Second Page
ARB Example

ARB is the default format for Flutter projects. However, it doesn't support lists or maps. String interpolation is fixed to braces mode.

{
  "@@locale": "en",
  "welcomeTitle": "Welcome {name}",
  "@welcomeTitle": {
    "placeholders": {
      "name": {}
    }
  },
  "inboxPageCount": "You have {count, plural, one {1 message} other {{count} messages}}",
  "@inboxPageCount": {
    "description": "The number of messages in the user's inbox",
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  }
}
➤ String Interpolation 

Translations often have a dynamic parameter.

By default, this library uses the Dart string interpolation syntax $name.

Update string_interpolation to change the syntax.

# Config
string_interpolation: dart # change to braces or double_braces
You can always escape them by adding a backslash, e.g. \{notAnArgument}.

Mode	Example
dart (default)	Hello $name. I am ${height}m.
braces	Hello {name}
double_braces	Hello {{name}}
➤ RichText 

You can add multiple styles to one translation.

To do this, please add the (rich) modifier.

Parameters are formatted according to string_interpolation.

Default text can be defined via brackets (...), e.g. underline(here).

{
  "myText(rich)": "Welcome $name. Please click ${tapHere(here)}!"
}
Usage:

// Text.rich is a Flutter built-in feature!
Widget a = Text.rich(t.myText(
  // Show name in blue color
  name: TextSpan(text: 'Tom', style: TextStyle(color: Colors.blue)),
  
  // Turn 'here' into a link
  tapHere: (text) => TextSpan(
    text: text,
    style: TextStyle(color: Colors.blue),
    recognizer: TapGestureRecognizer()..onTap=(){
      print('tap');
    },
  ),
));
➤ Lists 

Lists are fully supported. No configuration needed. You can also put lists or maps inside lists!

{
  "niceList": [
    "hello",
    "nice",
    [
      "first item in nested list",
      "second item in nested list"
    ],
    {
      "wow": "WOW!",
      "ok": "OK!"
    },
    {
      "a map entry": "access via key",
      "another entry": "access via second key"
    }
  ]
}
String a = t.niceList[1]; // "nice"
String b = t.niceList[2][0]; // "first item in nested list"
String c = t.niceList[3].ok; // "OK!"
String d = t.niceList[4]['a map entry']; // "access via key"
➤ Maps 

You can access each translation via string keys.

Add the (map) modifier.

// File: strings.i18n.json
{
  "a(map)": {
    "hello world": "hello"
  },
  "b": {
    "b0": "hey",
    "b1(map)": {
      "hi there": "hi"
    }
  }
}
For large projects with lots of locales, it may be better to specify them in the config file.

# Config
maps: # Applies to all locales!
  - a
  - b.b1
Now you can access the translations via keys:

String a = t.a['hello world']; // "hello"
String b = t.b.b0; // "hey"
String c = t.b.b1['hi there']; // "hi"
➤ Dynamic Keys / Flat Map 

A more general solution to Maps. ALL translations are accessible via an one-dimensional map.

It is supported out of the box. No configuration needed.

This can be disabled globally by setting flat_map: false.

String a = t['myPath.anotherPath'];
String b = t['myPath.anotherPath.3']; // with index for arrays
String c = t['myPath.anotherPath'](name: 'Tom'); // with arguments
➤ Changing Locale 

If you use the built-in LocaleSettings solution, then it is quite easy to change the locale.

Method	Description	Platform
LocaleSettings.setLocale	Set locale (type-safe)	Dart, Flutter
LocaleSettings.setLocaleRaw	Set locale (via string)	Dart, Flutter
LocaleSettings.useDeviceLocale	Set to device locale and listen to it	Flutter only
The TranslationProvider listens to locale changes from the device. So if the user leaves the app and changes the locale in the system settings, then the app locale will be updated too.

LocaleSettings.useDeviceLocale will enable the listener.
LocaleSettings.setLocale and LocaleSettings.setLocaleRaw will disable the listener by default.
Widgets rebuild only if you use final t = Translations.of(context) or context.t.

Complex Features 

➤ Linked Translations 

You can link one translation to another. Add the prefix @: followed by the absolute path of the desired translation.

{
  "fields": {
    "name": "my name is {firstName}",
    "age": "I am {age} years old"
  },
  "introduce": "Hello, @:fields.name and @:fields.age"
}
String s = t.introduce(firstName: 'Tom', age: 27); // Hello, my name is Tom and I am 27 years old.
If namespaces are used, then it has to be specified in the path too.

RichTexts can also contain links! But only RichTexts can link to RichTexts.

Optionally, you can escape linked translations by surrounding the path with {}:

{
  "fields": {
    "name": "my name is {firstName}"
  },
  "introduce": "Hello, @:{fields.name}inator"
}
➤ Pluralization 

This library uses the concept defined here.

Some languages have support out of the box. See here.

Plurals are detected by the following keywords: zero, one, two, few, many, other.

// File: strings.i18n.json
{
  "someKey": {
    "apple": {
      "one": "I have $n apple.",
      "other": "I have $n apples."
    }
  }
}
String a = t.someKey.apple(n: 1); // I have 1 apple.
String b = t.someKey.apple(n: 2); // I have 2 apples.
The detected plurals are cardinals by default.

To specify ordinals, you need to add the (ordinal) modifier.

// File: strings.i18n.json
{
  "someKey": {
    "apple(cardinal)": {
      // cardinal
      "one": "I have $n apple.",
      "other": "I have $n apples."
    },
    "place(ordinal)": {
      // ordinal (rarely used)
      "one": "${n}st place.",
      "two": "${n}nd place.",
      "few": "${n}rd place.",
      "other": "${n}th place."
    }
  }
}
You can also specify all plural forms in the global config.

# Config
pluralization: # Applies to all locales!
  auto: off
  cardinal:
    - someKey.apple
  ordinal:
    - someKey.place
In case your language is not supported, you must provide a custom pluralization resolver:

// add this before you call the pluralization strings. Otherwise an exception will be thrown.
// you don't need to specify both
LocaleSettings.setPluralResolver(
  locale: AppLocale.en,
  cardinalResolver: (n, {zero, one, two, few, many, other}) {
    if (n == 0)
      return zero ?? other!;
    if (n == 1)
      return one ?? other!;
    return other!;
  },
  ordinalResolver: (n, {zero, one, two, few, many, other}) {
    if (n % 10 == 1 && n % 100 != 11)
      return one ?? other!;
    if (n % 10 == 2 && n % 100 != 12)
      return two ?? other!;
    if (n % 10 == 3 && n % 100 != 13)
      return few ?? other!;
    return other!;
  },
);
By default, the parameter name is n. You can change that by adding the param modifier.

{
  "someKey": {
    "apple(param=appleCount)": {
      "one": "I have one apple.",
      "other": "I have multiple apples."
    }
  }
}
String a = t.someKey.apple(appleCount: 2); // notice 'appleCount' instead of 'n'
You can set the default parameter globally via pluralization/default_parameter.

➤ Custom Contexts / Enums 

You can utilize custom contexts to differentiate between male and female forms (or other enums).

// File: strings.i18n.json
{
  "greet(context=GenderContext)": {
    "male": "Hello Mr $name",
    "female": "Hello Ms $name"
  }
}
The following enum will be generated for you:

enum GenderContext {
  male,
  female,
}
So you can use it like this:

String a = t.greet(name: 'Maria', context: GenderContext.female);
In contrast to pluralization, you must provide all forms. Collapse it to save space.

{
  "greet(context=GenderContext)": {
    "male,female": "Hello $name"
  }
}
Similarly to plurals, the parameter name is context by default. You can change that by adding the param modifier.

{
  "greet(context=GenderContext, param=gender)": {
    "male": "Hello Mr",
    "female": "Hello Ms"
  }
}
String a = t.greet(gender: GenderContext.female); // notice 'gender' instead of 'context'
... or set it globally:

# Config
contexts:
  GenderContext:
    default_parameter: gender # by default: "context"
You already have an existing enum? Import it instead!

# Config
imports:
  - 'package:my_package/path_to_enum.dart' # define where your enum is
contexts:
  UserType:
    generate_enum: false # turn off enum generation
There is also a global generate_enum option that applies to all contexts.

# Config
imports:
  - 'package:my_package/path_to_enum.dart' # define where your enum is
generate_enum: false # turn off enum generation for all contexts
➤ Typed Parameters 

Parameters are typed as Object by default. This is handy because it offers maximum flexibility.

You can specify the type using the name: type syntax to increase type safety.

{
  "greet": "Hello {name: String}, you are {age: int} years old"
}
➤ L10n 

To properly display numbers and dates, Slang extends the Typed Parameters feature to support additional types like currency, decimalPattern, or jm.

Internally, it uses the NumberFormat and DateFormat from intl.

{
  "greet": "Hello {name: String}, you have {amount: currency} in your account",
  "today": "Today is {date: yMd}"
}
There are several built-in types:

Long	Short	Example 1	Example 2
NumberFormat.compact	compact	1.2M	1,2 M
NumberFormat.compactCurrency	compactCurrency	$1.2M	1,2M €
NumberFormat.compactSimpleCurrency	compactSimpleCurrency	$1.2M	1,2M €
NumberFormat.compactLong	compactLong	1.2 million	1,2 million
NumberFormat.currency	currency	$1.23	1,23 €
NumberFormat.decimalPattern	decimalPattern	1,234.56	1.234,56
NumberFormat.decimalPatternDigits	decimalPatternDigits	1,234.56	1.234,56
NumberFormat.decimalPercentPattern	decimalPercentPattern	12.34%	12,34%
NumberFormat.percentPattern	percentPattern	12.34%	12,34%
NumberFormat.scientificPattern	scientificPattern	1.23E6	1,23E6
NumberFormat.simpleCurrency	simpleCurrency	$1.23	1,23 €
DateFormat.yM	yM	2023-12	12/2023
DateFormat.yMd	yMd	2023-12-31	12/31/2023
DateFormat.Hm	Hm	14:30	14:30
DateFormat.Hms	Hms	14:30:15	14:30:15
DateFormat.jm	jm	2:30 PM	14:30
DateFormat.jms	jms	2:30:15 PM	14:30:15
You can also provide custom formats:

{
  "today": "Today is {date: DateFormat('yyyy-MM-dd')}",
  "number": "The number is {number: NumberFormat('###,###.##')}"
}
Or adjust built-in formats:

{
  "price": "It costs {price: currency(symbol: 'EUR')}"
}
To avoid repetition, you can define custom types via @@types. Please note that the types are locale-specific. If you use namespaces, all definitions are merged.

{
  "@@types": {
    "price": "currency(symbol: 'USD')",
    "dateOnly": "DateFormat('MM/dd/yyyy')"
  },
  "account": "You have {amount: price} in your account",
  "today": "Today is {today: dateOnly}",
  "tomorrow": "Tomorrow is {tomorrow: dateOnly}"
}
String a = t.account(amount: 1234.56); // You have $1,234.56 in your account
String b = t.today(today: DateTime(2023, 3, 2)); // Today is 03/02/2023
String c = t.tomorrow(tomorrow: DateTime(2023, 3, 5)); // Tomorrow is 03/05/2023
➤ Interfaces 

Often, multiple objects have the same attributes. You can create a common super class for that.

Add the (interface=<Interface Name>) to the container node.

{
  "onboarding": {
    "whatsNew(interface=ChangeData)": {
      "v2": {
        "title": "New in 2.0",
        "rows": [
          "Add sync"
        ]
      },
      "v3": {
        "title": "New in 3.0",
        "rows": [
          "New game modes",
          "And a lot more!"
        ]
      }
    }
  }
}
Alternatively, you can specify them in the global config:

# Config
interfaces:
  ChangeData: onboarding.whatsNew.*
The following mixin will be generated automatically for you:

mixin ChangeData {
  String get title;
  List<String> get rows;
}
Now you can access these fields using polymorphism:

// before: without interfaces
void myOldFunction(dynamic changes) {
  final rows = changes.rows as List<String>; // Not type-safe! Prone to typos!
}

// after: using interfaces
void myFunction(ChangeData changes) {
  final rows = changes.rows; // Type-safe! Inferred as List<String>
}

void main() {
  myFunction(t.onboarding.whatsNew.v2);
  myFunction(t.onboarding.whatsNew.v3);
}
You can customize the attributes and use different node selectors.

Checkout the full article.

➤ Modifiers 

There are several modifiers for further adjustments.

You can combine multiple modifiers with commas like this:

{
  "apple(plural, param=appleCount, rich)": {
    "one": "I have $appleCount apple.",
    "other": "I have $appleCount apples."
  }
}
Available Modifiers:

Modifier	Meaning	Applicable for
(rich)	This is a rich text.	Leaves, Maps (Plural / Context)
(map)	This is a map / dictionary (and not a class).	Maps
(fallback)	Should fallback. (map) required.	Maps
(plural)	This is a plural (type: cardinal)	Maps
(cardinal)	This is a plural (type: cardinal)	Maps
(ordinal)	This is a plural (type: ordinal)	Maps
(context=<Context Type>)	This is a context of type <Context Type>	Maps
(param=<Param Name>)	This has the parameter <Param Name>	Maps (Plural / Context)
(interface=<I>)	Container of interfaces of type I	Map/List containing Maps
(singleInterface=<I>)	This is an interface of type I	Maps
Analysis Modifiers (only used for the analysis tool):

Modifier	Meaning	Applicable for
(ignoreMissing)	Ignore missing translations during analysis	All nodes
(ignoreUnused)	Ignore unused translations during analysis	All nodes
(OUTDATED)	Flagged as outdated for secondary locales	All nodes
➤ Locale Enum 

Typesafety is one of the main advantages of this library. No typos. Enjoy exhausted switch-cases!

// this enum is generated automatically for you
enum AppLocale {
  en,
  fr,
  zhCn,
}
// extension methods
Locale locale = AppLocale.en.flutterLocale; // to native flutter locale
String tag = AppLocale.en.languageTag; // to string tag (e.g. en-US)
final t = AppLocale.en.translations; // get translations of one locale
➤ Locale Stream 

You may want to track locale changes. Please use LocaleSettings.getLocaleStream.

LocaleSettings.getLocaleStream().listen((event) {
  print('locale changed: $event');
});
➤ Translation Overrides 

You may want to update translations dynamically (e.g. via backend server over network).

Set the following configuration:

# Config
translation_overrides: true
Example:

// override
LocaleSettings.overrideTranslations(
  locale: AppLocale.en,
  fileType: FileType.yaml,
  content: r'''
onboarding
  title: 'Welcome {name}'
  ''',
);

// access
String a = t.onboarding.title(name: 'Tom'); // "Welcome Tom"
A few remarks:

The overrides can be partial. Only the specified translations will be updated.
Overriding a second time reverts the last override.
New translations will be parsed but have no effect.
New parameters stay unparsed. (i.e. {name} stays {name})
If you use dependency injection, then you can create a new overridden instance using AppLocaleUtils:

Translations t2 = AppLocaleUtils.buildWithOverridesSync(
  locale: AppLocale.en,
  fileType: FileType.yaml,
  content: r'''
onboarding
  title: 'Welcome {name}'
  ''',
);

String a = t2.onboarding.title(name: 'Tom'); // "Welcome Tom"
➤ Dependency Injection 

You don't like the included LocaleSettings solution?

Then you can use your own dependency injection solution!

Just create custom translation instances that don't depend on LocaleSettings or any other side effects.

First, set the following configuration:

# Config
locale_handling: false # remove unused t variable, LocaleSettings, etc.
translation_class_visibility: public
Example using the riverpod library:

final english = AppLocale.en.buildSync();
final german = AppLocale.de.buildSync();
final translationProvider = StateProvider<Translations>((ref) => german); // set it

// access the current instance
final t = ref.watch(translationProvider);
String a = t.welcome.title; // get translation
AppLocale locale = t.$meta.locale; // get locale
Checkout the full article.

Structuring Features 

➤ Namespaces 

You can split the translations into multiple files. Each file represents a namespace.

This feature is disabled by default for single-file usage. You must enable it.

# Config
namespaces: true # enable this feature
output_directory: lib/i18n # optional
output_file_name: translations.g.dart # set file name (mandatory)
Let's create two namespaces called widgets and errorDialogs. Please use camel case for multiple words.

<namespace>_<locale>.<extension>
i18n/
 └── widgets_en.i18n.json
 └── widgets_fr.i18n.json
 └── errorDialogs_en.i18n.json <-- camel case for multiple words
 └── errorDialogs_fr.i18n.json
You can also use different folders. The namespace is only dependent on the file name!

i18n/
 └── widgets/
      └── widgets.i18n.json
      └── widgets_fr.i18n.json
 └── errorDialogs/
      └── errorDialogs.i18n.json
      └── errorDialogs_fr.i18n.json
i18n/
 └── en/
      └── widgets.i18n.json
      └── error_dialogs.i18n.json
 └── fr/
      └── widgets-fr.i18n.json
      └── error_dialogs.i18n.json <-- directory locale will be used
If you use directory locales, then you may use underscores as namespace.

Now access the translations:

// t.<namespace>.<path>
String a = t.widgets.welcomeCard.title;
String b = t.errorDialogs.login.wrongPassword;
➤ Compact CSV 

Normally, you would create a new csv file for each locale: strings.i18n.csv, strings_fr.i18n.csv, etc.

You can also merge multiple locales into one single csv file! To do this, you need at least 3 columns. The first row contains the locale names. This library should detect that, so no configuration is needed.

Comments are supported. (see Comments)

     ,locale_0 ,locale_1 , ... ,locale_n
key_0,string_00,string_01, ... ,string_0n
key_1,string_10,string_11, ... ,string_1n
...
key_m,string_m0,string_m1, ... ,string_mn
Example:

key,en,de-DE
welcome.title,Welcome $name,Willkommen $name
welcome.button,Start,Start
assets/
 └── i18n/
      └── strings.i18n.csv <-- contains all locales
Other Features 

➤ Fallback 

By default, you must provide all translations for all locales. Otherwise, you cannot compile it.

In case of rapid development, you can turn off this feature. Missing translations will fall back to base locale.

The following configurations are available:

Fallback Strategy	Description
none	Don't fallback (default).
base_locale	Fallback to the base locale.
base_locale_empty_string	Fallback to the base locale. Also treat empty strings as missing.
# Config
base_locale: en
fallback_strategy: base_locale # add this
// English
{
  "hello": "Hello",
  "bye": "Bye"
}
// French
{
  "hello": "Salut",
  // "bye" is missing, fallback to English version
}
By default, entries inside (map) are not affected by the fallback strategy. This allows you to provide different map entries for each locale. To still apply the fallback strategy to maps, add the (fallback) modifier.

{
  "myMap(map, fallback)": {
    "someKey": "Some value",
    // missing keys will fallback to the base locale
  }
}
➤ Lazy Loading 

By default, translations for secondary locales are loaded lazily if Deferred loading is supported (Web).

This reduces the initial startup time.

Disable this feature by setting lazy: false. In this case, all locales are available immediately.

# Config
lazy: false
➤ Comments 

You can add comments in your translation files.

JSON

All keys starting with @ will be ignored.

If a @key key matches an existing key, then its value will be rendered as a comment.

{
  "@@locale": "en", // fully ignored
  "mainScreen": {
    "button": "Submit",

    // ignored as translation but rendered as a comment
    "@button": "The submit button shown at the bottom",

    // ARB style is also possible, the description will be rendered as a comment
    "@button2": {
      "context": "HomePage",
      "description": "The submit button shown at the bottom"
    },
  }
}
YAML

Currently, not parsed and no comments will be generated.

mainScreen:
  button: Submit # The submit button shown at the bottom
CSV

Columns with parentheses like (my_column) are ignored.

Values in the first column with parentheses will be rendered as a comment.

key,(comment),en,de,(ignored comment)
mainScreen.button,The submit button shown at the bottom,Submit,Bestätigen,fully ignored
mainScreen.content,,Content,Inhalt,
Generated File

/// The submit button shown at the bottom
String get button => 'Submit';
➤ Auto Generated Comments 

Besides the custom comments you provide, Slang will also generate comments (documentation) for you.

By default, it will only generate comments for the base locale.

/// en: 'An English Title'
String get title => 'An English Title';
You can configure this feature under autodoc.

# Config
autodoc:
  enabled: true # enable this feature
  locales: # only generate comments for these locales
    - en 
    - de
➤ Recasing 

By default, no transformations will be applied.

You can change that by specifying key_case, key_map_case or param_case.

Possible cases are: camel, snake and pascal.

{
  "must_be_camel_case": "The parameter is in {snakeCase}",
  "my_map(map)": {
    "this_should_be_in_pascal": "hi"
  }
}
# Config
key_case: camel
key_map_case: pascal
param_case: snake
String a = t.mustBeCamelCase(snake_case: 'nice');
String b = t.myMap['ThisShouldBeInPascal'];
If you specify paths in the config, please case them correctly:

# Config
key_case: camel
maps:
   - myMap # all paths must be cased accordingly
➤ Sanitization 

All keys must be valid Dart identifiers. Slang will automatically sanitize them.

By default, the prefix k is added if the key is one of the reserved words or starts with a number.

As always, you can configure this behavior.

# Config
sanitization:
  enabled: true
  prefix: k
  case: camel
Now the following key:

{
  "continue": "Continue"
}
will be sanitized to:

String get kContinue => 'Continue';
Note: Sanitization is happening before resolving Linked Translations. Therefore, you need to use the sanitized key (e.g. @:kContinue).

➤ Obfuscation 

Obfuscate the translation strings to make reverse engineering harder.

You should also enable Flutter obfuscation for additional security.

# Config
obfuscation:
  enabled: true
  secret: somekey # set this if you want deterministic obfuscation
That's all. Everything should work like before.

Now, instead of this:

String get hello => 'Hello';
The following will be generated:

String get hello => _root.$meta.d([104, 69, 76, 76, 79]);
The secret key itself is hidden in the generated code.

XOR is used for encryption to keep your app (nearly) as fast as before.

Keep in mind that this only prevents simple string searches of the binary.

An experienced reverse engineer can still find the strings given enough time.

➤ Formatting 

The generated code is not formatted by default to keep the algorithm fast and efficient.

You can enable it:

# Config
format:
  enabled: true
  width: 150 # optional
➤ Dart Only 

You can use this library without flutter.

# pubspec.yaml
dependencies:
  slang: <version>
# Config
flutter_integration: false # set this
Tools 

➤ Main Command 

The main command to generate dart files from translation resources.

dart run slang
➤ Update configuration 

If you have many locales, it might be frustrating to keep CFBundleLocalizations (for iOS and macOS) up to date.

This command will care about all configuration files for you.

dart run slang configure [--source-dirs=dir1,dir2]
Argument	Usage
--source-dirs=<dirs>	Comma-separated list of source directories to search in
You can also specify additional arguments, for example to set the source directories:

dart run slang configure --source-dirs=dir1,dir2
➤ Analyze Translations 

You can use the slang analyzer to find missing and unused translations.

Missing translations only occur when fallback_strategy: base_locale is used.

dart run slang analyze [--split] [--full] [--outdir=assets/i18n] [--source-dirs=lib,packages]
Argument	Usage
--split	Split analysis for each locale
--split-missing	Split missing translations for each locale
--split-unused	Split unused translations for each locale
--full	Find unused translations in whole source code
--outdir=<dir>	Path of analysis output (input_directory by default)
--exit-if-changed	Exit with code 1 if there are changes (for CI)
--source-dirs=<dirs>	Comma-separated list of source directories (default: lib)
Result file:

{
  "de": {
    "mainScreen": {
      "login": "This translation is missing, showing base translation here"
    }
  },
  "fr": {} // everything ok
}
You can ignore a specific node by adding an (ignoreMissing) or (ignoreUnused) modifier.

➤ Clean Translations 

The follow-up command for analyze. It requires analyze to be run first.

This command essentially removes all unused translations specified in _unused_translations.

dart run slang clean [--outdir=assets/i18n]
Argument	Usage
--outdir=<dir>	Path of analysis output (input_directory by default)
➤ Apply Translations 

The follow-up command for analyze.

It reads the _missing_translations file and adds the translations to the original files.

Currently, only JSON and YAML are supported.

dart run slang apply [--locale=fr-FR] [--outdir=assets/i18n]
Argument	Usage
--locale=<locale>	Apply only one specific locale
--outdir=<dir>	Path of analysis output (input_directory by default)
➤ Edit Translations 

You can use this command to rename, remove, or add translation keys. This is useful when you have many locales, or if you just want to use the command line.

dart run slang edit <type> <params...>
Type	Meaning	Example
add*	Add a translation	dart run slang edit add fr greetings.hello "Bonjour"
move	Move a translation	dart run slang edit move loginPage authPage
copy	Copy a translation	dart run slang edit copy loginPage authPage
delete	Delete a translation	dart run slang edit delete loginPage.title
outdated**	Add outdated flag	dart run slang edit outdated loginPage.title
* Also works without specifying the locale. It will add the translation to all locales.

** See Outdated Translations

➤ Normalize Translations 

To keep the order of the keys consistent, you can normalize the translations. They will follow the same order as the base locale.

dart run slang normalize [--locale=fr-FR]
Argument	Usage
--locale=<locale>	Normalize only one specific locale
➤ Outdated Translations 

You want to update an existing string, but you want to keep the old translations for other locales?

Here, you can run a simple command to flag translations as OUTDATED. They will show up in _missing_translations when running analyze.

dart run slang edit outdated a.b.c

# shorthand
dart run slang outdated a.b.c
This will add an (OUTDATED) modifier to all secondary locales.

{
  "a": {
    "b": {
      "c(OUTDATED)": "This translation is outdated"
    }
  }
}
You can also add these flags manually!

➤ Translate with GPT 

Take advantage of GPT to internationalize your app with context-aware translations.

Import slang_gpt to your dev_dependencies.

Then add the following configuration:

# existing config
base_locale: fr
fallback_strategy: base_locale
input_directory: lib/i18n
input_file_pattern: .i18n.json
output_directory: lib/i18n

# add this
gpt:
  model: gpt-3.5-turbo
  description: |
    "River Adventure" is a game where you need to cross a river by jumping on stones.
    The game is over when you either fall into the water or reach the other side.
➤ Migration 

There are some tools to make migration from other i18n solutions easier.

General migration syntax:

dart run slang migrate <type> <source> <destination>
ARB

Transforms ARB files to compatible JSON format. All descriptions are retained.

dart run slang migrate arb source.arb destination.json
ARB Input

{
  "@@locale": "en_US",
  "@@context": "HomePage",
  "title_bar": "My Cool Home",
  "@title_bar": {
    "type": "text",
    "context": "HomePage",
    "description": "Page title."
  },
  "FOO_123": "Your pending cost is {COST}",
  "foo456": "Hello {0}",
  "pageHomeInboxCount" : "{count, plural, zero{You have no new messages} one{You have 1 new message} other{You have {count} new messages}}",
  "@pageHomeInboxCount" : {
    "placeholders": {
      "count": {}
    }
  }
}
JSON Result

{
  "@@locale": "en_US",
  "@@context": "HomePage",
  "title": {
    "bar": "My Cool Home",
    "@bar": "Page title."
  },
  "foo123": "Your pending cost is {cost}",
  "foo456": "Hello {arg0}",
  "page": {
    "home": {
      "inbox": {
        "count(param=count)": {
          "zero": "You have no new messages",
          "one": "You have 1 new message",
          "other": "You have {count} new messages"
        }
      }
    }
  }
}
➤ Statistics 

There is a command to quickly get the number of words, characters, etc.

dart run slang stats
Example console output:

[en]
 - 9 keys (including intermediate keys)
 - 6 translations (leaves only)
 - 15 words
 - 82 characters (ex. [,.?!'¿¡])
➤ Auto Rebuild 

You can let the library rebuild automatically for you. The watch function from build_runner is NOT maintained.

dart run slang watch
More Usages 

➤ Assets 

You can write the i18n files wherever you want.

Specify input_directory and output_directory in build.yaml.

targets:
  $default:
    sources:
      - "custom-directory/**" # optional; only assets/* and lib/* are scanned by build_runner
    builders:
      slang_build_runner:
        options:
          input_directory: assets/i18n
          output_directory: lib/i18n # defaulting to lib/gen if input is outside of lib/
... or in slang.yaml:

input_directory: assets/i18n
output_directory: lib/i18n # defaulting to lib/gen if input is outside of lib/
➤ Unit Tests 

It is recommended to add at least one test that accesses the translations to make sure that they are compiled correctly.

Because slang is type-safe, this test is most likely enough to ensure that the translations are working.

You can also check if all locales are supported by Flutter.

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_app/gen/strings.g.dart';
import 'package:test/test.dart';

void main() {
  group('i18n', () {
    test('Should compile', () {
      // The following test will fail if the i18n file is either not compiled
      // or there are compile-time errors.
      expect(AppLocale.en.build().aboutPage.title, 'About');
    });

    test('All locales should be supported by Flutter', () {
      for (final locale in AppLocale.values) {
        // This will fail if the locale is not supported by Flutter
        expect(kMaterialSupportedLanguages, contains(locale.languageCode));
      }
    });
  });
}
➤ Multiple packages 

You can have multiple slang instances spread across multiple packages.

This might be useful if you want to share translations between multiple apps.

Slang will automatically synchronize the locales between all packages if you use LocaleSettings.setLocale.

import 'package:my_package1/gen/strings.g.dart' as package1;
import 'package:my_package2/gen/strings.g.dart' as package2;

void main() {
  final t1 = package1.Translations.of(context);
  final t2 = package2.Translations.of(context);

  // this changes the locale for all packages to Spanish
  package1.LocaleSettings.setLocale(AppLocale.es);
  
  String spanishTitle = t2.title; // this will be in Spanish
  
  // this changes the locale for all packages to English
  package2.LocaleSettings.setLocale(AppLocale.en);
  
  String englishTitle = t1.title; // this will be in English
}
To still have auto rebuild on locale change, you need to wrap all the generated TranslationProvider widgets.

import 'package:my_package1/gen/strings.g.dart' as package1;
import 'package:my_package2/gen/strings.g.dart' as package2;

void main() {
  final widget = package1.TranslationProvider(
    child: package2.TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            final t1 = package1.Translations.of(context);
            final t2 = package2.Translations.of(context);
            return Column(
              children: [
                Text(t1.title),
                Text(t2.title),
              ],
            );
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // this changes the locale for all packages
              // does not matter which package you call it on
              package1.LocaleSettings.setLocale(AppLocale.en);
            },
          ),
        ),
      ),
    ),
  );
  
  runApp(widget);
}
Integrations 

➤ slang x riverpod 

Method A: Use static getter

Access translation variable t directly, use LocaleSettings.setLocale to change locales.

Track locale changes with LocaleSettings.getLocaleStream():

final localeProvider = StreamProvider((ref) => LocaleSettings.getLocaleStream());
Method B: Use dependency injection

Checkout Dependency Injection.

➤ slang x Weblate 

Weblate is a web-based translation tool with tight Git integration.

Below are recommended settings and addons for a smooth integration.

settings

addons

FAQ 

Translations don't update when device locale changes

By default, this library does not listen to locale changes from device.

To enable this, either use LocaleSettings.useDeviceLocale or set listenToDeviceLocale: true when changing the locale.

Additionally, wrap your app with TranslationProvider and get the translations via final t = Translations.of(context).

CSV files are not parsed correctly

Note that translated EOL should be written as \n.

CORRECT:

my.path,hello\nworld
WRONG:

my.path,hello<LF>
world
Can I prevent the timestamp Built on from updating?

No, but you can disable the timestamp altogether. Set timestamp: false in build.yaml.

Why setLocale doesn't work?

In most cases, you forgot the setState call.

A more elegant solution is to use TranslationProvider(child: MyApp()) and then get your translation variable with final t = Translations.of(context). It will automatically trigger a rebuild on setLocale for all affected widgets.

My plural resolver is not specified?

An exception is thrown by _missingPluralResolver because you missed to add LocaleSettings.setPluralResolver for the specific language.

See Pluralization.

How does plural / context detection work?

You can let the library detect plurals or contexts.

For plurals, it checks if any json node has zero, one, two, few, many or other as children.

As soon as an unknown item has been detected, then this json node is not a pluralization.

{
  "fake": {
    "one": "One apple",
    "two": "Two apples",
    "three": "Three apples" // unknown key word 'three', 'fake' is not a pluralization
  }
}
For contexts, all enum values must exist.

How can I use multiple plurals in one sentence?

You may use linked translations to solve this problem.

{
  "apples(param=appleCount)": {
    "one": "one apple",
    "other": "{appleCount} apples"
  },
  "bananas(param=bananaCount)": {
    "one": "one banana",
    "other": "{bananaCount} bananas"
  },
  "sentence": "I have @:apples and @:bananas"
}
String a = t.sentence(appleCount: 1, bananaCount: 2); // two different plural parameters!
What's the difference between AppLocale.en.translations and AppLocale.en.build()?

The plural resolvers of AppLocale.<locale>.translations must be set via LocaleSettings.setPluralResolver. Therefore, calls on LocaleSettings has side effects on AppLocale.<locale>.translations.

When you call AppLocale.<locale>.build(), there are no side effects.

Furthermore, the first method returns the instance managed by this library. The second one always returns a new instance.

Further Reading 

In Depth 

Interfaces
Dependency Injection
Tutorials 

Blogs

Medium (English)
Medium (English)
Medium (Turkish)
Хабр (Russian)
Qiita (Japanese)
okaryo (Japanese)
zenn (Japanese)
zenn (Japanese)
zenn (Japanese)
Videos

Youtube (Korean)
Youtube (Spanish)
Zhihu (Chinese)
Feel free to extend this list :)

Ecosystem 

slang_gpt - Use GPT to internationalize your app with context-aware translations.
SlangMate - IntelliJ IDEA / Android Studio plugin for Slang.
Apparencekit - Boilerplate solution
Slang in production 

Open source:

LocalSend (file sharing app)
ReVanced
Hiddify
Saber (notes app)
Boorusphere (booru viewer)
Alist Helper
Digitale Ehrenamtskarte (German volunteer app)
Grüne App (German political app)
OllamaTalk (Ollama Frontend)
Flutter Advanced Boilerplate (boilerplate project)
Closed source:

Notan (grade calculator)
Feel free to extend this list :)

Slang ports 

Slang is also available for other platforms:

Slang for .NET
License 

MIT License

Copyright (c) 2020-2025 Tien Do Nam

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
665
LIKES
160
POINTS
83.8k
DOWNLOADS
screenshot

Publisher
verified publishertienisto.com

Weekly Downloads
2024.09.08 - 2025.08.03
Metadata
Localization / Internationalization (i18n) solution. Use JSON, YAML, CSV, or ARB files to create typesafe translations via source generation.

Repository (GitHub)
Contributing

Topics
#i18n #l10n #localization #translation

Documentation
API reference

Funding
Consider supporting this project:

github.com

License
MIT (license)

Dependencies
collection, csv, intl, watcher, yaml

More
Packages that depend on slang

Dart languageReport packagePolicyTermsAPI TermsSecurityPrivacyHelpRSSbug report
