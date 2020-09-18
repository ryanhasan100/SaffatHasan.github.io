import jinja2
from jinja2 import Template, FileSystemLoader
import os
import sys
import yaml


def main():
    resume_name = sys.argv[1]
    template_file = f"templates/{resume_name}.tex"
    output_file = f"dist/{resume_name}.tex"

    generate_resume(template_file, output_file)


def generate_resume(template_file, output_file):
    template = get_template(template_file)
    render_template_to_file(template, output_file)


def get_template(template_file):
    latex_jinja_env = jinja2.Environment(
        loader=FileSystemLoader('templates'),
        block_start_string='\BLOCK{',
        block_end_string='}',
        variable_start_string='\VAR{',
        variable_end_string='}',
        comment_start_string='\#{',
        comment_end_string='}',
        line_statement_prefix='%%',
        line_comment_prefix='%#',
        trim_blocks=True,
        autoescape=False,
    )
    with open(template_file) as f:
        contents = f.read()

    return latex_jinja_env.from_string(contents)


def render_template_to_file(template, output_file):
    data = get_data()
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    with open(output_file, "w") as fh:
        fh.write(template.render(data))


def get_data():
    data_file = "resources/data.yml"
    with open(data_file, 'r') as stream:
        data = yaml.safe_load(stream)
    return data


if __name__ == "__main__":
    main()
