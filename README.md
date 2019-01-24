# Mlr

multilateration solution

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

# detect point from Mlr::AnchorPoint struct

```ruby

# Mlr::AnchorPoint2D.new(X, Y, D)
# Mlr::AnchorPoint3D.new(X, Y, Z, D)

Mlr.from_points([
  Mlr::AnchorPoint2D.new(0, 100, 50),
  Mlr::AnchorPoint2D.new(100, 100, 50),
  Mlr::AnchorPoint2D.new(100, 0, 50)
])

```

# detect point from Array of Arrays

```ruby

# 3xN (2d result)

Mlr.from_array([
  [0, 100, 50],
  [100, 100, 50],
  [100, 0, 50]
])

# or 4xN (3d result)
Mlr.from_array([
  [0, 100, 0, 50],
  [100, 100, 100, 50],
  [100, 0, 200, 50]
])
LSE Geolocating...
 => #<struct Mlr::ResultPoint3D x=56.699519667205976, y=56.69946167965226, z=99.99998609719331>

```
