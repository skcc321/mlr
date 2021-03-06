# Mlr
multilateration solution based on https://github.com/kamalshadi/Localization python library

![multelateration](https://www.researchgate.net/publication/278915920/figure/fig9/AS:668641087459371@1536427866561/Example-of-a-multilateration-problem-The-grey-area-is-obtained-as-the-intersection-of.png "Multilateration")

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mlr'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mlr

Also you need python libraries

    $ pip install localization
    $ pip install numpy
    $ pip install scipy
    $ pip install shapely

## Usage

### from_points
*detect point from Mlr::AnchorPoint struct*

```ruby

# Mlr::AnchorPoint2D.new(X, Y, D)
# Mlr::AnchorPoint3D.new(X, Y, Z, D)

Mlr.from_points([
  Mlr::AnchorPoint2D.new(0, 100, 50),
  Mlr::AnchorPoint2D.new(100, 100, 50),
  Mlr::AnchorPoint2D.new(100, 0, 50)
])
=> #<struct Mlr::ResultPoint2D x=59.103629855759586, y=59.10363763568137>

```

### from_array
*detect point from Array of Arrays*

```ruby

# 3xN (2d result)

Mlr.from_array([
  [0, 100, 50],
  [100, 100, 50],
  [100, 0, 50]
])

=> #<struct Mlr::ResultPoint2D x=59.103629855759586, y=59.10363763568137>


# or 4xN (3d result)
Mlr.from_array([
  [0, 100, 0, 50],
  [100, 100, 100, 50],
  [100, 0, 200, 50]
])

=> #<struct Mlr::ResultPoint3D x=56.699519667205976, y=56.69946167965226, z=99.99998609719331>

```
