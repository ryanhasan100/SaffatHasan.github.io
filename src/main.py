""" main.py - Perform variable substitutions on a LaTeX template

ARGS:
    resume_name(string): template to use (found in templates/{resume_name}.tex)
"""

import os
import sys
import jinja2
from jinja2 import FileSystemLoader
import yaml


def main():
    """ extract resume_name from sys args and delegate to generate_resume
    """
    resume_name = sys.argv[1]
    template_file = f"templates/{resume_name}.tex"
    output_file = f"dist/{resume_name}.tex"

    generate_resume(template_file, output_file)


def generate_resume(template_file, output_file):
    """ fetch template and render to file
    """
    template = get_template(template_file)
    render_template_to_file(template, output_file)


def get_template(template_file):
    """ Defines the jinja Environment and returns template string

    ARGS:
        template_file(string): name of the file which contains the latex template

    RETURNS:
        Jinja2 template
    """
    latex_jinja_env = jinja2.Environment(
        loader=FileSystemLoader('templates'),
        block_start_string=r'\BLOCK{',
        block_end_string='}',
        variable_start_string=r'\VAR{',
        variable_end_string='}',
        comment_start_string=r'\#{',
        comment_end_string='}',
        line_statement_prefix='%%',
        line_comment_prefix='%#',
        trim_blocks=True,
        autoescape=False,
    )

    with open(template_file) as file_handle:
        contents = file_handle.read()

    return latex_jinja_env.from_string(contents)


def render_template_to_file(template, output_file):
    """ Takes a template and path and outputs the rendered resume

    ARGS:
        template(Jinja2.Template): template to be rendered to
        output_file(string): destination, specified as dist/{resume_name}.pdf
    """
    data = get_data()
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    with open(output_file, "w") as file_handle:
        file_handle.write(template.render(data))


def get_data():
    """ Returns the dictionary representation of the `resources/data.yml` file

    RETURNS:
        key/value pairs of data
    """
    data_file = "resources/data.yml"
    with open(data_file, 'r') as stream:
        data = yaml.safe_load(stream)
    return data


if __name__ == "__main__":
    main()
