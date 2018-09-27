# SymmBase

`SymmBase` is a [Crystal](https://crystal-lang.org) shard which provides some modules and abstract objects for use as a base for other shards. Specifically, it's the base module for a family of shards related to exploring Crystallographic Symmetry: [https://gitlab.com/crystal-symmetry](https://gitlab.com/crystal-symmetry).

If you're brand new to this set of shards, I'd recommend starting with a different library, one that uses this as a base. For example, these base modules / classes were originally abstracted from [Symm32](https://gitlab.com/crystal-symmetry/symm32) so that shard should serve as an excellent starting place.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  symm_base:
    gitlab: crystal-symmetry/symm_base
```

## Usage

```crystal
require "symm_base"
```

See other `crystal-symmetry` shards for examples such as
  * [Symm32](https://gitlab.com/crystal-symmetry/symm32)
  * [SymmSpecies](https://gitlab.com/crystal-symmetry/symm_species) (which builds on `Symm32`)

Or you can see the above shards in use in some crystal applications like
  * [Limit Groups](https://gitlab.com/crystal-symmetry/limit_groups)
  * [Hasse Diagrams](https://gitlab.com/crystal-symmetry/hasse)

all of which rely in part on logic provided by `SymmBase`.

## Contributing

Contributions are welcome! To get things started you can [open an issue](https://gitlab.com/crystal-symmetry/symm_base/issues/new) and post a comment, correction, or feature request. From there we can talk about how best to incorporate (or not) your feedback.

In general, if you want, you can just pull this code down, start hacking on it, and then push it back here as a "Pull Request", then we can discuss your proposed changes.

1. Fork it (<https://gitlab.com/crystal-symmetry/symm_base/forks/new>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

But I recommend you start off by opening an issue so that you don't waste time on a potentially unwelcome change.

## Contributors

- [KCErb](https://gitlab.com/kcerb) KC Erb - creator, maintainer
