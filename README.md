# reMath

![enter image description here](https://user-images.githubusercontent.com/37389491/122314594-f9f16680-cf07-11eb-95e8-1548c2705c1f.png)

Hi, this is **reMath**, a flutter package that provide handy functions to help in gesture animations and other calculations. *this is inspired by the react-native reanimated package*. Thanks to software mansion for [react-native reanimated](https://github.com/software-mansion/react-native-reanimated) 


## Operators and helpers
```dart
    abs(node); //Evaluates the given node and returns an absolute value of the node's value.
    add(num1, num2) // Takes two or more animated nodes or values, and when evaluated, returns their sum.
    ceil(num); //Returns a node that rounds a number up to its nearest integer. If the passed argument is an integer, the value will not be rounded.
    divide(num, num2); //Takes two or more animated nodes or values, and when evaluated, returns the result of dividing their values in the exact order.
    exp(node); // Returns an exponent of the value of the given node.
    floor(node); // Returns a node that rounds a number down to its nearest integer. If the passed argument is an integer, the value will not be rounded.
    max(num1, num2); // Takes two nodes as an input and returns a maximum of all the node's values.
    multiply(num1, num2) // Takes two or more animated nodes or values, and when evaluated, returns the result of multiplying their values in the exact order.
```
## conditional operation

```dart
    cond(condition, ifNode,  [elseNode]);
```
If `condition` evaluates to "truthy" value the node evaluates `ifNode` node and returns its value, otherwise it evaluates `elseNode` and returns its value. `elseNode` is optional.

## interpolations
```dart
    interpolate(node,  {
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
    Extrapolate.EXTEND;  // Will extend the range linearly.
    Extrapolate.CLAMP;  // Will clamp the input value to the range.
    Extrapolate.IDENTITY;  // Will return the input value if the input value is out of range.
```

**Usage**

```dart
    var value = interpolate(0.4,{ inputRange: [0,  1], outputRange: [0,  360] }),
```
## interlation of colors
```dart
    interpolateColors(node,  {
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

**example**
 ```dart   
    const color =  interpolateColors(0.3,  {
	    inputRange:  [0,  1],
	    outputColorRange:  [Colors.red,  Colors.blue],
    });
```
