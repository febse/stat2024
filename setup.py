import yaml
from utils import create_qr_code

with open('_variables.yml', 'r') as file:        
    cs = yaml.load(file, Loader=yaml.FullLoader)
    qr_img = create_qr_code(cs['url'])
    qr_img.save('figures/qr_code.png')
