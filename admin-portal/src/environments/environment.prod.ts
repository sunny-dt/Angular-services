
//// -----PROD-------
// export const environment = {
//   production: true,
//   apiUrl: 'https://g3mapper.amat.com/api/',
//   issuer_uri: 'https://mylogin.amat.com:8080',
//   client_id: 'G3Mobile',
//   redirect_uri: 'https://g3mapper.amat.com/admin-portal/callback',
//   scope:'openid profile',
//   extras: {
//     'access_type': 'offline'
//   }
// };


//// -----QA-------
// export const environment = {
//   production: true,
//   apiUrl: 'https://g3mapperqa.amat.com/api/',
//   issuer_uri: 'https://myloginqa.amat.com:8080',
//   client_id: 'G3Mobile_Dev',
//   redirect_uri: 'https://g3mapperqa.amat.com/admin-portal/callback',
//   scope:'openid profile',
//   extras: {
//     'access_type': 'offline'
//   }
// };

//// -----LIVE-------
// export const environment = {
//   production: false,
//   apiUrl: 'https://digitaas.io/amat/beamplatform/api/',
//   issuer_uri: 'https://myloginqa.amat.com:8080',
//   client_id: 'G3Mobile_Dev',
//   redirect_uri: 'https://www.digitaas.io/amatg3mapperv2/admin-portal/callback',
//   scope:'openid profile',
//   extras: {
//     'access_type': 'offline'
//   }
// };

//// -----DEV-------
export const environment = {
  production: true,
  apiUrl: 'http://localhost:3000/',
  issuer_uri: 'https://myloginqa.amat.com:8080',
  client_id: 'G3Mobile_Dev',
  redirect_uri: 'https://www.digitaas.io/amatg3mapperv2/admin-portal/callback',
  scope: 'openid profile',
  extras: {
    'access_type': 'offline'
  }
};
