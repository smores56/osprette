The Osprette Family
===================

The Osprette is a 34-key unibody keyboard with pinky clusters, my variation on
Brow's [Balbuzard][balbuzard]. All the revisions and variants share the same
layout and the same firmware, so they live in one repo now, a folder per board:

- [Osprette][v1] (`v1`): the original. Pro-micro compatible, direct solder, with
  bluetooth support if you use a suitable controller
- [Osprette V2][v2] (`v2`): second revision, nicer case, optional hotswap
- [Osprette V3][v3] (`v3`): direct solder for people who want their switches to stay put
- [Osprette MX][mx] (`mx`): the original, but for MX switches
- [Osprangle][osprangle] (`osprangle`): hotswap, so you can try all the choc v2 switches
- [Roadkill][roadkill] (`roadkill`): a tiny one using Kailh's PG1316S butterfly switches

Each folder has its own README with ordering details and pictures.

# Firmware

They all share a matrix, so they all run the same firmware: `osprette` in QMK
(once [this PR][qmk-pr] lands) and the `osprette` shield in ZMK. Roadkill doesn't
have firmware yet. My personal keymaps live in [qmk_userspace][qmk_userspace] and
[zmk-config][zmk-config].

# Building

These boards use my [smores.pretty][smores-pretty] KiCad library as a submodule,
so clone with `--recurse-submodules`. The two oldest boards (Osprette and Osprette
MX) still pull in Foostan's `kbd` and Daprice's `keyswitches.pretty` directly.

The split half of the family is [the Clog][clog].


[balbuzard]: https://github.com/brow/balbuzard
[v1]: ./v1
[v2]: ./v2
[v3]: ./v3
[mx]: ./mx
[osprangle]: ./osprangle
[roadkill]: ./roadkill
[qmk-pr]: https://github.com/qmk/qmk_firmware/pull/26450
[qmk_userspace]: https://github.com/smores56/qmk_userspace
[zmk-config]: https://github.com/smores56/zmk-config
[smores-pretty]: https://github.com/smores56/smores.pretty
[clog]: https://github.com/smores56/clog
