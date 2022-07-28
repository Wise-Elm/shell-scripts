--

INSERT INTO public.bikes VALUES (8, 'BMX', 20, true);
INSERT INTO public.bikes VALUES (9, 'BMX', 21, true);
INSERT INTO public.bikes VALUES (1, 'Mountain', 27, true);
INSERT INTO public.bikes VALUES (2, 'Mountain', 28, true);
INSERT INTO public.bikes VALUES (3, 'Mountain', 29, true);
INSERT INTO public.bikes VALUES (4, 'Road', 27, true);
INSERT INTO public.bikes VALUES (5, 'Road', 28, true);
INSERT INTO public.bikes VALUES (6, 'Road', 29, true);
INSERT INTO public.bikes VALUES (7, 'BMX', 19, true);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.customers VALUES (1, '555-5555', 'Me');
INSERT INTO public.customers VALUES (2, '000-0000', 'Test');


--
-- Data for Name: rentals; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.rentals VALUES (5, 1, 5, '2021-05-27', '2022-06-29');
INSERT INTO public.rentals VALUES (1, 1, 1, '2021-05-25', '2022-06-29');
INSERT INTO public.rentals VALUES (2, 1, 2, '2021-05-25', '2022-06-29');
INSERT INTO public.rentals VALUES (3, 1, 3, '2021-05-27', '2022-06-29');
INSERT INTO public.rentals VALUES (4, 1, 4, '2021-05-27', '2022-06-29');
INSERT INTO public.rentals VALUES (8, 1, 5, '2022-06-29', '2022-06-29');
INSERT INTO public.rentals VALUES (6, 2, 6, '2021-05-27', '2022-06-29');
INSERT INTO public.rentals VALUES (7, 2, 7, '2021-05-27', '2022-06-29');


--
-- Name: bikes_bike_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.bikes_bike_id_seq', 9, true);


--

SELECT pg_catalog.setval('public.customers_customer_id_seq', 2, true);

-- Name: rentals_rental_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
-- 
 
SELECT pg_catalog.setval('public.rentals_rental_id_seq', 8, true); 
 
 
-- 
-- Name: bikes bikes_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp 
-- 
 
ALTER TABLE ONLY public.bikes 
    ADD CONSTRAINT bikes_pkey PRIMARY KEY (bike_id); 
 
 
-- 
-- Name: customers customers_phone_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp 
-- 
 
ALTER TABLE ONLY public.customers 
    ADD CONSTRAINT customers_phone_key UNIQUE (phone); 
 
 
-- 
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp 
-- 
 
ALTER TABLE ONLY public.customers 
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id); 
 
 
-- 
-- Name: rentals rentals_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp 
-- 
 
ALTER TABLE ONLY public.rentals 
    ADD CONSTRAINT rentals_pkey PRIMARY KEY (rental_id); 
 
 
-- 
-- Name: rentals rentals_bike_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp 
-- 
 
ALTER TABLE ONLY public.rentals 
    ADD CONSTRAINT rentals_bike_id_fkey FOREIGN KEY (bike_id) REFERENCES public.bikes(bike_id); 
 
 
-- 
-- Name: rentals rentals_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp 
-- 
 
ALTER TABLE ONLY public.rentals 
    ADD CONSTRAINT rentals_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id); 
 
 
-- 
-- PostgreSQL database dump complete 
-- 
