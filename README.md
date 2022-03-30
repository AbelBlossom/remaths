![Remaths banner](https://user-images.githubusercontent.com/37389491/122314594-f9f16680-cf07-11eb-95e8-1548c2705c1f.png)

# Remaths

remaths is a flutter package that makes animations and other calculations easier to use. This package is heavily **inspired** by the react-native reanimated package.

## `Tweenable`

`Tweenables` are one of the fundamentals of the `remaths` package. `Tweenable` carries `Tweenable` data. This data can be animated with timing or spring. `Tweenable` uses the default flutter `AnimationController` under the hood to render animations (performable). Before we start animating with `Tweenable` lets look at Tweenable Functions

# Tweenable Functions
Tweenable functions are used to animate `Tweenable` values. 
## withSpring

Starts a spring animation on the `Tweenable` value.
 ```dart
    x = withSpring(toValue, {
    int  duration,
    double  damping,
    double  stiffness,
    double  mass,
    double  velocity,
    int?  delay,
    void  Function()?  onComplete,
    })
```
| Params   | default  | description |
| --------  | -------  | ------------|
| toValue * | required | the destination of the animation |
| duration   | 300      | the duration in `milliseconds` |
| damping   | 20       | spring damping|
| stiffness | 180.0    | stiffness|
| mass      | 1.0      | mass|
| velocity  | 0.0      | velocity|
| delay     | 0.0      | duration in `milliseconds` the animation will delay before starting |
| onComplete| null     | function called after the animation is complete |

## withTiming
Start a timing animation in the `Tweenable` value

```dart
x = withTiming(double toValue, {
    double toValue, {
  int duration = _kDuration,
  Curve curve = Curves.easeIn,
  int? delay,
  void Function()? onComplete,
})
```

| Params   | default  | description |
| --------  | -------  | ------------|
| toValue * | required | the destination of the animation |
| duration   | 300      | the duration in `milliseconds` |
| curve     | Curves.easeIn| the curve of the animation |
| delay     | 0.0      | duration in `milliseconds` the animation will delay before starting |
| onComplete| null     | function called after the animation is complete |
## withSequence
Run list of animations sequentially.
```dart
 x = withSequence([withTiming(...),6.0,withSpring(...),])
```
`wihSequence` takes a list of Tweenable Functions or a `double` and run them sequentially.
When a `double` is provided, the value is set to that destination without any animation.

# Working with Tweenables
Lets take `Tweenable` as a double value that can be animated with Tweenable Functions.
```dart
var x = Tweenable(double value, vsync: this);
```

Tweenables can also be initialized with num extensions
```dart
var x = 12.asTweenable(this);
// In this case 12 is used as an initial value
```

| Params   | default  | description |
| -------- | -------  | ------------|
| value    | required | the animation position |
| vsync    | required  | `TickerProvider` |

You have to use your stateful object as the `vsync` by adding `SingleTickerProviderStateMixin` or `TickerProviderStateMixin` to the class definition

Animations can be done on `Tweenable` by setting the `Tweenable` value to an animated function

When any animation does not end before initializing another animation, the previous animation is stopped and the current animation continues from where the old on stopped to bring a smooth animation experience

Example
```dart
x = withTiming(...)
x = withSpring(...)
x = withSequence(...)
x = 45.0 // no animations done here

```
**Note**: if a `double` value to set with the `Tweenable`, no animation is triggered. The value is just jumped the destination.

# Helper nodes




