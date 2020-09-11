import jinja2
from jinja2 import Template
import yaml


def main():
    template_file = "templates/resume.tex"
    data_file = "resources/data.yml"
    output_file = "dist/output.tex"

    template = get_template(template_file)
    data = get_data(data_file)
    render_template_to_file(template, data, output_file)

def get_template(template_file):
    latex_jinja_env = jinja2.Environment(
    	block_start_string = '\BLOCK{',
    	block_end_string = '}',
    	variable_start_string = '\VAR{',
    	variable_end_string = '}',
    	# comment_start_string = '\#{',
    	# comment_end_string = '}',
    	line_statement_prefix = '%%',
    	# line_comment_prefix = '%#',
    	# trim_blocks = True,
    	# autoescape = False,
    	# loader = jinja2.FileSystemLoader(os.path.abspath('/')),
    )
    with open(template_file) as f:
        contents = f.read()

    return latex_jinja_env.from_string(contents)

def get_data(data_file):
    with open(data_file, 'r') as stream:
        data = yaml.safe_load(stream)
    return data

def render_template_to_file(template, data, output_file):
    with open(output_file, "w") as fh:
        fh.write(template.render(data))




if __name__ == "__main__":
    main()