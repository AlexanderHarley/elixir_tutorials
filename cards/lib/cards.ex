defmodule Cards do
    @moduledoc """
    Methods to create and use a deck of cards
    """

    @doc """
    Returns a deck of playing cards
    """
    def create_deck do
        values = ["Ace", "Two", "Three", "Four", "Five"]
        suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

        # cards = for value <- values do
        #     for suit <- suits do
        #         "#{value} of #{suit}"
        #     end
        # end
        #
        # List.flatten(cards)

        for suit <- suits, value <- values do
            "#{value} of #{suit}"
        end
    end

    def shuffle(deck) do
        Enum.shuffle(deck)
    end

    @doc """
    Determines whether a deck contains a given card

    ## Examples
        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Spades")
        true
        iex> Cards.contains?(deck, "Something else")
        false
    """
    def contains?(deck, card) do
        Enum.member?(deck, card)
    end

    @doc """
    Deals a hand of `n` cards, where `n` is defined by `hand_size`.
    Also returns the remainder of the deck.

    ## Examples
        iex> deck = Cards.create_deck
        iex> {hand, deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]
    """
    def deal(deck, hand_size) do
        Enum.split(deck, hand_size)
    end

    def save(deck, filename) do
        binary = :erlang.term_to_binary(deck)
        File.write(filename, binary, [])
    end

    def load(filename) do
        case File.read(filename) do
            {:ok, binary} -> :erlang.binary_to_term binary
            {:error, _} -> "That file does not exist"
        end
    end

    def create_hand(hand_size) do
        # deck = Cards.create_deck
        # deck = Cards.shuffle(deck)
        # Cards.deal(deck, hand_size)

        Cards.create_deck
        |> Cards.shuffle
        |> Cards.deal(hand_size)
    end
end
