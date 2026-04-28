const auth = require('../../src/middleware/auth');
const jwt = require('jsonwebtoken');

jest.mock('jsonwebtoken');

describe('auth middleware', () => {
  
  test('retourne 401 si pas de token', () => {
    const req = { headers: {} };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn()
    };
    const next = jest.fn();

    auth(req, res, next);

    expect(res.status).toHaveBeenCalledWith(401);
    expect(res.json).toHaveBeenCalledWith({ error: 'No token provided' });
  });

  test('retourne 401 si format invalide', () => {
    const req = { headers: { authorization: 'BadFormatToken' } };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn()
    };
    const next = jest.fn();

    auth(req, res, next);

    expect(res.status).toHaveBeenCalledWith(401);
    expect(res.json).toHaveBeenCalledWith({ error: 'Invalid token format' });
  });

  test('appelle next si token valide', () => {
    jwt.verify.mockReturnValue({ id: 1 });

    const req = {
      headers: { authorization: 'Bearer validtoken' }
    };

    const res = {};
    const next = jest.fn();

    auth(req, res, next);

    expect(next).toHaveBeenCalled();
    expect(req.user).toEqual({ id: 1 });
  });

  test('retourne 401 si token invalide', () => {
    jwt.verify.mockImplementation(() => {
      throw new Error('invalid token');
    });

    const req = {
      headers: { authorization: 'Bearer badtoken' }
    };

    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn()
    };

    const next = jest.fn();

    auth(req, res, next);

    expect(res.status).toHaveBeenCalledWith(401);
    expect(res.json).toHaveBeenCalledWith({ error: 'Invalid or expired token' });
  });

});