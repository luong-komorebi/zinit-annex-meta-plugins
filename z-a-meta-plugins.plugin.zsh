# -*- mode: sh; sh-indentation: 4; indent-tabs-mode: nil; sh-basic-offset: 4; -*-

# Copyright (c) 2020 Sebastian Gniazdowski

# According to the Zsh Plugin Standard:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html#zero-handling

0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

typeset -gA Zinit_Annex_Meta_Plugins
Zinit_Annex_Meta_Plugins[0]="$0" Zinit_Annex_Meta_Plugins[repo-dir]="${0:h}"

# Standard hash for plugins:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html#std-hash
typeset -gA Plugins
Plugins[META_PLUGINS_DIR]="${0:h}"

autoload -Uz ∧za-meta-plugins-before-load-handler \
    ∧za-meta-plugins-default-ice-cmd-help-handler \
    ∧za-meta-plugins-default-ice-cmd

# An empty stub to fill the help handler fields
∧za-meta-plugins-help-null-handler() { :; }

# The unscoping-support hook.
@zinit-register-annex "zinit-annex-meta-plugins" \
    hook:before-load-4 \
    ∧za-meta-plugins-before-load-handler \
    ∧za-meta-plugins-help-null-handler \
    "skip''" # Add a new ice

# The subcommand `meta'.
@zinit-register-annex "zinit-annex-meta-plugins" \
    subcommand:default-ice \
    ∧za-meta-plugins-default-ice-cmd \
    ∧za-meta-plugins-default-ice-cmd-help-handler

# The map in which the definitions of the meta-plugins are being stored.
typeset -gA Zinit_Annex_Meta_Plugins_Map
Zinit_Annex_Meta_Plugins_Map=(
    # Zinit annexes
    annexes     "zdharma-continuum/zinit-annex-unscope zdharma-continuum/zinit-annex-readurl zdharma-continuum/zinit-annex-patch-dl \
                    zdharma-continuum/zinit-annex-rust zdharma-continuum/zinit-annex-submods zdharma-continuum/zinit-annex-bin-gem-node"
    # Annexes + the zinit-console
    annexes+con "zdharma-continuum/zinit-console annexes"

    # @zsh-users
    zsh-users   "zsh-users/zsh-syntax-highlighting zsh-users/zsh-autosuggestions zsh-users/zsh-completions"
    zsh-users+fast "zdharma-continuum/fast-syntax-highlighting zsh-users/zsh-autosuggestions zsh-users/zsh-completions"
    
    # @zdharma
    zdharma     "zdharma-continuum/fast-syntax-highlighting zdharma-continuum/history-search-multi-word zdharma-continuum/zsh-diff-so-fancy"
    zdharma2    "zdharma-continuum/zconvey zdharma-continuum/zui zdharma-continuum/zflai"

    # @molovo
    molovo      "molovo/color molovo/revolver molovo/zunit"

    # @sharkdp
    sharkdp     "sharkdp/fd sharkdp/bat sharkdp/hexyl sharkdp/hyperfine sharkdp/vivid"

    # Development-related utilities. color and revolver are zunit's
    # dependencies. Tig is being built from source (Git). The gitignore
    # plugin has a Zsh template automatically set up — gi zsh to see it.
    developer   "github-issues github-issues-srv molovo/color molovo/revolver molovo/zunit \
                    voronkovich/gitignore.plugin.zsh jonas/tig"

    # General console utilities. Includes also a LS_COLORS theme with
    # the Zsh completion configured.
    console-tools "dircolors-material sharkdp ogham/exa BurntSushi/ripgrep jonas/tig"

    # Fuzzy searchers (4 of them).
    fuzzy       "fzf fzy lotabout/skim peco/peco"
    fuzzy-src   "fzf-go fzy skim-cargo peco-go"

    # Git extensions.
    ext-git     "paulirish/git-open paulirish/git-recent davidosomething/git-my arzzen/git-quick-stats iwata/git-now tj/git-extras wfxr/forgit"

    # Rust toolchain + cargo extensions.
    rust-utils  "rust-toolchain cargo-extensions"

    # A few Prezto modules.
    prezto      "PZTM::archive PZTM::directory PZTM::utility"
)

# The map in which the default sets of ices for the real plugins are being stored.
typeset -gA Zinit_Annex_Meta_Plugins_Config_Map
typeset -g _std="lucid"
Zinit_Annex_Meta_Plugins_Config_Map=(
    # all annexes + extensions, without Meta-Plugins, obviously
    zdharma-continuum/zinit-console     "$_std"
    zdharma-continuum/zinit-annex-readurl       "$_std"
    zdharma-continuum/zinit-annex-patch-dl      "$_std"
    zdharma-continuum/zinit-annex-unscope       "$_std"
    zdharma-continuum/zinit-annex-submods       "$_std"
    zdharma-continuum/zinit-annex-rust          "$_std"
    zdharma-continuum/zinit-annex-bin-gem-node  "$_std"
    zdharma-continuum/zinit-annex-man           "$_std"
    zdharma-continuum/zinit-annex-test          "$_std"
    # @zsh-users
    zsh-users/zsh-autosuggestions       "$_std atload'_zsh_autosuggest_start;'"
    zsh-users/zsh-syntax-highlighting   "$_std atinit'ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay;'"
    zsh-users/zsh-completions           "$_std pick'/dev/null'"
    # @zdharma
    zdharma-continuum/fast-syntax-highlighting    "$_std atinit'ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay;'"
    zdharma-continuum/history-search-multi-word   "$_std atinit'zstyle :history-search-multi-word page-size 7;'"
    zdharma-continuum/zsh-diff-so-fancy           "$_std null sbin'bin/git-dsf;bin/diff-so-fancy'"
    # @zdharma, less popular
    zdharma-continuum/zui             "$_std blockf"
    zdharma-continuum/zconvey         "$_std sbin'cmds/zc-bg-notify;cmds/plg-zsh-notify'"
    zdharma-continuum/zsh-unique-id   "$_std"
    zdharma-continuum/zflai           "$_std"
    github-issues           "$_std pack"
    github-issues-srv       "$_std pack atinit'GIT_PROJECTS=zdharma-continuum/zinit GIT_SLEEP_TIME=700;'"
    # @molovo
    molovo/zunit            "$_std binary sbin atclone'./build.zsh;' atpull'%atclone'"
    molovo/color            "$_std binary sbin'color.zsh -> color'"
    molovo/revolver         "$_std as'program' pick'revolver'"
    # @zpm-zsh
    dircolors-material      "$_std pack"
    # @pyenv
    pyenv                   "$_std pack'bgn'"

    # @sharkdp
    sharkdp/fd              "$_std binary lucid from'gh-r' mv'fd* fd' sbin'**/fd(.exe|) -> fd'"
    sharkdp/bat             "$_std binary lucid from'gh-r' mv'bat* bat' sbin'**/bat(.exe|) -> bat'"
    sharkdp/hexyl           "$_std binary lucid from'gh-r' mv'hexyl* hexyl' sbin'**/hexyl(.exe|) -> hexyl'"
    sharkdp/hyperfine       "$_std binary lucid from'gh-r' mv'hyperfine* hyperfine' sbin'**/hyperfine(.exe|) -> hyperfine'"
    sharkdp/vivid           "$_std binary lucid from'gh-r' mv'vivid* vivid' sbin'**/vivid(.exe|) -> vivid'"
    # @ogham
    ogham/exa               "$_std binary from'gh-r' sbin'**/exa -> exa' atclone'cp -vf completions/exa.zsh _exa'"
    exa-cargo               "$_std binary cargo='!exa' teleid'zdharma-continuum/null'"
    # @BurntSushi
    BurntSushi/ripgrep      "$_std binary from'gh-r' mv'rip* ripgrep' sbin'**/rg(.exe|) -> rg'"

    # @jonas
    jonas/tig               "$_std binary make'prefix=$ZPFX install'"

    # Fuzzy searchers
    fzf                     "$_std pack'bgn-binary'"
    fzy                     "$_std pack'bgn' git"
    lotabout/skim           "$_std binary from'gh-r' sbin'**/sk(.exe|) -> sk'"
    peco/peco               "$_std binary from'gh-r' mv'peco* peco' sbin'**/peco(.exe|) -> peco'"
    # Fuzzy searchers – from sources
    fzf-go                  "$_std pack'bgn' teleid'fzf' git"
    skim-cargo              "$_std binary cargo='!skim -> sk' teleid'zdharma-continuum/null'"
    peco-go                 "$_std binary make'build' sbin'**/peco(.exe|) -> peco' teleid'peco/peco'"

    # no username → a rust-annex usage to install Rust toolchain
    rust-toolchain          "$_std binary sbin='bin/*' rustup teleid'zdharma-continuum/null' \
                                    atload='[[ ! -f \${ZINIT[COMPLETIONS_DIR]}/_cargo ]] && \
                                        zi creinstall rust; \
                                    export CARGO_HOME=\$PWD RUSTUP_HOME=\$PWD/rustup'"

    # see: https://dev.to/cad97/rust-must-know-crates-5ad8
    cargo-extensions        "$_std binary cargo'cargo-edit;cargo-outdated;cargo-tree; \
                                cargo-update; cargo-expand;cargo-modules;cargo-audit;cargo-clone' \
                                sbin'bin/*' teleid'zdharma-continuum/null'"

    # A few utility plugins
    hlissner/zsh-autopair               "$_std"
    urbainvaes/fzf-marks                "$_std"
    voronkovich/gitignore.plugin.zsh    "$_std trigger-load'!gi;!gii' \
        dl'https://gist.githubusercontent.com/psprint/1f4d0a3cb89d68d3256615f247e2aac9/raw -> \
            templates/Zsh.gitignore;'"
    psprint/zsh-navigation-tools        "$_std"
    psprint/zsh-editing-workbench       "$_std atinit'local zew_word_style=whitespace;'"

    # @marzocchi, a notifier, configured to use zconvey
    marzocchi/zsh-notify      "$_std atinit'zstyle \":notify:*\" command-complete-timeout 3; \
                                            zstyle \":notify:*\" notifier plg-zsh-notify"
    # Git extensions
    Fakerr/git-recall         "$_std null sbin"
    paulirish/git-open        "$_std null sbin"
    paulirish/git-recent      "$_std null sbin"
    davidosomething/git-my    "$_std null sbin"
    arzzen/git-quick-stats    "$_std null sbin atload'export _MENU_THEME=legacy;'"
    iwata/git-now             "$_std null sbin"
    tj/git-extras             "$_std null make'PREFIX=$ZPFX'"
    wfxr/forgit               "$_std atinit'forgit_ignore=fgi'"

    # @sindresorhus
    sindresorhus/pure         "$_std pick'async.zsh' src'pure.zsh' atload'prompt_pure_precmd' nocd"

    # @agkozak
    agkozak/agkozak-zsh-theme "$_std atload'_agkozak_precmd' atinit'AGKOZAK_FORCE_ASYNC_METHOD=subst-async' nocd"

    # @woefe
    woefe/git-prompt.zsh      "$_std atload'_zsh_git_prompt_precmd_hook' nocd"
)

# Snippets
_std+=" is-snippet"

Zinit_Annex_Meta_Plugins_Config_Map+=(
    # Prezto
    PZTM::archive       "$_std svn silent nocompile"
    PZTM::directory     "$_std"
    PZTM::utility       "$_std"
)

unset _std


# vim:ft=zsh:tw=80:sw=4:sts=4:et:foldmarker=[[[,]]]
