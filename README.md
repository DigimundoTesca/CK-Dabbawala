# CloudKitchen project - Instructions

To install CloudKitchen, you must to install virtualenv and a python version >= 3.6

## Creating a virtual environment
 
### With PIP

#### With Unix OS

    $ pip install -p python3 venv

    $ source venv/bin/activate
    
Also you can install your virtualenv with **[virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/)**

#### Windows

	$ pip install venv

	$ venv/Scripts/activate

	(venv)$ pip install -r requirements/local.txt
	
Also you can install your virtualenv with **[virtualenvwrapper](https://pypi.python.org/pypi/virtualenvwrapper-win)**
	


## Local deploy

Make sure you have previously installed all necessary system packages on your OS.

	$ (venv)$ pip install -r requirements/local-unix.txt

You can also install the requirements with the following command:

	$ (venv)$ pip install -r requirements/local.txt

This last command is used for Windows, but does not include the tool for class modeling.
	
## Production deploy

    $ (venv)$ pip install -r requirements.txt

## Third Packages 
### Data Base
If you install a local environment, optionally, you can install Postgresql.

#### Unix OS
    $ sudo apt-get install postgresql postgresql-contrib libpq-dev postgresql-client

- Postgresql tested versions: 
  - 9.2
  - 9.3
  - 9.4
  - 9.5

### Do you have questions about installing?
* [Quick installation of a project django with virtualenv](https://tutorial.djangogirls.org/es/django_installation/)
* [Do you have problemas installing virtualenvwrapper in windows?](https://docs.google.com/presentation/d/1hcTZYw8nJFJ4C59wHb9Z_c8U_oFSeL-nVX8yT0f-aKE/edit?usp=sharing)

or contact us: [softwaremanager@digimundo.com.mx](mailto:softwaremanager@digimundo.com.mx)
    