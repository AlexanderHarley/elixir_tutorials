defmodule CardsTest do
    use ExUnit.Case
    doctest Cards

    test "create_deck makes 20 cards" do
        assert length(Cards.create_deck) == 20
    end

    test "shuffling a deck randomizes it" do
        # there is a remote chance this test could fail with correct behaviour
        # look at improving
        deck = Cards.create_deck
        refute deck == Cards.shuffle(deck)
    end
end
