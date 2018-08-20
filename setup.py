import setuptools

setuptools.setup(
    name='as3',
    version='0.1',
    author='Pavel Perestoronin',
    author_email='eigenein@gmail.com',
    description='Adobe ActionScript 3 interpreter',
    long_description=open('README.md', 'rt').read(),
    long_description_content_type='text/markdown',
    url='https://github.com/eigenein/python-as3',
    packages=setuptools.find_packages(exclude=['tests']),
    python_requires='>=3.7',
    install_requires=[],
    extras_require={},
    classifiers=[
        'Development Status :: 1 - Planning',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 3 :: Only',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.7',
        'Topic :: Software Development :: Interpreters',
        'Topic :: Software Development :: Libraries :: Python Modules',
    ],
)
