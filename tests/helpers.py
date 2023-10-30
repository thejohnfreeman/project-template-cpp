import os
import pathlib
import subprocess
import tempfile

root = pathlib.Path(__file__).parents[1]

try:
    os.symlink(
        root / '00-upstream',
        root / '02-add-subdirectory/external/00-upstream',
    )
except FileExistsError:
    pass

def install(params, source_dir):
    with tempfile.TemporaryDirectory() as build_dir:
        print(f'building zero in {build_dir}')
        subprocess.run([
            'cupcake', 'install',
            '--source-dir', root / source_dir,
            '--build-dir', build_dir,
            *params,
        ], check=True)
        yield build_dir

def test(build_dir, source_dir):
    subprocess.run([
        'cupcake', 'test',
        '--source-dir', root / source_dir,
        '--build-dir', build_dir,
    ], check=True)