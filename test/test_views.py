import unittest

from hello_world import app
from hello_world.formater import SUPPORTED


class FlaskTestCase(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

    def test_outputs(self):
        rv = self.app.get('/outputs')
        s = str(rv.data)
        self.assertIn(
            ', '.join(SUPPORTED), s
        )

    def test_msg_without_output(self):
        rv = self.app.get('/')
        self.assertEqual(b'Jakub Hello World!', rv.data)

    def test_msg_with_output(self):
        rv = self.app.get('/?output=json')
        self.assertEqual(
            b'{"imie":"Jakub", "msg":"Hello World!"}',
            rv.data
        )
