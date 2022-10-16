**Table of Contents**

- [Installation](#installation)
- [Migrating from version 1.x.x](#migrating-from-v1)
- [Basic USAGE](#basic-USAGE)
- [SharedValues](#sharedvalues)
- [Animation Functions](#animation-functions)
  - [withTiming](#withtiming)
  - [withSpring](#withsequence)
  - [withRepeat](#withrepeat)
- [Interpolation](#interpolation)
  - [interpolate](#interpolate)
  - [Color Interpolation](#interpolatecolors)
- [Helpers](#helpers)
- [Other Helper Function](#other-functions)
  - [Logical](#logical-expressions)
  - [Maths](#maths)
  - [`SharedValue` Specific](#sharedvalue-specific)

## Installation

To install in flutter run

```bash
flutter pub add remaths
```

or add `remaths` to your dependencies

```yml
dependencies:
	remaths: ^2.0.0
```

## Migrating from v1

- `Tweenable` are renamed to `SharedValues`

  **OLD**

  ```dart
  opacity = Tweenable(0.0, this);
  // OR
  opacity = 0.asTweenable(this)
  ```

  **NOW**

  ```dart
  opacity = SharedValue(0.0, vsync:this);
  //OR
  opacity = 0.asSharedValue(this);
  // OR
  ```

## Basic USAGE

To start using remaths in your widget, your widget must have be a `Stateful` widget which with `TickerStateProviderMixin`
`SharedValue` s are initialized just like `AnimationControllers`

```dart
late SharedValue opacity;

@override
initState() {
	opacity = SharedValue(0.0, this);
	// OR
	width = 0.0.asSharedValue(this);
}
```

`SharedValue` can use animated with [Animation Functions](#animation-functions)

[See all Animation Functions](#animation-functions)
<br><br>

# SharedValues

## methods

These are some of the common method. For more go to the [API Reference](https://pub.dev/documentation/remaths/latest/remaths/remaths-library.html)

### `withTiming(double toValue)`

animates the value with [timing function](#withtiming)

### `withSpring(double toValue)`

animates the value with [spring function](#withspring)

### `withSequence([])`

run a list of animations

### `interpolate(inputRange,outPutRange ..)`

maps the value from inputRange to outputRange see [interpolations](#interpolate)

### `interpolate(inputRange,outPutRange ..)`

see [color Interpolation](#interpolatecolors)

# Animation Functions

Animation functions are used to drive a `SharedValue` with a specific animation

## withTiming

This is used to run a timing animation on a `SharedValue`

**USAGE**

```dart
opacity.value = withTiming(0.0, duration:100, curve:Curves.easeInOut);
```

### Arguments

| name                  | default                            | description                               |
| --------------------- | ---------------------------------- | ----------------------------------------- |
| `double` toValue\*    | required                           | animation destination                     |
| `int` duration        | 300                                | duration of the animation in milliseconds |
| `Curve` curve         | `Curves.ease`                      | The curve of the animations               |
| `double` from         | current value of the `SharedValue` | the start of the animation                |
| `Function` onComplete | null                               | calls when the animation is complete      |

## withSpring

This is used to animate `SharedValue` with `SpringSimulation`

**USAGE**

```dart
width.value = withSpring(1.0, duration: 500);
```

### Arguments

| name                  | default  | description                               |
| --------------------- | -------- | ----------------------------------------- |
| `double` toValue\*    | required | animation destination                     |
| `int` duration        | 300      | duration of the animation in milliseconds |
| `double` velocity     | 0.0      | spring velocity                           |
| `double` mass         | 1.0      | spring mass                               |
| `double` stiffness    | 180.0    | stiffness                                 |
| `double` damping      | 20.0     | damping                                   |
| `Function` onComplete | null     | calls when the animation is complete      |

## WithSequence

This animation Function is used to run list of animations sequentially, i.e one after the other

**USAGE**

```dart

width = withSequence(
  [withTiming(20), withSpring(40)],
  () => print("animation complete"),
)
```

### Arguments

| name                  | default  | description                          |
| --------------------- | -------- | ------------------------------------ |
| `List` animations\*   | required | list of Animations                   |
| `Function` onComplete | null     | calls when the animation is complete |

## withRepeat

Repeat an animation for some number of times

**USAGE**

```dart
width = withRepeat(withSpring(20.0), reps:3);
```

### Arguments

| name                  | default                            | description                                       |
| --------------------- | ---------------------------------- | ------------------------------------------------- |
| animation\*           | required                           | the animation function to repeat                  |
| `int` reps            | 2                                  | number of times to repeat the animation           |
| `bool` reverse        | false                              | where to reverse the animation on each repetition |
| `double` from         | current value of the `SharedValue` | the start of the animation                        |
| `Function` onComplete | null                               | calls when the animation is complete              |

## withDelay

Delay an animation before running

```dart
// this delays the animation for 300ms before running
opacity.value = withDelay(withTiming(), 300)
```

# Interpolation

There are some helpful interpolation function to help interpolate between values and `Color`s

## interpolate

This is used to map a value from one range to the other.

**USAGE**

```dart
var yOffset = interpolate(opacity, [0,1], [100,0])
```

The code above implies that <br>
When:

| opacity | yOffset |
| ------- | ------- |
| 0       | 100     |
| 0.5     | 50      |
| 1       | 0       |

Read More About Interpolation on [Wikipedia](https://en.wikipedia.org/wiki/Interpolation)

### Arguments

| name             | default              | description                                                     |
| ---------------- | -------------------- | --------------------------------------------------------------- |
| value            | required             | the value to interpolate                                        |
| inputRange       | required             | input range                                                     |
| outputRange      | required             | output range                                                    |
| extrapolate      | `Extrapolate.extend` | used as left extrapolation when rightExtrapolation is available |
| rightExtrapolate | null                 | right extrapolation                                             |

> NOTE: input range must be monotonically increasing

### How extrapolation works

Extrapolation determines how to estimate the output values when the value is out of the range provided but in the `inputRange`.
If the `extrapolate` argument is passed it applies it to the left and right side.
If the `rightExtrapolate` argument is provided the `extrapolate` argument will be applied to the left side the the `rightExtrapolate` is used fot the right side

**Extrapolations**

- `Extrapolate.clamp` clamps the value to the edge of the output range
- `Extrapolate.extend` approximates the value even outside of the range
- `Extrapolate.identity` returns the value that is being interpolated

## interpolateColor

This is used to map a value from range of number to range of colors.

**USAGE**

```dart
Color color = interpolateColor(opacity, [0,1], [Colors.red, Colors.green])
```

## interpolateOffset

This is used to map a value from range of Offsets to range of Offsets.

**USAGE**

```dart
Offset pos = interpolateOffset(_offset_, List<Offset> inputRage, List<Offset> outputRange);
```

# Helpers

Remaths have some amazing helpful functions to put your animation to the next level.

> **NB:** `SharedValue` can be passed directly to helper functions without getting `.value`

Some of these helper functions are:

## cond

**syntax**

```dart
var isOPen = cond(bool condition, ifBlock, [elseBlock])
```

If `condition` evaluates to "truthy" value the node evaluates `ifBlock` node and returns its value, otherwise it evaluates `elseBlock` and returns its value. `elseBlock` is optional.

> Note: `ifBlock` and `elseBlock` can be any value, but id a function is passed, the function is evaluated and return its results

## range

Create a range of numbers
**Syntax**

```dart
List<int> numbers = range(stop, {start, step});
```

## random

Generate a random Number. By default this function generate a number from 0 to 1
**Syntax\***

```dart
List<double> rnd = random([int start = 0, int end=1, int decimal=1]);
```

The `decimal` argument determine the decimal places the the generated number <br>
Example

```dart
random(1,2,2) // may be: 1.64
random(1,2,5) // may be: 1.45345
```

> **NB** By default this function returns a `double`

## clamp

This function lock value to a min and a max value. This function ensures that the value is not less than the min value or greater than the max vale

**Syntax**

```dart
double val = clamp(value,min,max);
```

## diff

returns a difference between value returned at the last time a `SharedValue` was evaluated and its value at the current time. When evaluating for the first time it returns `0`.

**Syntax**

```dart
double d = diff(opacity)
```

## toRad

Convert a value to **radian**

**Syntax**

```dart
var rad = toRad(val)
```

## toDeg

Convert a value to **degrees**

**Syntax**

```dart
var deg = toDeg(val)
```

## lessThan

Check is a value is less than the other

**syntax**

```dart
bool isYoung = lessThan(age, 10);
```

## greaterThan

Check is a value is greater than the other

**syntax**

```dart
bool canVote = greaterThan(age, 18);
```

## eq

Check is two values are equal

**syntax**

```dart
bool hasSameName = greaterThan(john.name, doe.name);
```

## neq

Check is two values are **not** equal

**syntax**

```dart
bool is = greaterThan(, doe.name);
```

## Other Functions

### Logical Expressions

- `lessThan`
- `lessOrEq`
- `greaterThan`
- `greaterOrEq`
- `neq`
- `eq`
- `or`
- `and`
- [cond](#cond)

### Maths

- `add`
- `divide`
- `subtract`
- `multiply`
- `modulo`
- `floor`
- `ceil`
- `round`
- `abs`
- `exp`
- `pow`
- `sqrt`
- `modulo`

### Trigonometry

- `log`
- `sin`
- `cos`
- `tan`
- `atan`
- `acos`
- `asin`

### SharedValue Specific

- `diff`
- `diffClamp`
