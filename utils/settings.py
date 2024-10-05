import yaml

def get_settings():
    with open('settings.yml', 'r') as file:
        return yaml.safe_load(file)
