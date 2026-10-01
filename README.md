# neovim-ansible

This container will configure a NeoVim environment ideal to edit ansible code.
Some cool features are:

- Syntax highlight
- Fuzzy search for file name and content
- Ansible linter enable (with quickly browseable errors)
- Integrated ansible modules documentation

## Usage

Once built, you can run the docker container specifying the root directory
of your ansible code:

    # docker run -it --rm -v MyCodeDirectory:/code neovim-ansible:latest

The system will install all the necessary plugins at every launch of the
container, so you need internet connection from the host.
You can follow errors inside the NeoVim lower status bar.
Once is done you are presented with the content of your code directory.

If you want to open specific files you can pass it to the docker command line
as an relative path, the working directory is /code.

You're now ready to write your best Ansible code!

## Some usage notes

As you can see, line numbers are relatives to the current selected lines. I
find it handful to have the current line number on the current lines but a
progressive one on the previous/next lines, so it really quick to perform
commands on lines by expressing the number on it.

For example, with this configuration I can easly tell where I jump if I run
the command '15k' (move up 15 times).

Also, you can see a vertical line on the column 80. It's not a strict constraint
(i.e. I disabled the linter check for long lines) but keeping lines not longer
than the column 80 is an historic best practice.

## Fuzzy search

You can easly find any file in your code using fuzzy search. To search for
a file by name, in vi Normal mode, you can press:

    <Space>sf

and start typing for a file name. You can then use arrow keys to select the
file (or Ctrl-n to select the next one in the list) and see a preview of the
content on the right.

Similar is searching for file content, you can enter the live grep using:

    <Space>sg

and start typing. The text will be searched inside all the files in your code
and a preview is provided on the right side.

Struggle to remember the shortcuts? Here a reminder:

- <Space>sf: Search File
- <Space>sg: Search Grep

## Ansible Linter

Once loaded the yaml file, the ansible linter will start soon to check the
entire file. You can see in the bottom right corner the linter status. It will
also analize again the file every time you save it.

Diagnostics like Errors are identified with a red E letter on the left. You
can press <Ctrl>n to jump to the next one and see the error, so you can
easly fix it.

Some linter checks are disabled, as you can see in the ansible-lint.yml file
in this repository. You can customize the linter behaviour editing the file
and rebuilding the container.

## Integrated Ansible Modules Documentation

It's handy to have the official Ansible modules documentations always available.
While inside the code, in vi Normal mode, you can move the cursor on top of
a module name and press:

    <Space>sh

to have the buffer splitted vertically with the documentation inside NeoVim
itself. You can browse the documentation with the usual vim motions and search
shortcuts, and you can switch between your code and the documentation using the
combination <Ctrl>ww (yes, two 'w').

Once you've done, use the combination to go on the documentation and close it
with the usual :q command.

## Customization

You can easly customize you NeoVim experience by editing the files in this
repository.

- ansible_lint.yml: the Ansible Linter configuration
- nvim_config: the entire NeoVim configuration, with all the plugins

## Aliasing the vi/vim command

An handy way to use this container is to aliasing the vi/vim command so you
don't have to type out all the docker options at every launch.

Here an example bash/zsh configuration you can use to easly do that, just paste
it at the end of your .zsh/.bashrc file in your home directory:

```shell
function vi () {
    TGP=""
    TGF=""
    if [ ${#1} -eq 0 ]; then
        TGP=$PWD
    else
        if [ -d $1 ]; then
            TGP=$(realpath $1)
        elif [ -f $1 ]; then
            FULL=$(realpath $1)
            TGF=$(basename $FULL)
            TGP=$(dirname $FULL)
        fi
    fi
    if [ ${#TGF} -eq 0 ]; then
        docker run -it --rm -v $TGP:/code neovim-ansible:latest
    else
        docker run -it --rm -v $TGP:/code neovim-ansible:latest /code/${TGF}
    fi
}
alias vim=vi
```
