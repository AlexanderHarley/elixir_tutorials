defmodule Identicon do
    def main(input) do
        input
        |> hash_input
        |> pick_colour
        |> build_grid
    end

    def hash_input(input) do
        hex = :crypto.hash(:md5, input)
        |> :binary.bin_to_list

        %Identicon.Image{hex: hex}
    end

    def pick_colour(%Identicon.Image{hex: [r, g, b | _]} = image) do
        %Identicon.Image{image | colour: {r, g, b}}
    end

    def build_grid(%Identicon.Image{hex: hex} = image) do
        hex
        |> Enum.chunk(3)
        # |> mirror_row
    end

    def mirror_row(row) do
        # [145, 46, 200]
        [first, second | _] = row

        # [145, 46, 200, 46, 145]
        row ++ [second, first]
    end
end
