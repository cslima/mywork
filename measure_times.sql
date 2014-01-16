CREATE TABLE tests (id integer primary key, name text not null, verb text not null, url text not null, params text, headers text, payload text, content_to_match text, expected_response integer not null, active integer not null default 1, timestamp not null default current_timestamp);
INSERT INTO tests (id, name, verb, url, params, headers, payload, content_to_match, expected_response) VALUES 
(1,'PUT /v1/sellerItems/{skuId}/stock','PUT','https://api.extra.com.br/api/v1/sellerItems/295742/stock','','{"nova-app-token":"MONITORIA-NOVA","nova-auth-token":"MONITORIA-NOVA","Content-Type": "application/json"}','{"availableQuantity":"19488","totalQuantity":"19488"}','',204),
(2,'PUT /v1/sellerItems/{skuId}/price','PUT','https://api.extra.com.br/api/v1/sellerItems/295742/prices','','{"nova-app-token":"MONITORIA-NOVA","nova-auth-token":"MONITORIA-NOVA","Content-Type": "application/json"}','{"defaultPrice":"7.78","salePrice":"7.77"}','',204),
(3,'GET /v1/orders/status/approved','GET','https://api.extra.com.br/api/v1/orders/status/approved?_offset=0&_limit=50','','{"nova-app-token":"MONITORIA-NOVA","nova-auth-token":"MONITORIA-NOVA"}','','orderId',200),
(4,'GET /v1/orders/{orderId}','GET','https://api.extra.com.br/api/v1/orders/25010685','','{"nova-app-token":"MONITORIA-NOVA","nova-auth-token":"MONITORIA-NOVA"}','','orderId',200),
(5,'GET /v1/sellerItems/skuOrigin/{skuOrigin}','GET','https://api.extra.com.br/api/v1/sellerItems/skuOrigin/20945531','','{"nova-app-token":"MONITORIA-NOVA","nova-auth-token":"MONITORIA-NOVA"}','','"skuId":"295742"',200),
(6,'GET /v1/sellerItems/status/selling','GET','https://api.extra.com.br/api/v1/sellerItems/status/selling?_offset=0&_limit=50','','{"nova-app-token":"MONITORIA-NOVA","nova-auth-token":"MONITORIA-NOVA"}','','"skuId":"295742"',200),
(7,'GET /v1/orders/status/new','GET','https://api.extra.com.br/api/v1/orders/status/new?_offset=0&_limit=50','','{"nova-app-token":"MONITORIA-NOVA","nova-auth-token":"MONITORIA-NOVA"}','','',200),
(8,'GET /v1/sellerItems','GET','https://api.extra.com.br/api/v1/sellerItems?_offset=0&_limit=50','','{"nova-app-token":"MONITORIA-NOVA","nova-auth-token":"MONITORIA-NOVA"}','','"skuId":"295742"',200),
(9,'GET /loads/products/{importerInfoId}','GET','https://api.extra.com.br/api/v1/loads/products/58551','','{"nova-app-token":"MONITORIA-NOVA","nova-auth-token":"MONITORIA-NOVA"}','','',200),
(11,'GET /tickets','GET','https://api.extra.com.br/api/v1/tickets','','{"nova-app-token":"MONITORIA-NOVA","nova-auth-token":"MONITORIA-NOVA"}','','',200),
(13,'GET /categories','GET','https://api.extra.com.br/api/v1/categories?_offset=0&_limit=50','','{"nova-app-token":"MONITORIA-NOVA","nova-auth-token":"MONITORIA-NOVA"}','','',200),
(14,'GET /products','GET','https://api.extra.com.br/api/v1/products?searchText=iPad&_offset=0&_limit=50','','{"nova-app-token":"MONITORIA-NOVA","nova-auth-token":"MONITORIA-NOVA"}','','',200)
;

CREATE TABLE results (test_id integer not null, dt integer not null, ms integer not null default 0, ok integer not null default 1);
