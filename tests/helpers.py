import pathlib
import subprocess
import tempfile

root = pathlib.Path(__file__).parents[1]

def install(install_dir, source_dir):
    with tempfile.TemporaryDirectory() as build_dir:
        print(f'building zero in {build_dir}')
        subprocess.run([
            'cupcake', 'install',
            '--source-dir', root / source_dir,
            '--build-dir', build_dir,
            '--prefix', install_dir,
        ], check=True)
        yield build_dir

def test(build_dir, source_dir):
    subprocess.run([
        'cupcake', 'test',
        '--source-dir', root / source_dir,
        '--build-dir', build_dir,
    ], check=True)
