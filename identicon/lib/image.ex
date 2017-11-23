defmodule Identicon.Image do
    # `defstruct hex: nil` is equivalent to `defstruct [hex: nil]`
    defstruct hex: nil, colour: nil, grid: nil, pixel_map: nil
end
