# remaths

![the header image](https://user-images.githubusercontent.com/37389491/122314594-f9f16680-cf07-11eb-95e8-1548c2705c1f.png)



Hi, this is **reMath**, a flutter package that provide handy functions to help in gesture animations and other calculations. *this is inspired by the [react-native reanimated](https://github.com/software-mansion/react-native-reanimated) package*.



## Examples

View the code in the `/example` folder

![Example Application](https://user-images.githubusercontent.com/37389491/123014643-37e20500-d3b6-11eb-95d2-dafec66b73f6.gif)



# Interpolations

Maps an input value within a range to an output value within a range. Also supports different types of extrapolation for when the value falls outside the range and mapping to strings.

```dart
interpolate(value,  {
    // Input range for the interpolation. Should be monotonically increasing.
    inputRange:  [value...],
    // Output range for the interpolation, should be the same length as the input range.
    outputRange:  [value...],
    // Sets the left and right extrapolate modes.
    extrapolate?:  Extrapolate.EXTEND  |  Extrapolate.CLAMP  |  Extrapolate.IDENTITY,
    // Set the left extrapolate mode, the behavior if the input is less than the first value in inputRange.
    extrapolateLeft?:  Extrapolate.EXTEND  |  Extrapolate.CLAMP  |  Extrapolate.IDENTITY,
    // Set the right extrapolate mode, the behavior if the input is greater than the last value in inputRange.
    extrapolateRight?:  Extrapolate.EXTEND  |  Extrapolate.CLAMP  |  Extrapolate.IDENTITY,
 })
```

#### Extrapolate Enum

```dart
Extrapolate.EXTEND;  // Will extend the range linearly.
Extrapolate.CLAMP;  // Will clamp the input value to the range.
Extrapolate.IDENTITY;  // Will return the input value if the input value is out of range.
```

#### Usage

```dart
var value = interpolate(0.5,{ inputRange: [0,  1], outputRange: [10,  0] }), // returns 5
```



# Color Interpolation

Maps an input value within a range to an output value within a color range.

```dart
    interpolateColors(value,  {
    // Input range for the interpolation. Should be monotonically increasing.
    inputRange:  [value,  ...],
    // Output colors range for the interpolation.
    // Should be the same length as the input range.
    //
    // Each color should be a of type Color
    // or a number like Colors.red or Color(0xff112233).
    outputColorRange:  [Color,  ...],
    })
```

#### Usage

 ```dart   
 const color =  interpolateColors(0.3,  {
   inputRange:  [0,  1],
   outputColorRange:  [Colors.red,  Colors.blue],
 });
 ```



# Animations

The `remaths` package provides helpful function to help run animations easily



### `AnimatedValue`

creates a `ValueNotifier` to listen to animations

**Usage:**

```dart
x = AnimatedValue(200, vsyc: this); // where 200 is the inital value
```

##### Updating the `AnimatedValue`

changing the value of the `AnimatedValue` 

```dart
x.value = newValue
```



### Animating the `value`

we have two types of animations you can run with the `AnimatedValue`

#### Timing Animation

Starts a time based animation.

```dart
x.withTiming(toValue, duration: duration, curve: curve);
```

##### Arguments

`toValue`: [num]

The target value at which the animation should conclude

***Named arguments***

| Options  | Default                     | Description                                          |
| :------- | --------------------------- | ---------------------------------------------------- |
| duration | Duration(milliseconds: 300) | How long the animation should last                   |
| curve    | Curves.easeIn               | Curve that drives the easing curve for the animation |

#### Spring Animation

Starts a spring-based animation.

##### Arguments

`toValue`: [num]

the target value at which the spring should settle*

***Named arguments***

| Options   | Default                     | Description                        |
| --------- | --------------------------- | ---------------------------------- |
| duration  | Duration(milliseconds: 300) | How long the animation should last |
| damping   | 20                          |                                    |
| stiffness | 180                         |                                    |
| mass      | 1                           |                                    |
| velocity  | 0.0                         |                                    |



## Helpers

Animating two or more `AnimatedValue` with the same `timing` or `spring` configurations seams a little bit of more codes. 

That is where *helper functions* `springAll` and `animateAll` comes in.



##### springAll(...)

runs a time based animation with more than one  `AnimatedValue`

its take  `[values]` and `[destination]` arguments that represents the `AnimatedValue` and where the animation which end *respectively*

```dart
animateAll([x, y],[200, 30], {
    duration:duraion, 
    damping: dumping, 
    mass: mass, 
    velocity: velocity, 
    stiffness: stiffness,
});
```



The code runs a spring animation for `AnimatedValue` *`x`* *to* *`200`* *and* *`y`* *to* *`30`* with the same configurations 

##### animateAll(...)

runs a time time animation with more than one  `AnimatedValue`

its take  `[values]` and `[destination]` arguments that represents the `AnimatedValue` and where the animation which end *respectively*

```dart
animateAll([x, y],[200, 30], {
    duration:duraion,
    curve: curve,
});
```



The code runs a time animation for `AnimatedValue` *`x`* *to* *`200`* *and* *`y`* *to* *`30`* with the same configurations 



## The AnimatedValueBuilder Widget

 *A widget to listen to values of* *`AnimatedValue`* and run the animation smoothly



```dart
AnimatedValueBuilder(
	values: [...AnimatedValue]
    builder: (context, child) => ....
    child: Widget
)
```


## License

Remaths library is licensed under [The MIT License](LICENSE).

## Credits

This project has been build and is maintained thanks to the support from the Ormanel Community