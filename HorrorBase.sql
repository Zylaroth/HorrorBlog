PGDMP  *    2            
    {         
   HorrorBase    16.0    16.0 )    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    26578 
   HorrorBase    DATABASE     �   CREATE DATABASE "HorrorBase" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "HorrorBase";
                postgres    false            �            1259    26580    genres    TABLE     b   CREATE TABLE public.genres (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);
    DROP TABLE public.genres;
       public         heap    postgres    false            �            1259    26579    genres_id_seq    SEQUENCE     �   CREATE SEQUENCE public.genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.genres_id_seq;
       public          postgres    false    216            �           0    0    genres_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;
          public          postgres    false    215            �            1259    26642    images    TABLE     r   CREATE TABLE public.images (
    id integer NOT NULL,
    url character varying NOT NULL,
    movie_id integer
);
    DROP TABLE public.images;
       public         heap    postgres    false            �            1259    26641    images_id_seq    SEQUENCE     �   CREATE SEQUENCE public.images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.images_id_seq;
       public          postgres    false    221            �           0    0    images_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;
          public          postgres    false    220            �            1259    26598    movie_genres    TABLE     c   CREATE TABLE public.movie_genres (
    movie_id integer NOT NULL,
    genre_id integer NOT NULL
);
     DROP TABLE public.movie_genres;
       public         heap    postgres    false            �            1259    26589    movies    TABLE     q  CREATE TABLE public.movies (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    director character varying(255) NOT NULL,
    actors character varying(255) NOT NULL,
    release_date date NOT NULL,
    rating double precision,
    CONSTRAINT movies_rating_check CHECK (((rating >= (1)::double precision) AND (rating <= (10)::double precision)))
);
    DROP TABLE public.movies;
       public         heap    postgres    false            �            1259    26588    movies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.movies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.movies_id_seq;
       public          postgres    false    218            �           0    0    movies_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.movies_id_seq OWNED BY public.movies.id;
          public          postgres    false    217            �            1259    26672    reviews    TABLE     �   CREATE TABLE public.reviews (
    id integer NOT NULL,
    date timestamp without time zone NOT NULL,
    text character varying NOT NULL,
    movie_id integer
);
    DROP TABLE public.reviews;
       public         heap    postgres    false            �            1259    26671    reviews_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.reviews_id_seq;
       public          postgres    false    223            �           0    0    reviews_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;
          public          postgres    false    222            -           2604    26583 	   genres id    DEFAULT     f   ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);
 8   ALTER TABLE public.genres ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    216    216            /           2604    26645 	   images id    DEFAULT     f   ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);
 8   ALTER TABLE public.images ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            .           2604    26592 	   movies id    DEFAULT     f   ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_seq'::regclass);
 8   ALTER TABLE public.movies ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            0           2604    26675 
   reviews id    DEFAULT     h   ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);
 9   ALTER TABLE public.reviews ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222    223            �          0    26580    genres 
   TABLE DATA           *   COPY public.genres (id, name) FROM stdin;
    public          postgres    false    216   �,       �          0    26642    images 
   TABLE DATA           3   COPY public.images (id, url, movie_id) FROM stdin;
    public          postgres    false    221   *-       �          0    26598    movie_genres 
   TABLE DATA           :   COPY public.movie_genres (movie_id, genre_id) FROM stdin;
    public          postgres    false    219   �.       �          0    26589    movies 
   TABLE DATA           S   COPY public.movies (id, title, director, actors, release_date, rating) FROM stdin;
    public          postgres    false    218   
/       �          0    26672    reviews 
   TABLE DATA           ;   COPY public.reviews (id, date, text, movie_id) FROM stdin;
    public          postgres    false    223   }4       �           0    0    genres_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.genres_id_seq', 10, true);
          public          postgres    false    215            �           0    0    images_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.images_id_seq', 20, true);
          public          postgres    false    220            �           0    0    movies_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.movies_id_seq', 28, true);
          public          postgres    false    217            �           0    0    reviews_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.reviews_id_seq', 20, true);
          public          postgres    false    222            3           2606    26587    genres genres_name_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_name_key UNIQUE (name);
 @   ALTER TABLE ONLY public.genres DROP CONSTRAINT genres_name_key;
       public            postgres    false    216            5           2606    26585    genres genres_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.genres DROP CONSTRAINT genres_pkey;
       public            postgres    false    216            ;           2606    26649    images images_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.images DROP CONSTRAINT images_pkey;
       public            postgres    false    221            9           2606    26602    movie_genres movie_genres_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.movie_genres
    ADD CONSTRAINT movie_genres_pkey PRIMARY KEY (movie_id, genre_id);
 H   ALTER TABLE ONLY public.movie_genres DROP CONSTRAINT movie_genres_pkey;
       public            postgres    false    219    219            7           2606    26597    movies movies_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public            postgres    false    218            =           2606    26681    reviews reviews_movie_id_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_movie_id_key UNIQUE (movie_id);
 F   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_movie_id_key;
       public            postgres    false    223            ?           2606    26679    reviews reviews_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_pkey;
       public            postgres    false    223            B           2606    26650    images images_movie_id_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);
 E   ALTER TABLE ONLY public.images DROP CONSTRAINT images_movie_id_fkey;
       public          postgres    false    4663    218    221            @           2606    26608 '   movie_genres movie_genres_genre_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movie_genres
    ADD CONSTRAINT movie_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id);
 Q   ALTER TABLE ONLY public.movie_genres DROP CONSTRAINT movie_genres_genre_id_fkey;
       public          postgres    false    216    4661    219            A           2606    26603 '   movie_genres movie_genres_movie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movie_genres
    ADD CONSTRAINT movie_genres_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);
 Q   ALTER TABLE ONLY public.movie_genres DROP CONSTRAINT movie_genres_movie_id_fkey;
       public          postgres    false    218    4663    219            C           2606    26682    reviews reviews_movie_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);
 G   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_movie_id_fkey;
       public          postgres    false    223    218    4663            �   �   x�=�=
�@���#���a�mR��`%��`	Y�d�0�F�[�L1?��>h��� �3�����E�������`�./;`4G�u)���+�ox�l�k�=o{$;ZM蘡��/�/�-	d;=5��b�2y�a.S��&��B
q�      �   k  x���Kn]!�qX���A�҉���m�FI������!$>��O??>^߿պ�o��/���u�����FE��-���N�#D��L^����_���� ��Y��;����%���"=@,t�ʻ2o�� li��Ѧ���	��J� �g�D�2l2М����nL:7��B.|�V����C%��ln;�����W�V{�փL��s`�A~���g��\ �2Ue���>��Hw�������R/��n�A��\cO��eH�7���Ir��������:�f�S�1g8���_�������HW�j�`����f��z��Ԃ�Rp=v\s��}�!jJ�;�j4�����VJ��pb      �   U   x�%�A�@C�r���A�.��9�����m,+ƺ�'��ؖ�B����l���d���p1wR,����\B~�[����;J� �j�M      �   c  x�}V[rW�V����b+)�!k �e��HBV�RG�,����H<<̰�{w�sN��?�7s}�O�>ݝ�=�S�r�[G����۸���]�
?��=`sk+K?p)W�O�ܟb%煯�}�l]�`�\J�n�?���K�Z�?ke��78����p��b���
O��K� 
8��¿~�������D�	"Y��D�K�Q���7��f܍��8�����*�|�����i�n���,psAo�"rS0�KKz2U��lx<��n����_�h­�~��#�(�� ��Y ��Kx7��_�(6�*X�W�$lgD�������[�&������Dq�7�G�v?:iŵ�����"����%��!�C�h��M�у)���Ű,��6�ܸ�/cxuYw�f�`4�{��̸I����V&apf���b�����|�b%�f8:����Ǝ��j�|�_�� k�k�O�q?��պ�����#�џG��[:p�ϙȑЯHa���R�yd�ϰ�a�����7��@���NTV���@a�J���4�b��oV]O��ʘ�#H@�����_Ȑ�`i�6�M���C �X:�8:n��bP䚺aqn��[�����22��W��ATҲ��*��������K��gdQ4><`����
���u��B~о�%�ǈ��eT�}�ܦ�"� '�L�k�%�鵎k�RLS���S2�b�ډ��0>���@$�uƂ��ab6���p�V
�'�F��J��2%�j��%w���H`?��!�PғcF�9��v%��7��h��b/��*؄�_�����7��j>��P���hcdU�J�<�Y�� �Hq鍿P]URj�f��ĤH����J���Le�n�d�Ś������'Pb�(`�����w��[�r�=	�/j�5d�L���X����K���}��%{#���6'۪�N�I��H!�W���ԋ����Z#���ɂ�zm�
0K8���޲�g��t�F�[�Z|"��Z�UE��֘�`ګ�����@˫��-��ZFG��ٲ��-6�4c�#7US-�3��_�}#sR����R�fȳg�*lDC��ෙ ښ/��	 �1+%����H?bB����ܫ�P�(Fh�=*�k2���Xpeŏ;�R�yÚ������1�<�eZ|��s˿MxCP�w^�)k�1�����ﬅ�Rߙ1$�ced	?��3��[ژ����z�^z�/�Ui>	�(����*��rnk�O�ϑ�5%���]�A9v�r)�n�&d�U����Uf�ڣ�<(��팁�̘'c�>�"���1t����L��K�Oi���@0>jv�M(M|{ߪ�j����*      �      x��}َdו�s�+�
�UD&jd~ h4�?��b�_���Ɇ�n�o90�����*�R�9�,jd�##�Vތ)~��_З�������lXfEF�ᜳ�����Ε[7n�޺ys�֍�ƃ��n?�ug���;�ݺ��/W{}��Y�������M,����j�����~ڏ���S���_�������Q����^��5�������ҿJ_}������Ϗq�����u��}2N�����-V������m����7���G��ݼ?^6v�x�.��i�d��d��OK��ڻ��?VO�����Z��2���S��qߥ'�
�|a��_�I����M���A�O�u����+c�Пٳ�wq?����"��-R�S�ng�����>���=�+��W/�WZ�Z���˒�NH�:�g����5.���A����ɿ�E����ӧ���ӧgH��0]1]`�}m쾽��ku���.苏�_{�WX�}{���t�|�[c7�
.V�#��)�`�����\�+j�=O����'�]����Ųz��=�gvr�N��Ki7���x�����^'ݭ�winݸycku�#u��`��/� {������Q[�����cU�~�'X�X��5<���������>WY�l��`������濽������͟7���~������ο�7���9�i�F���
����C������zz�$(i}��@Zwۏ������������gw7��=���e�\��z�ՙ�SpЬ�)[�t����
�%=C����=��o�M�ӱ}�@��&q\��w5������=Ȼ��ga��$]}�zf*F2�����5���Ԟ�Kg�4I�9�jb�}�;�s��3� {����?�_�� ޵x�ogTM�<�ۂ[���Ac��$!�%V�(�I�p.� �{boa���o�vv���y�TL�4&�G�nR��q����ay��P�TQG�v>��:�h�M=����]w�g`�,�2	k�	�	V~�35�͠�ƶ�i{L-���w���`�)^~\��ճ�@���_}h��JK��5���ۆM��W;4y��{��n�Ȥp�V���r���ӿ\S���,=�c���Pf�v��9�����}�����(�q�cϩ#?�iܱO��}7��K��t'{��*S��]+̳�}؟���L�	��G�bO��Ŝ�Po�R3H@���6=M�*bD]p���Az�g�apu�N�^����Ф���V���3��i��l��W�b��Lqs��y4�x�c��[:Bv�p�S(>{~�d����m�������&eh[ӡ���v�s���_֜��X�Cީ��.�Q�m�Dc��j祽uq�G8����B؇�=������u������oph�3]O�K_j�n���ւ;��P��Е�)�.�8��{�z�mG�|�i��3��o���rӆt`� �{�Bw�F��چ�O���2�I���ӴP��N:
-�D��p��}�з�ȧs���1���ݵ�J����9��u�MGqt;I����Tfo$���#_d��6�}�).΃|����@�"ƾ8�̎�`/�c��YRV'<|S��ҴnT��=ߩo'����Tbyw�Ea�x.���.��7?��w�H�O��Bj��i�Ni]P��C�Z���-w~Ժf�Q>�j�½���f}%���Zai��Nt�m�؁1]5�\@B�����z��ܙ/=絿�7>������6���tK�ä��`�ʍ��K@'������3,����<�oⴻ�VV)������t��ZE�݁U}f�Eg�L12B�x-��FA��i��}:V'd��C�����
v<d���.l%��w�C��3��K�ѐ��C���Y�N�cۢة�_�k��4Mm�g7a?�6,��l��{��u(�,j-?���aĻ���и����u{�׸.����=�n��\^�S�QUÄ �#bf�a�����хz_�g)4b҄Z�S(�'����U�^:&����l�Se���*mC!4�h.���?-5/.\�Bl����VĜf^7��M&�.]����4�aaV{������X�]h�8�B��ί��ui4��^V�bN@�`|A8�M�+�J<O4�ܿ%�1�+.p���N�,"�%��g���[� B@�|"��&<G��"�kh~�WkKPp uh�# a�B�(U�.����`l<�:v�~xf�$a�����I�5��"�ƃe�8��zCG����c�/lW�A���9��V�����5�ҼP��̈؋�+��ٹ쎠<[��n=B�F:��O��v��;��|�&��ǸF�.�����٩��n��-�e�GZ� ��]a��@�2Ǳ�m}5j�j���� ��$�gu�����]Gy�ܝ�[��[p�iGw��X8;Ln"f��������]�-.}_t��i����p��H����y�H�7v0�57�l��:��$L�����g)��hKj!�,h{�r����տ����w~���w����?���?}��J����V�����7����?|�{�)a~��1��A�5_�ekIQ���^�i��0T����C�`�� �l+�d��n�}��kwy�۷޸�}�ރ7_�ҿ���?��G�;[����h��ǩr��H����;�"�4m3���	@p+����#�V�f�!C?��N{�Lǎx ��Y�	�X�V��%0k�
xδ�.^���R�9W��	�X����GZ�YQ�鬿�5��s��0C�Zš_�ƚ4�%�+� Q�	��`	��-V�a����P���v���z��<&��|\<�X�173Een6hn&�^��tY��$��2	��n��^o��A��0#�h��+��U���0����j�̛|��e��;��E<���	����K��W�elή2��2������^xF�����C-���wpA(��q�0μ�I����aN��y% ���ZA����c��S�@��ºtZ��Wv���3ā�'�>�@��H���x%D
i>Ʈ]���z��+=+��&���{n.�Z�P���.5��F����1v�l�؅�bO�ƭ���N©�Rx� r���a���g:�]:;��-loo#A����)���?&!�-#��� E�]� �۠ۺg�� 	�kxDÀ@v�E���t8�/,��$}���)c��Oܳ$*�y�9��� ��%����#��/M�
�sp7�s��}��EDf�)D8B7��;l#xfo��Wgэ�~W��N�9��Sٌ	� �~�(jŃM����Z���h��N>�?m4��	,B6դ��!�3�Ӱ�06��p��X_g�]\�؏q����%��s�~�\��ŧש�qk�Q,�*�I�s�3)�+	;w_�V���x�sX��ij�=>��?�F�0��Ry�c�ĉ���Ƣg�Iؗ�ig��� �҇[�ƅ�ᬣp�� �I2
�	2c�����O7/l Yi��y@�ԩ]-"��cW\�2J=��`�y�m�����-Z���,�E��)�ᗣ�5
��Cc8�V�.$,��Z��/,�1�[x@�F�Xa�.��+?���/�����8�fM��^M
��N5��՚�2?����y�<=�;��c��]����SJ�B�v,E+��������R����µ��#v��d[��49��e
��� ̆�-�����[���)�G:��
�i��C������X3���1��6��lb��O�]�J��,�0N%�%dN]�*_��\��c�����wJg?�����
�?1��9��c�m;��#����Ɇ���V:���JUL<�hn�M��~�z^ ��>#��������x:RJ��U8����ƭr�1�#���0�	$(�������AaP�:������Y@D�%����0'�.<G��x�C����bI�_�S�r}MJ���7#������:�ݗ���2�q[��e
�IbRx��q>���+}���}<�#�N|��/ph��0dU���u��$~9�/|ֶQ�s7�9٨�m�>D��зYϹ���_�1{��5?y��m�{��~��    ���}��!p����������+����%S�ȢUy=W%;���D�e�ޭ��==���לV��t��7h�g��<s�!�8$���t��aJ�:�c�oV���3N��!�g��9v�ڻ|6*��Jߣ�
��!~�h�����g�5)b��
v\�W�l��~,�J�.�}",cB�z�����2���u�b��읏̡%n uZ"]��`f��Q�؍�Ӛoh
�=�zvu�>E"!ŭ�2,H�~A�`
g��3/;
`,W�{s�呖Y������H�a|�a�3��9�,��o)廋�����(ĩ�}{H.�|JO�����0=�Ġ�X�i���v�=�Op��5�z��*�=p�ld��[F0;��x`���O�ֈ�Pɑ.j���ع��/�2]��k˳�W���o��C���N�<^p^|	����t�E�`���8�k���@�_��7*pZ���}�c[�(�
,e����Ԑ��-7�rE�VA�KA)N��`��2�0�c��Hr�Y���kf�����x��4F�x���~E�ҕvX�5���Q�Χ�e���vMl�wQ�%��|*=p��
d��jP���0������f��=�?���l���]Ť�����)E~c�=���Q����]&?���4i��=|1D�ލ��R��*�M��mZ����BQ�
G-�.��ir�[e����z�m��1�C��ɪ��a{()��.��0��?I�De�6y��+��'��p{��`��rL+ƌ���%�&�����d�Y�g+�uv��s�� ����""��ʸZ���M>Nv� 3�yL�\0�-���	�+���Hu�C�e�S^gN���)u�,���* �P�,�1��?^��D�^�6�$���t@&:�\<;:9��%�m�d���(c�˅ �s�<8y�^�8:��Q�hXfg�����B�;7޺�}���n޾�\'ͅ?��> J<.���k���`"?v"�!�(D�:�_r��$"�2$�z���bT�B�O*�^���"4��Z�/�G,��"�5!�:����A��7��̜�{�"��\�:;^R��G��i�/�H@Y��]�1�����WJ�_�n�����Ē�����)9�v��ٰ�9ޓJ��c��T����[�B��*�*����BpU����_��n]w��UPP���J���
�i��)���ܮɁ���E�y^�^�m��� �0�5�=���#���R���$��KYE�Mi�4��)�6V��V�^@��yN�!�Haj��Ca,�P9��*w��g�j�<�0����N�?�QȐ�`�3�y�j3/�g�~��m4|���A0�*�����Y��3\h��0�ta�N�CI�3���׽7堶��n�^�e�A��L�x}L�h�O��`�t.O	!�h���l���g����5�VkD8��}�4��.��O�Dp�4��ۿ*��
�����ufm�s]���.����Ñ�^�Gq���$������zI�|��+�Wѫ�˥�7�F�/c$҈���	�mT���e��Ï��u��7ba�Tj���NP��pwaW�QD;hC��ZJ�B��'���C��@q�ϰKy}飇�4.��?n���u�Hс�t�KZ�8�}�^��?SLSf
ļ�#�9E�=�|~���Q�Q�1��"n��Y�r%`���nlu�lS����j�(��
���+����T=������&�i��aAZ%}���TS:ʹ��s�VI�~���1��S�-a��vk���X�*3����݄\�:<63�N�γW��j.?�APw#��+����Z=�_b�u�����}���F��1�y8�+���y�R@n�O��̬��O��֕ϙ��W�U �j��غc˞�ܬ�
�vvi[p��0d��d�&��{04&\��	�R��D �H欩�`����w���u)V rZ�,,j��*$�7;��Q1��3_�s3Cx��u���p�2G
2�s��"�\��S�|��c|Y��e|���DX2��B��i���XO�+Pl	���Fuu'���R��K�� �8Rp�i��Ci/��������$!�l�b��و%C�9�z��#<֫� ��$�H��G}�;�n(p!;�s,�x��ْ&���B� Hb�z���v��L!�tr������0����~H?����~QH�]��{�IK���/�!���G�$������gM���I7���\u�-��F���
�����/��ڭ|�R���h,�vr��-�W�e,���?������{���t��X�ޢq��2���.L��ު��lһ`HɾQ�0\��G�ZH�$GN;Wذ&���+_�1�ܠ�<�n�*�"'��鄚�T��c�t ���A����d�d{Y��G(�*>c�"����*K�f�����O3Ż̘���9ڃ��}��k��@�͇��m߻s����W�ϡ����l�f��^W� �ax��xؒ���)>c�ծ��MP�L���
n����&�5�V�Vc����^
wTv���ȟ.�rNv�%��\N�؅gei�㷤Z>_�SNڐ��" ����JH-��`�B����G��$�GYCzh.G����(.xF����t�{.�:y_��� ���*"�	hg<�U�!�yΕ�c�	M��k�Y��a�g
vM�L�?���蚤c�HGx�U�Z=;�8�W��q8C	���W8J���mqp	�(�/ɕ/�+w��*�P[X��<��Ս��r�@a��YYV����>�6��9������	W�'Ӏ��sg�[�|5��2�@�L`�hq�-֎1[�jn���������I�:m��59���){�٣�� ���� �S� H˝��!lT�$r�<�����g���6�)eC�Կ[G�l�25*ae��?BX����Bǚ�Ȼs؇c��I���$�t^<a�m�6�*;�
\����h�0��� ��Lv���� 1�gu�����)�TFӽ����P? ��N5'���Ns��vyPE,���sUA<�[���Z>�k���B���mh����|�� .$S��d,J���񀩵簶�� �?ݼ{��5+<=�W��5C������3�v�'u���]���Hݻc\e�x��Z�1�����{BQ��FԁWŬ��N]4$�_��TgX��M#RDo�yqح-��C�I��������(!����!�)=eٝ�H�}��:``���.����|��+�$��=�z5���*{fX�>�*yՄ*4�/|���K��zI��Z���ui�ač�~}$�ǥ��&�YT6ۋ�^_ࠅ묺��Ǉ�����;�����d�-�HGM��A��E�.ŞC<ѝ��+2��¡�J)�XA-��PVS���G4���p-�k��sۜk�?E	W'G�S揍r�5�����S�k>���n���������1*�O�z�b�2&x�+P����Կ�;�>-g�d\Z������U̼���5a@ ��Nod\�ɦfs5����L���Tg!��Ab=�&Lg@��`ݯ��}�pi��W}\��{9�}�m ����d���s}�F�"�E�]�k�(�bBG>g$C'ȳ?��{^�^��Iқ��|��zl&�����h��)�#+=-�_�Ռ�.R%��|��E�H�.)��T��4��"N,��ߐb�V ՗j��0��<�c_����O�(�r*3���s��	���Օ�'R�4��BgŤTT�?>t�sUcy�b٬��B�+y	�&�;�� �½�"��*v^P��脚<���{n�7���;PgFCo�2�[Дz��� sOi�\V(�Ie)�Y����n��ϠY�_6��}ԅ[`(�x��Br����3Ђ�QN�=���}�n�̶��}-rDLd����A�]8Q�O+��_ۿ�]���W�(�ǆ!��0�,
�^�i��!u�3����h,h�]LR�Ć�Q��F�C�N�ez��+H�(
=�r��D�z>���:Px���+PE,AA�^i�^�A��UD�    �2Ul~I ��n޾�x�ݘK.E�Uִ�8�����S��pY4]�k��5�L�<ц-(����w���Yw;:j�j|�rEzTz�抭�p�Z�ؑ��).�z/附Θ��n�M"Xz׵�4U���Z+B�ex�N��9�i��?ekH�)��G��<hz xՉ�-R��䧶���{�X�rXcdQ㧗��0��5��*�(i�[�;�o=K<�H��R�9�%O(��dc@	�]�LP�2)=zL�Iѩ8�
q0��虁5~ʂh/=���9O6�ـ��0?�8�NC�
Y/ �t�[k��������(0��L��J�q����f��R�����Zm���	XO������Q�j����0rO�)��Յ���o�7��R<�h������v��*z�l�S��D S6��2/m)$$,������;?��w���?���������Xµ�
p�t�<�ҿi��G���;?|�G����;?~��w�k�s�?{���FQh�Q����
a��E���I!��Ɩ�{�ۨ�Gl�)�A4���X���o�ַ��~�f�"�����o�x�RD��ݿ}���2k~�hg�f�{����e�D��o�wJ�Y�}�ɉ�sb޶�NXM|�罸*n~pU�Y�~�S�!OE��ݘ�tv^Q��I߯�!{�
�)�uH��RV�l�Ӫ�[�R�^1���N�m���r������9h
'(�;�o��"��s���E������+���T+/R�<4ްk��$��l�!S�������2�!;?n�m����mk�)��~�o��A6�	�Q��&`�EO�r7u`�7-����`�z*�֐�]w�ͬ�v�('�'e�5���ʱ�"r�9p���	 $#<"Am
�Bl�f�bsi��Z0 �s}�C}�A��W�Z����l��/p5�a>�Dq���h��4��ܠ�)���m�W:w�;���߳�g��%�`�H�����Z1��*פ�NO.�բ&���R���/6in�-�\Ů��lQQ�(+5�C�. ]?`͙`�tͫ+�:B��NRW#�i��K�苣��J��q#�X�m��Ee#($%���9}ax��8�tg�}�������X�O%+�a�.̽����O�5�_l5ʂ:���;*��4U,�AS|�W4�I~�9�y}
�$��"��'P�a���,�XD3�
3� �Ձ�R��~Z�����ep��\w��:F��0$k�����VV�U�V0�sp�LY�es>z)��eMP���
�[kW�Ӝx��.�fnU�g����/f�y�CT�^�,l`XfO�U?W�ΰ�.�Z�GoBz��z�.�Q�N �eb��Ϣ�H$��h��������A���.Xz��!�و#PQ⻜`���UI�.�Ve��,����S��hy@���=M\Cq�̛�6��6'e&hP6�Rɢ1v� )|�6�^\�b�Nqi����Մ��E#U~��c�_u4�,���CV�\_=�ASG8�2nVAH�B�gW2=�/�-� r�ϭ!O�'��E�`F�E�1qm�Y��(�s�Է�V��ҝ�N�Z�k�RF+�������F�+R���.l�f]��Md'�X�R�FR�a�G��T�\�T=4;!����j�	f��L�a)��_���Q~��9�U&��%�p�m�&9�6c`�O.U݃�i�o�;�$7��U�*��E����v��/IGv��,�pɁ�'�'gp�2�,�\^y��r?hD�SB{O%�}��@��e���� �q~Ł�Rzn ��s?�2������q23ͳ�Q3�cAs�W9#�EcO2��m"�BPT�R��&�<� Æ,�T����`k�A[e��<hIw��b헑wv=���o�\B5�,����$I
gW��	��E�e�J^�߅&дT�r���R�w�����ݙަR���\̨�̏���tBu�01�ȼ̆Я�U2��u*Ń���HN}8�k,�c �q)r�{��.�	�F��u��צ@����3���GE�٥���?1���ʜ���5�y_\�(��&~d.h ��n|O���"��Q�9��w
F\Q�%�/��E�8�"|0���v	�ōo�W���[�_��� c�}��;����}��o���j��I�
��:3
��;W�I	���anc}@n�q��#����/�v���E����rU����EQKʼ��ߑنbۍo�_�_57o���XCJFq[��SK4�K������>�����Ek�ߤ�O�XR�:ps��(h�2�������iث�wx���������w
W�A�bj8o)⵷ckD�E����z����~�6����.�H��|d����e����˴�ע����~�~�i�eч�E��l�����k�J����o����  ��gH?RY�-C�Qs���U�
�p&Ơ�A��n�U�<��y����t!�ޖ���O�bN(Tۍb�Ǯѫ���j��SՎ /}�hp�Q��\�Ű�/�+5��nm��+pU�o(=����K!�U�T2�,piݮ�<�2*��4�䘬�̽q�2�6�),�� C�a�6��/5�>h�9���i@�	��$2����
�����Z7ҹ�Ѐ��e��6y7_�iL��װ?FٝF�>��H�w�߈�xI8���Yg����S��ߡS��q���ݙGǎ�Er�_A�f�{_��Ӗ<��,��A#��-���eƷ�W����OԎ*@��y���4�Q`%�6�(�R�z��2�T�'A�o�� hD��Ϙ*ȏ��C�#�81@Ek⹢-:��V��P��%�X��x��E�I�p��j/s��`�:�zH1Nv�ܳ��,�ɝ]��X��m*�Z?)�������L[w�N�?��鬍Y��Um1���<�@��I�e*�d�s;�(*{e&�h���vhW~Α	D	�lU@3o�a[�)t�)\FO�����b����
g�)���~Yw�u��]�(��U˳��Tl��mI�Ts.�ve��=�>At����[��Y���	�G>K	����\�ȕ��,��6��&�3y�p��`j�p��x�����{�� �*����j�zqH�o԰þ�eH��)�=l5ȍfKz�t@e�~T�X�|�=�׎H��l=?Vj~Z��fg��ֺxR�G
�;�]v���xPI���m(E��[J��2�ܿ1e��^z�~i��~��4�ƽ�S��<q)����wߐϷ)���e@Ⱦ�&�^}G� ±��r�>;�]�צ̅1��Ľ#F����l_`*�F`0.��t��f���%5.|�2.�cvr4�@ErJ�0���e}V{n8�e��i��7�hY�/a�z~�%Q1��!�H+���)� �Q��ٖE�� u�Y0�ʺZzc'�~��7IN��]����s�=5����5~�3\���ʃ�;��V4��d(���+8
+�vĭ�U��g�����Bz.V^W,���<ƭh�ֳ������k�� 	��V���Yd���t>(F���(*��2(��h��-�4�����ԮYy���7O6ZV�*㪢�D��!D�6��!��m�λ�(�ž�c���6{���<e��׆�B�9d�S���ڸ��	��%�_8.Y�s�� ��O�YxNo������,"����d׸#�#|>+�<��,#P���Zx��f�oN����)��A�)+Հ1a�q �ϱ|�^����Tp��9&�묚޽M�jEm3M�k��ª�y���o���1�������b�y9	��R8�is9��ksYD;��k]n����+5�~Ð�L�F7�U1:=��]��46��al-8�G�I�߬���T�QW!���f.�^��&0;�@�in�4������"�O����,�G�|�ǰ�~��>woe�
�R��vsˇ���w�Z�܍�%���^ΰ�:�R����Y9�	j�*���qY��}�֝�n�b��޽�}���w\I~�u<ǜ�^M�����K-�<����QIFc���i��5x�G�<�c��1�ٓ��V��.����J�ã�}X2�� �h���Mp\q�x��e��I�G��    YlB�`�ǚBi
^P��N�7ϽZ"ϝ���a�NN+���A�צ��+�eG��}*�����Ѷf3�X� ��KcxK�]q����aw5�s��a�Y����ցI�e��\�����b���C�^��w{
�cn*���$ͤ;n� !\��h�]Y~���fL�=y�m�{�X-�б�~\٫���0��S��2'��������Kس�F]����
��Q���z�q���+Z���^�F����%n�� ߯� 컯�y�b�!�؝)QP�?�٧Z�ǘH�դ�!BL
WtT�!@Áo�5���g����
�^�4P��Kv��S
�Fe"��2Z=W+�=�su�Y25��$�i��
Kj��<	��˄Ӝ�b]�ԁ����@53�K�%Z�]�ם�󁦊�,�������ϊicS���D��#E�fϊF�E'r7p�
���*����6�t�U��ƭ�N:G3�?�1X�MV�J�����1�AF�3g��gP&�Ҿ�Q������kv3������$>1����׃�>$�q�FM���#B�� Gv����/�M�:�Z)�%����B�8������/m�rGS?i|���J�&�?���G'm½f�����t}*f8�%��M�\@�K�}9��qu�,�S?C׃��*Ȼo���l�V%o����9c���ݤ���/)3�e��Pz/
ȱ\[�HGM�5����rz=y�>�ޛ�$�r��7�g�N��y�)e��&�H�|v�m���E����FJz��v�J~Y���l.,+��C˗���Dt�(;1°j`f��I�b���p�֘�5g���$��D� �.�
�?e�"vu�O,�B�^P��a�u�͉�XV��ZpQK�=��Ε�uhA��g���7��K���DIy��3+���I'�#V��F�������
%�����K�P�B���mEhc�-���3�+�:�t�h��*������"����f����F���	]U6�^`����XLb!D��&d�Տ�&`0g��e��Wkh����?��?�[ԸZٱ:[���4s�tu϶��*6N)�u]ɌXnl��y&�e�U��F:�Io���'��R�J��n�N)������|�(�e�����ʚ0���3�D02
�=��G��1���"�\�=�,��h�� W;���t�`<�еw���{@���+��v�� c�s����7o߾q��+�0@�|Z��L�����͝w"����(����g�4�WB��J�
7����.�@쥺.��ږ٣��	8�F��`LeK�?���	ü��~�p�y�Se�g��[�xNd6��xZ�+V�q�g6�`�Ԯ.��
oI^+��z��'�F՟�齒d�0�w}ԳU��ő([��fY��6}1>���� P�몎M�L�乊 ��'�������k�&����p��կ5B��+��^Ik�7N!������`�б�D�>#"�/v�����Rc��"��I3өe��|�N��Sх((�u��_��z�zt�[�����WF>_
�0��OEEi'������l;ȼ߷˵����>s+"<'��d��*��T�(�!�p`����#�7b鐾缨����)�8Ҳ:�,
O۸�!B:��r�{��i�]���}��=���#�GVn�;'�!�kB�vҖ��V���ί7���]E=��O �g̳��ѫ3���5o�_f�"ۦ�4�^5ôcA{Zf�&�u1�����A�ב#>!��:^R�8ϷU+���x���=�V ]���b��Ӡ��I!}�ԉ2┃$�O9�(2g��H�e��_f�`W�v��.0}�5��w�;���;�N�Y��ZŇ�v��҅E���W�R�,�kGޑ��e3jt�dfj�!���7�;�A�J�M-��Ǆ������R��"k�W=�V1M3��v�tJ��F�X��Jb�}
zZ5���hC몑���8�E
zr\3vh@�{eWwY���,fs�2ƙ�G<_��}χT�e�],Z���R���М��x=�_(4)��kӫ>�qЦ�� ���/�U��h��
������+�Hld��
������a'�RQG���F���x"��tcN	>ך�I���O�C8���0A�-dչ���-�J-��b�@��!�d8��UZ��j2��pHc�M�C�f����R5���|�+��v��0dy���[�w�~��H}�LON�D�n�䗌K[��U/��I�I1L|!������wxg8�Hw9%P�>f���J�+v�?4�$߷��^(������.*�I�Ĝ� ���A��"/�EI����V��+�TТB��ŭ��{�;��pLi���>%�6RV߸;*���m1P�۟\_gR�C0�B����"{���{aRv4�0��Ⱦ˳n�Y��:F���D}MQ�]���L������X}S��ݘ'�>eb�`�T�B���j
�.z��g�*�����1L'-i��b�#��#�J�A?���F��?��<5[Z�R".�n���Z�����3����H�D"߹#獲d
w�Yˈ
�BV�W�nˣ�c�հ��Ǻ[���`��;"9M>�rk��&��#U�;�ݔ`�,z�=� G^x9N���@���I^E*O.�7R�c�6�ߵd��)��Ǌ��+c���e�J�}N���U�4iV޺�i��5�a�#�)�т#�5au��J������{�G�jLѫ4��@�6\f'Bڙ���
����~�c�>Ok��^��_B��1�;}�sh��Xn�_C�����,�8C' G�ӏ6e��!�ռ�{kSD�/��ɔ\6 9��2)��*=/|�U��g����6l}N�^�Wpۘ`��߱z��[�њɄbA�Z��U2�"�)䛵E�s���X@�ڗ`��C1�6�+A{t\q2�*Oy�J�l/�Y,�����v$.�ǩfQ��2��'^���Y��U:��в���$lF0��yw�e�_���f��$e��&�/F����\(auM������s�U4�x���
դ�(Vண��ՠ7AIJ����k�(�>F�.f����������J��ϼ_�\��<*9�R���p���>SY�A��=[����k1�#IcD�&;���}+zb5\�O���r�����生�^?j���'tW����G�*��9��ۨ	!}���`N�S��6��%Z�>�Y��T�O��G�l#B�q�3�$Sf��&��M�<׀�9���Q��w���"�͜����%��U�ZQ���c�3�:����о���L]�M=\`P�U�4H��",��6���agHO�Ѓ7NO̡wVB����"c1�/���ٻz��7*���� mo�5񒕓^i�/������9�p\F�E[��������h����f�6�а�'=�<�H��Vp7p<k���PL�\�O@�=D�M�ő�Ͻ\SRӫ����`$7J8t�f����p�S��áԓ����?{��m�����[#u��bڡ�?:ë_J��,\y��)��{a.��v�ܮ�g�m�����~��5K��>� �aS�ڵYUS�4o\��q/�s��?�)�e�� �6�	�j8���Jc�T��Lt�'a��Co��>��{d J�(s�T�pvxa#/��t�����kn�����+-���H��!��d��P����4V'�I�^��9ƱFBPK��\��o!��C?5��<�@��\��A*dF�撋"aG�����t�g�x�=�y��@ �MB�A�����,1���.��9��O�Ю��V���U� ІКD�)p�	-/�?�!� ��'���q�a�_牨�N�Y�o�$|�ۇΊh�Á�op����ɪE���Go\w���Qu��pʽۈ��^5#�z٢MpG�z�u'�#9��~j���R�M�t'$��������rt�pB�!W^�ٯ1��r�X!�>{q +7&L�����]��������]تb�%�>��L��������C����N�y6:ߣ�*�=U��3�������l�@��5>eĚ1�O(��¤<��-��Q2��J� h  ��&�N�hJA$+Z��G=�'�����FqUTU��J��y��5�E~�Q��6�`�m3�1K��l ��S���/�v7+���ع���q�QW��+�U8��U�L�Wn��ڭì����oo�y�֭{�����Y�I�0�AE�H�c��8'�u�
��\��l��W��iݣF���GΉW'd�+ǰ�ʑ�ž �Ze��I(rm/4�^��2]��\a�t�Knn��d�`�]�4m�O�!�C�]·�>��8;p>;a��[(U�.⩣��2��|�ѳ:�����XI��m����J1�ߨ�����=#rY2i]�\�Qv�M%�l;�!���
�ҨL	1�����0�hS��A&����$��a��A-�n�f=�1ɡ��IP�*k���'Ǘ�d.�lp��m%�:�P��Ȼ��"�	����T�-4ҫ��j�x�"@[o7q� �X�gyX�����j*�[Y�OcB��z9�b�����7�'����c�/A1��\�EL�rw���#����b ����h�Ӊ4OqGxZ��t+|>h���|��s*Z�e]:���"di��ۗ���Js���+�?�^8��/��xm����O@骖�FAs��c5��b��I9�~�g������U�",�J�t�K}��-JTJ�L�+��m=n�e���%r�̒���W�s��]��UM� *U�œ����<w�t��&��
q}Ag\� ,F�8e�2��h�a"��8u��p)����[\���/]1�yu���q$�5G���!|���о�Ӡ0�Ս��C�y��4�`Ko��\Hc9zd|�3���U�1L���� �$�ϯ���Љ�*� �z��\�9zW7�x�����aZN��I!�ؘm�I'w,e!�^M�cAsy��W��?!���&��9��a�K���x���."a?�2x��J�H{}��Wh��v$��/[r"D�w�����+�wW>�/+�:��Lp&�6[�5G�'������>u����N�k�{�m���o���<���	E��<lDW5AVz�_*�\��5��ُ�h�6"�l۳�lY\zЊ}��ݶ���ԇcl�""�
��j���j��W��_`����`������83gE�,!����zG�-Gr���(��R+(�B���Sᐓ@�ʮ)�6�r���z*9��"Xz>T+�l�E):U�3S�='�C��S��xk��M��%����x���b�j�0���Kk+���!�	Zx�^�/g�T�2дn���$hU q� �;�������M�Y�bX�t �����~��<�f����ѐ�տ껳��}~�F�r�b��*�;����/�l{�+(���Wn�{��_{������     