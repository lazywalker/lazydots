# Kanata

Keyboard remapper running as a **systemd user service**.

## Layout

| Path | Purpose |
|------|---------|
| `config.kbd` | Kanata configuration (keymaps, layers) |
| `kanata.service` | The systemd unit — the real file lives here and is tracked in the dotfiles repo |
| `~/.config/systemd/user/kanata.service` | Symlink to the unit above, so systemd can find it |

Keeping the unit next to its config means one directory holds everything, and
changes to it are picked up by the dotfiles repo without hunting through
`~/.config/systemd/user/`.

## Setup

1. Install kanata (`pacman -S kanata` or from AUR) and make sure your user can
   access `/dev/uinput` — you need to be in the `uinput` and `input` groups
   (usually handled by a udev rule; re-login after adding them).

2. Create the symlink systemd expects:

   ```sh
   ln -sfn ../../kanata/kanata.service ~/.config/systemd/user/kanata.service
   ```

3. Reload systemd and enable the unit:

   ```sh
   systemctl --user daemon-reload
   systemctl --user enable --now kanata.service
   ```

## Day to day

```sh
systemctl --user restart kanata.service   # after editing config.kbd
systemctl --user status kanata.service
journalctl --user -u kanata.service -f    # follow logs
systemctl --user stop kanata.service      # remapping off
```

## Removing it

```sh
systemctl --user disable --now kanata.service
rm ~/.config/systemd/user/kanata.service
```

## Notes

- The unit runs `%h/.config/kanata/config.kbd` as your own user (no root), so
  it depends on the `uinput`/`input` group membership above.
- `Restart=no` is deliberate: a broken config would otherwise put the service in
  a restart loop.
