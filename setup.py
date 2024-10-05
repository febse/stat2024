
from utils.qr_code import create_qr_code
from utils.settings import get_settings

cs = get_settings()
qr_img = create_qr_code(cs['url'])
qr_img.save('figures/qr_code.png')
