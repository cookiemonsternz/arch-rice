Basically a copy of MediaMini but mouse click controls media instead of opening a panel

For development, you can enable hot reload via systemd

```
systemctl --user edit noctalia
```

And add:
```
[Service]
Environment="NOCTALIA_DEBUG=1"
```