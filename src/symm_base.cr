module SymmBase
  # Shorthand for Float64 and Int32 used throughout this library.
  alias Num = Float64 | Int32
end

# now pull in rest of library
require "./*"

# Provides namespace for a "Base shard" for *other* shards related to
# Crystallographic Symmetry. See the README or see the GitLab group:
# https://gitlab.com/crystal-symmetry
module SymmBase
  VERSION = "1.0.0"
end
