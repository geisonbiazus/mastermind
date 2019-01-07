# MasterMind

This project is an elixir implementation of the MasterMind solving algorithm showd on [Clean Coders Ep 54](https://cleancoders.com/episode/clean-code-episode-54/show).

It compares three solving strategies and show statistical results for each of them.

The strategies are:

**Sequencial** - Starting on `[0, 0, 0, 0]` it tries breaking the code by incrementing the code guess each time.

**3x2** - It always start with the following sequences: `[0, 0, 1, 1]`, `[2, 2, 3, 3]`, `[4, 4, 5, 5]`, and then it goes sequentialy from `[0, 0, 0, 0]`

**Double rainbow** - It always start with the following sequences: `[0, 1, 2, 3]`, `[2, 3, 4, 5]`, `[4, 5, 0, 1]`, and then it goes sequentialy from `[0, 0, 0, 0]`

## Running

Open iex:

```
$ iex -S mix
```

Run the code:

```elixir
MasterMind.AutoPlay.analyze_strategies(1000)
```

Where 1000 is the number of games each strategy will play.
