# NvChad configuration

First [install NvChad](https://nvchad.com/docs/quickstart/install)

Remove custom folder:

```bash
rm -rf ~/.config/nvim/lua/custom
```

Clone this repo in custom folder:

```bash
git clone https://github.com/hackmad/nvchad-config ~/.config/nvim/lua/custom
```

The python dap adapter needs debugpy:

```bash
mkdir ~/.virtualenvs
cd ~/.virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
```
