import shutil
from xonsh.tools import unthreadable, uncapturable


def _kaizen_alias(keys, command):
    aliases[''.join(keys)] = command


# unthreadable + uncapturable: interactive fzf (spawned by `zoxide query -i`)
# needs the controlling tty. A threadable/captured callable alias hides the tty,
# so fzf returns nothing and the alias silently does nothing.
@unthreadable
@uncapturable
def _kaizen_zoxide_pick(args):
    zoxide = shutil.which('zoxide')
    if not zoxide:
        return
    dest = $(@(zoxide) query -i -- @(args)).strip()
    if dest:
        cd @(dest)


_kaizen_alias(["v","l"], 'jjui')
# projects.pick → zoxide interactive directly (no dependency on zoxide's own `zi`
# alias, which only exists after `zoxide init` runs and was order/PATH-fragile).
aliases[''.join(["p","p"])] = _kaizen_zoxide_pick
# run.task (keys: ["space","r","t"]) — alias registered by xontrib-runner
