![Reaths banner](https://user-images.githubusercontent.com/37389491/122314594-f9f16680-cf07-11eb-95e8-1548c2705c1f.png)

# Remaths

remaths is a flutter package that makes animations and other calculations easier to use. This package is heavily **inspired** by the react-native reanimated package.

## `Tweeenable`

`Tweeenables` are one of the fundamentals of the `remaths` package. `Tweeenable` carries `Tweeenable` data. This data can be animated with timing or spring. `Tweeenable` uses the default flutter `AnimationController` under the hood to render animations performantly. Before we start animating with `Tweeenable` lets look at Tweeenable Functions

### Tweeenable Functions
Tweeenable functions are used to animate `Tweeenable` values. 
#### withSpring

Starts a spring animation on the `Tweeenable` value.
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
| tovalue * | required | the destination of the animation |
| duraion   | 300      | the duration in `milliseconds` |
| damping   | 20       | spring damping|
| stiffness | 180.0    | stiffness|
| mass      | 1.0      | mass|
| velocity  | 0.0      | velocity|
| delay     | 0.0      | duration in `milliseconds` the animation will delay defore starting |
| onComplere| null     | function called after the animation is complete |

#### withTiming
Start a timing animation in the `Tweeenable` value

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
| tovalue * | required | the destination of the animation |
| duraion   | 300      | the duration in `milliseconds` |
| curve     | Curves.easeIn| the curve of the animation |
| delay     | 0.0      | duration in `milliseconds` the animation will delay defore starting |
| onComplere| null     | function called after the animation is complete |
#### withSequence
Run list of animations sequentially.
```dart
 x = withSequence([withTiming(...),6.0,withSpring(...),])
```
`wihSequence` takes a list of Tweeenable Functions or a `double` and run them sequencially.
When a `double` is provided, the value is set to that destination without any animation.

## Working with Tweeenables
Lets take `Tweeenable` as a double value that can be animated with Tweeenable Functions.
```dart
var x = Tweeenable(double value, vsync: this);
```

| Params   | default  | description |
| -------- | -------  | ------------|
| value    | required | the animation position |
| vsync    | requied  | `TickerProvider` |

You have to use your stateful object as the `vsync` by adding `SingleTickerProviderStateMixin` or `TickerProviderStateMixin` to the class definition

Animations can be done on `Tweeenable` by seting the `Tweeenable` value to an animated function

Example
```dart
x = withTiming(...)
x = withSpring(...)
x = withSequence(...)
x = 45.0 // no animations done here

```
**Note**: if a `double` value to seted with the `Tweeenable`, no animation is triggered. The value is just jumped the destination.


