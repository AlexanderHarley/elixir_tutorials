defmodule Identicon do
    def main(input) do
        input
        |> hash_input
        |> pick_colour
        |> build_grid
        |> filter_odd_squares
        |> build_pixel_map
        |> draw_image
        |> save_image(input)
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
        grid =
            hex
            |> Enum.chunk(3)
            # Enum.map(mirror_row) will pass the return value of the function to .map, causing an error
            # Enum.map(&mirror_row/1) will pass the reference to the function to the .map, working as intended
            # The /1 represents the arity of the function
            |> Enum.map(&mirror_row/1)
            |> List.flatten
            |> Enum.with_index

        %Identicon.Image{image | grid: grid}
    end

    def mirror_row(row) do
        # [145, 46, 200]
        [first, second | _] = row

        # [145, 46, 200, 46, 145]
        row ++ [second, first]
    end

    def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
        grid = Enum.filter grid, fn({value, _}) ->
            rem(value, 2) == 0
        end

        %Identicon.Image{image | grid: grid}
    end

    def build_pixel_map(%Identicon.Image{grid: grid} = image) do
        pixel_map = Enum.map grid, fn({_, index}) ->
            x = rem(index, 5) * 50
            y = div(index, 5) * 50
            top_left     = {x, y}
            bottom_right = {x + 50, y + 50}

            {top_left, bottom_right}
        end

        %Identicon.Image{image | pixel_map: pixel_map}
    end

    def draw_image(%Identicon.Image{colour: colour, pixel_map: pixel_map}) do
        image = :egd.create(250, 250)
        fill  = :egd.color(colour)

        Enum.each pixel_map, fn({start, stop}) ->
            :egd.filledRectangle(image, start, stop, fill)
        end

        :egd.render(image)
    end

    def save_image(image, filename) do
        File.write("#{filename}.png", image)
    end
end
